//
//  SignUpCore.swift
//  App
//
//  Created by JH Park on 2023/10/31.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct SignUp: Reducer {
  
  struct State: Equatable {
    var isTextFieldAllFilled: Bool {
      !id.isEmpty && !password.isEmpty
    }
    var id: String = ""
    var password: String = ""
    var showPassword: Bool = false
    var isShowingSheet: Bool = false
  }
  
  enum Action: Equatable {
    case onAppear
    case onDisappear
    
    case updateId(String)
    case updatePassword(String)
    case tappedShowPassword
    
    case isShowingSheet(Bool)
    case dismissSheet
    
    case tappedLoginButton
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
        
        /// Custom
      case .updateId(let updated):
        state.id = updated
        return .none
      case .updatePassword(let updated):
        state.password = updated
        return .none
        
      case .tappedShowPassword:
        state.showPassword.toggle()
        return .none
        
      case .isShowingSheet(let isShowing):
        state.isShowingSheet = isShowing
        return .none
      case .dismissSheet:
        state.isShowingSheet = false
        return .none
        
      case .tappedLoginButton:
        return .none
      }
    }
  }
}
