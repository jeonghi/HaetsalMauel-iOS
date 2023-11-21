//
//  OnboardingCore.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import ComposableArchitecture
import KakaoSDKUser
import KakaoSDKAuth

struct Onboarding: Reducer {
  
  struct State {
    var route: Route? = nil
    var signUpState: SignUp.State = .init()
    var newProfileState: UPCreate.State = .init()
  }
  
  enum Route {
    case login
    case logout
  }
  
  enum SocialLoginAdvisor {
    case kakao // 카카오
    case google // 구글
    case apple // 애플
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    case setRoute(Route)
    
    case skipButtonTapped
    
    /// Kakao Login Handler
    case kakaoLoginCallback(OAuthToken?, Error?)
    
    /// Child
    case signUpAction(SignUp.Action)
    case newProfileAction(UPCreate.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        if authService.isLoggedIn {
          return .send(.skipButtonTapped)
        }
        return .none
      case .onDisappear:
        return .none
      case .setRoute(let selectedRoute):
        state.route = selectedRoute
        return .none
      case .skipButtonTapped:
        return .none
        
        /// Kakao Login Handler
      case .kakaoLoginCallback(let token, let error):
        if let error {
          print(error)
        }else {
          print(token)
        }
        return .none
        
        /// Child
      case .signUpAction:
        return .none
      case .newProfileAction(.tappedNextButton):
        return .none
      case .newProfileAction:
        return .none
      }
    }
    Scope(state: \.signUpState, action: /Action.signUpAction){
      SignUp()
    }
    Scope(state: \.newProfileState, action: /Action.newProfileAction){
      UPCreate()
    }
  }
  
  // MARK: Dependency
  @Dependency(\.appService.authService) var authService
}
