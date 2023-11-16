//
//  EventHomeCore.swift
//  App
//
//  Created by 쩡화니 on 11/13/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import ComposableArchitecture

struct EventHome: Reducer {
  
  struct State: Equatable {
  }
  
  enum Action: Equatable {
    case onAppear
    case onDisappear
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
      }
    }
  }
}
