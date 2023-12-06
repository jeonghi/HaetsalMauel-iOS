//
//  SetPasswordCore.swift
//  App
//
//  Created by 쩡화니 on 11/14/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import ComposableArchitecture
import Combine
import EumNetwork

struct SetPassword: Reducer {
  
  struct State: Equatable {
    
    var initalPassword: String = ""
    var oneMorePassword: String = ""
    
    var currStep: Step = .initial
  }
  
  enum Step {
    case initial // 초기
    case oneMore // 확인
  }
  
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    
    case updateInitialPassword(String)
    case updateOneMorePassword(String)
    case updateStep(Step)
    
    case passwordSetFail
    case passwordSetDone
    
    /// 네트워크
    case requestSetPassword(String)
    case requestSetPasswordResponse(Result<PayAccountEntity.Response?, HTTPError>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
        
        /// Password
      case .updateInitialPassword(let updated):
        state.initalPassword = updated
        if(state.initalPassword.count == 4){
          return .send(.updateStep(.oneMore))
        }
        return .none
      case .updateOneMorePassword(let updated):
        state.oneMorePassword = updated
        if(state.oneMorePassword.count == 4){
          if(state.oneMorePassword == state.initalPassword){
            return .send(.requestSetPassword(state.oneMorePassword))
          }
          return .send(.passwordSetFail)
        }
        return .none
        
      case .updateStep(let updatedStep):
        state.currStep = updatedStep
        return .none
        
      case .passwordSetFail:
        return .none
      case .passwordSetDone:
        return .none
        
      case .requestSetPassword(let password):
        let request = PayAccountEntity.Request.CreatePassword(password: password)
        return .publisher {
          payService.createCardPassword(request)
            .receive(on: mainQueue)
            .map{Action.requestSetPasswordResponse(.success($0))}
            .catch{Just(Action.requestSetPasswordResponse(.failure($0)))}
        }
      case .requestSetPasswordResponse(.success(let res)):
        guard let res = res else {
          return .send(.passwordSetDone)
        }
        return .send(.passwordSetDone)
      case .requestSetPasswordResponse(.failure(let error)):
        return .send(.passwordSetFail)
      }
    }
  }
  
  @Dependency(\.appService.payService) var payService
  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.logger) var logger
}

