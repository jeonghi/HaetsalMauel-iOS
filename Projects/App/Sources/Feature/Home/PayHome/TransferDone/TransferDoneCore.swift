//
//  TransferDoneCore.swift
//  App
//
//  Created by JH Park on 2023/10/14.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct TransferDone: Reducer {
  
  struct State {
    var userName: String
    var amount: Int
  }
  
  enum Action {
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
