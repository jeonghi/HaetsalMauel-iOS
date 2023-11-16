//
//  OnboardingCore.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import ComposableArchitecture

struct Onboarding: Reducer {
  
  struct State {
    var route: Route? = nil
    var signUpState: SignUp.State = .init()
    var newProfileState: NewProfile.State = .init()
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
    
    /// Child
    case signUpAction(SignUp.Action)
    case newProfileAction(NewProfile.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
      case .setRoute(let selectedRoute):
        state.route = selectedRoute
        return .none
      case .skipButtonTapped:
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
      NewProfile()
    }
  }
}
