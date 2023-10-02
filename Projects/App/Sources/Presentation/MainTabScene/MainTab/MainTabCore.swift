//
//  MainTabCore.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import ComposableArchitecture

struct MainTab: Reducer {
  
  struct State {
    var route: Route = .home
    var homeState: Home.State = .init()
    var settingState: Setting.State = .init()
  }
  
  enum Route {
    case home
    case communiy
    case chat
    case etc
  }
  
  enum Action {
    case onAppear
    case onDisappear
    case setRoute(Route)
    
    case homeAction(Home.Action)
    case settingAction(Setting.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
      case .setRoute(let selectedRoute):
        state.route = selectedRoute
        return .none
        
      case .homeAction:
        return .none
      case .settingAction:
        return .none
      }
    }
    
    Scope(state: \.homeState, action: /Action.homeAction){
      Home()
    }
    
    Scope(state: \.settingState, action: /Action.settingAction){
      Setting()
    }
  }
}
