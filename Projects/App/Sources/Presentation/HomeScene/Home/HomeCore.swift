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
  }
  
  enum Route {
  }
  
  
  enum Action {
    case onAppear
    case onDisappear
    case setRoute(Route)
    
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
    }
  }
}
