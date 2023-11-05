//
//  AppCore.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import ComposableArchitecture

struct Root: Reducer {
  struct State {
    var route: Route = .onboarding
    
    var onboardingState: Onboarding.State?
    var mainTabState: MainTab.State?
  }
  
  enum Route {
    case onboarding // 온보딩
    case mainTab // 메인탭
  }
  
  enum Action {
    case onAppear
    case onDisappear
    case setRoute(Route)
    
    case onboardingAction(Onboarding.Action)
    case mainTabAction(MainTab.Action)
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        state.onboardingState = .init()
        return .none
      case .onDisappear:
        return .none
      case .setRoute(let selectedRoute):
        state.route = selectedRoute
        return .none
      case .onboardingAction(.skipButtonTapped):
        state.mainTabState = .init()
        return .send(.setRoute(.mainTab))
      case .onboardingAction:
        return .none
      case .mainTabAction:
        return .none
      }
    }
    .ifLet(\.mainTabState, action: /Action.mainTabAction){
      MainTab()
    }
    .ifLet(\.onboardingState, action: /Action.onboardingAction){
      Onboarding()
    }
  }
}
