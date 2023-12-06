//
//  MPMyApplyCore.swift
//  App
//
//  Created by 쩡화니 on 12/3/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture
import UISystem
import SwiftUI
import Combine
import EumNetwork

struct MPMyApply: Reducer {
  
  struct State {
    var myAppliedPostList: [MarketPostEntity.Response] = []
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    
    /// Network
    case requestApplyList
    case requestApplyListResponse(Result<[MarketPostEntity.Response]?, HTTPError>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .send(.requestApplyList)
      case .onDisappear:
        return .none
        
        /// Network
      case .requestApplyList:
        return .publisher {
          marketService.readMyApplyList()
            .map{Action.requestApplyListResponse(.success($0))}
            .catch{Just(Action.requestApplyListResponse(.failure($0)))}
        }
      case .requestApplyListResponse(.success(let res)):
        guard let res = res else {
          return .none
        }
        logger.log(.info, res)
        state.myAppliedPostList = res
        return .none
      case .requestApplyListResponse(.failure(let error)):
        logger.log(.error, error)
        return .none
      }
    }
  }
  
  @Dependency(\.appService.marketService) var marketService
  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.logger) var logger
}
