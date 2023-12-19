//
//  ChatHomeCore.swift
//  App
//
//  Created by JH Park on 2023/10/27.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture
import FirebaseFirestore
import EumNetwork
import Combine

struct ChatHome: Reducer {
  
  struct State {
    var selectedTab: Tab = .내_게시글
    var isLoading: Bool = false
    var currChatRoomInfos: [ChatRoomEntity.Response] = []
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    
    /// Custom
    case isLoading(Bool)
    
    /// Network
    case requestChatRooms
    case requestChatRoomsResponse(Result<[ChatRoomEntity.Response]?, HTTPError>)
    
    /// Child
    case setTab(Tab)
  }
  
  enum Tab: String, CaseIterable, Equatable {
    case 내_게시글 = "내 게시글"
    case 이웃_게시글 = "이웃 게시글"
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .send(.requestChatRooms)
      case .onDisappear:
        return .none
        
        /// Custom
      case .isLoading(let isLoading):
        state.isLoading = isLoading
        return .none
        
        /// Network
      case .requestChatRooms:
        let params = ChatRoomEntity.Params(
          type: state.selectedTab == .내_게시글 ? .mine : .others
        )
        let publisher = Effect.publisher {
          chatService.getChatRoomList(params)
            .receive(on: mainQueue)
            .map{Action.requestChatRoomsResponse(.success($0))}
            .catch{Just(Action.requestChatRoomsResponse(.failure($0)))}
        }
        return .merge(
          publisher
        )
      case .requestChatRoomsResponse(.success(let res)):
        guard let res = res else {
          return .none
        }
        return .none
      case .requestChatRoomsResponse(.failure(let error)):
        return .none
        
        /// Child
      case .setTab(let selectedTab):
        state.selectedTab = selectedTab
        return .none
      }
    }
  }
  
  @Dependency(\.dataStorage) var dataStorage
  @Dependency(\.logger) var logger
  @Dependency(\.appService.chatService) var chatService
  @Dependency(\.mainQueue) var mainQueue
}

