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
    
    var fromSetting: FromSetting?
    
    enum FromSetting {
      case logout
      case signOut
    }
  }
  
  enum Route {
    case onboarding // 온보딩
    case mainTab // 메인탭
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    case setRoute(Route)
    
    /// Authentication
    case signOut
    case signIn
    case withdrawal
    
    /// Alert
    
    /// Child
    case onboardingAction(Onboarding.Action)
    case mainTabAction(MainTab.Action)
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        state.onboardingState = .init()
        return .none
      case .onDisappear:
        return .none
      case .setRoute(let selectedRoute):
        state.route = selectedRoute
        return .none
        
        /// Authentication
      case .signOut:
        return .none
      case .signIn:
        return .none
      case .withdrawal:
        return .none
      
      case .onboardingAction(.signUpAction(.tappedLoginButton)):
        state.mainTabState = .init()
        return .send(.setRoute(.mainTab))
      case .onboardingAction(.skipButtonTapped):
        state.mainTabState = .init()
        return .send(.setRoute(.mainTab))
      case .onboardingAction:
        return .none
      case .mainTabAction(.settingAction(.logout)):
        return .send(.setRoute(.onboarding))
      case .mainTabAction(.settingAction(.signOut)):
        return .send(.setRoute(.onboarding))
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
