//
//  MyPostListCore.swift
//  App
//
//  Created by 쩡화니 on 12/3/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//on

import Foundation
import ComposableArchitecture
import Combine
import EumNetwork

struct MyPostList: Reducer {
  
  struct State {
    var myPostList: [MarketPostEntity.Response] = []
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    
    /// Network
    case requestMyPostList
    case requestMyPostListResponse(Result<[MarketPostEntity.Response]?, HTTPError>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .send(.requestMyPostList)
      case .onDisappear:
        return .none
        
        /// Network
      case .requestMyPostList:
        return .publisher {
          marketService.readMyPostList()
            .map{Action.requestMyPostListResponse(.success($0))}
            .catch{Just(Action.requestMyPostListResponse(.failure($0)))}
        }
      case .requestMyPostListResponse(.success(let res)):
        guard let res = res else {
          return .none
        }
        logger.log(.info, res)
        state.myPostList = res
        return .none
      case .requestMyPostListResponse(.failure(let error)):
        logger.log(.error, error)
        return .none
      }
    }
  }
  
  @Dependency(\.appService.marketService) var marketService
  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.logger) var logger
}
