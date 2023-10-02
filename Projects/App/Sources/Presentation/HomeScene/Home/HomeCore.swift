//
//  HomeCore.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import ComposableArchitecture

struct Home: Reducer {
  
  struct State {
    var route: Route? = nil
    var notificationState: Notification.State = .init()
  }
  
  enum Route {
  }
  
  enum Action {
    case onAppear
    case onDisappear
    case setRoute(Route)
    case notificationAction(Notification.Action)
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
      case .notificationAction:
        return .none
      }
    }
    
    Scope(state: \.notificationState, action: /Action.notificationAction){
      Notification()
    }
  }
}
