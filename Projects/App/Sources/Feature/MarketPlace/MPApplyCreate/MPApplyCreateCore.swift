//
//  MPApplyCreateCore.swift
//  App
//
//  Created by 쩡화니 on 12/2/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import ComposableArchitecture
import Combine
import EumNetwork

struct MPApplyCreate: Reducer {
  
  struct State {
    @BindingState var postId: Int64
    var introduction: String = ""
    var showingPopup: Bool = false
    var isDismiss: Bool = false
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    
    case updateIntroduction(String)
    case tappedCreateApplyButton
    
    case showingPopup(Bool)
    
    /// 네트워크
    case requestCreateApply(_ postId: Int64, _ introduction: String)
    case requestCreateApplyResponse(Result<Box?, HTTPError>)
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        state.isDismiss = false
        return .none
      case .onDisappear:
        return .none
        
      case .updateIntroduction(let updated):
        state.introduction = updated
        return .none
        
      case .showingPopup(let showing):
        state.showingPopup = showing
        return .none
      case .tappedCreateApplyButton:
        let postId = state.postId
        let introduction = state.introduction
        return .send(.requestCreateApply(postId, introduction))
        
      case let .requestCreateApply(postId, introduction):
        let request = MarketPostApplicationEntity.Request(introduction: introduction)
        let publisher = Effect.publisher {
          marketService.createApply(postId, request)
            .receive(on: mainQueue)
            .map{Action.requestCreateApplyResponse(.success($0))}
            .catch{Just(Action.requestCreateApplyResponse(.failure($0)))}
        }
        return .merge(
          publisher
        )
      case .requestCreateApplyResponse(.success(let res)):
        guard let res = res else {
          return .none
        }
        state.isDismiss = true
        return .none
      case .requestCreateApplyResponse(.failure(let error)):
        logger.log(.error, error)
        return .none
      }
    }
  }
  
  @Dependency(\.appService.marketService) var marketService
  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.logger) var logger
}
