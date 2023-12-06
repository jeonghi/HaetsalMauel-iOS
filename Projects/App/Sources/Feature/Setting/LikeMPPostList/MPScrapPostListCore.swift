//
//  LikeMPPostListCore.swift
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

struct MPScrapPostList: Reducer {
  
  struct State {
    var myScrapPostList: [MarketPostEntity.Response] = []
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    
    /// Network
    case requestMyScrapPostList
    case requestMyScrapPostListResponse(Result<[MarketPostEntity.Response]?, HTTPError>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .send(.requestMyScrapPostList)
      case .onDisappear:
        return .none
        
        /// Network
      case .requestMyScrapPostList:
        return .publisher {
          marketService.readMyScrapList()
            .map{Action.requestMyScrapPostListResponse(.success($0))}
            .catch{Just(Action.requestMyScrapPostListResponse(.failure($0)))}
        }
      case .requestMyScrapPostListResponse(.success(let res)):
        guard let res = res else {
          return .none
        }
        logger.log(.info, res)
        state.myScrapPostList = res
        return .none
      case .requestMyScrapPostListResponse(.failure(let error)):
        logger.log(.error, error)
        return .none
      }
    }
  }
  
  @Dependency(\.appService.marketService) var marketService
  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.logger) var logger
}
