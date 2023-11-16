//
//  TransferInputCore.swift
//  App
//
//  Created by JH Park on 2023/10/14.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct TransferInput: Reducer {
  
  struct State {
    var accountNumber: String = ""
    var amount: String = ""
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

