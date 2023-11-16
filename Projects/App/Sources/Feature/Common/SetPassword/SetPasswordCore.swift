//
//  SetPasswordCore.swift
//  App
//
//  Created by 쩡화니 on 11/14/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import ComposableArchitecture

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
  
  
  enum Action: Equatable {
    /// Life cycle
    case onAppear
    case onDisappear
    
    case updateInitialPassword(String)
    case updateOneMorePassword(String)
    case updateStep(Step)
    case passwordSetDone
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
          return .send(.passwordSetDone)
        }
        return .none
        
      case .updateStep(let updatedStep):
        state.currStep = updatedStep
        return .none
      case .passwordSetDone:
        return .none
      }
    }
  }
}

