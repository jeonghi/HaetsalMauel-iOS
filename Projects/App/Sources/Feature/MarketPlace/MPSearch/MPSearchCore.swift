//
//  MPSearchCore.swift
//  App
//
//  Created by 쩡화니 on 11/28/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture
import UISystem
import SwiftUI
import Combine
import EumNetwork

struct MPSearch: Reducer {
  
  struct State {
    var searchText: String = ""
    var postList: [MarketPostEntity.Response] = []
    var selectedRoute: Route? = nil
    var MPPostingReadState: MPPostingRead.State? = nil
  }
  
  enum Route {
    case readPost
  }
  
  enum Action {
    case onAppear
    case onDisappear
    
    case tappedPostCell(Int64)
    case updateSearchText(String)
    case setRoute(Route?)
    
    /// 네트워크 처리
    case requestGetPostList
    case requestGetPostListResponse(Result<[MarketPostEntity.Response]?, HTTPError>)
    
    /// Child
    case MPPostingReadAction(MPPostingRead.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        state.MPPostingReadState = nil
        return .send(.requestGetPostList)
      case .onDisappear:
        return .none
        
      case .tappedPostCell(let postId):
        state.MPPostingReadState = .init(postId: postId)
        return .send(.setRoute(.readPost))
      case .updateSearchText(let updatedText):
        state.searchText = updatedText
        return .none
      case .setRoute(let selectedRoute):
        state.selectedRoute = selectedRoute
        return .none
        
        /// 네트워크
      case .requestGetPostList:
        let filter = MarketPostEntity.Filter(
          search: state.searchText
        )
        
        return .publisher {
          marketService.readPosts(filter)
            .receive(on: mainQueue)
            .map{Action.requestGetPostListResponse(.success($0))}
            .catch{Just(Action.requestGetPostListResponse(.failure($0)))}
        }
//        return .none
      case .requestGetPostListResponse(.success(let res)):
        guard let res = res else {
          logger.log(.warning, res)
          return .none
        }
        logger.log(.debug, res)
        
        state.postList = res
        
        return .none
      case .requestGetPostListResponse(.failure(let error)):
        logger.log(.error, error)
        return .none
        
        /// Child
      case .MPPostingReadAction:
        return .none
      }
    }
    .ifLet(\.MPPostingReadState, action: /Action.MPPostingReadAction){
      MPPostingRead()
    }
  }
  
  @Dependency(\.appService.marketService) var marketService
  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.logger) var logger
}
