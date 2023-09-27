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
    case onAppear
    case onDisappear
    case setRoute(Route)
    
    case skipButtonTapped
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .onAppear:
      return .none
    case .onDisappear:
      return .none
    case .setRoute(let selectedRoute):
      state.route = selectedRoute
      return .none
    case .skipButtonTapped:
      return .none
    }
  }
}
