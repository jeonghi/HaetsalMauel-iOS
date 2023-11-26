//
//  SignUpCore.swift
//  App
//
//  Created by JH Park on 2023/10/31.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture
import EumNetwork
import Combine

struct SignIn: Reducer {
  
  struct State {
    var isTextFieldAllFilled: Bool {
      !id.isEmpty && !password.isEmpty
    }
    var id: String = "test2@email"
    var password: String = "1234"
    var showPassword: Bool = false
    var isShowingSheet: Bool = false
  }
  
  enum Action {
    case onAppear
    case onDisappear
    
    case updateId(String)
    case updatePassword(String)
    case tappedShowPassword
    
    case isShowingSheet(Bool)
    case dismissSheet
    
    case tappedLoginButton
    
    /// Network
    case requestSignIn
    case requestSignInResponse(Result<SignInEntity.Response?, HTTPError>)
    
    case loginDone
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
        return .send(.requestSignIn)
        
        /// network
      case .requestSignIn:
        let request = SignInEntity.LocalLoginRequest(email: state.id, password: state.password)
        return .publisher { authService.localLogin(request)
            .receive(on: mainQueue)
            .map{Action.requestSignInResponse(.success($0))}
            .catch{Just(Action.requestSignInResponse(.failure($0)))}
        }
        return .none 
      case .requestSignInResponse(.success(let res)):
        guard let token = res?.toOAuthToken(), authService.saveToken(token) else {
          return .none
        }
        return .send(.loginDone)
      case .requestSignInResponse(.failure(let error)):
        print(error)
        return .none
        
      case .loginDone:
        return .none
      }
    }
  }
  
  @Dependency(\.appService.authService) var authService
  @Dependency(\.mainQueue) var mainQueue
}
