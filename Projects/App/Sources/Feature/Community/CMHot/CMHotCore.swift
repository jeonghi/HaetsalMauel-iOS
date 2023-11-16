//
//  CommunityHotCore.swift
//  App
//
//  Created by 쩡화니 on 11/15/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import ComposableArchitecture

struct CMHot: Reducer {
  
  struct State {
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
      }
    }
  }
}
