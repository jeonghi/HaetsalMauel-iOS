//
//  SignUpCore.swift
//  App
//
//  Created by JH Park on 2023/10/31.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct SignUp: Reducer {
  
  struct State: Equatable {
    var isTextFieldAllFilled: Bool = false
  }
  
  enum Action: Equatable {
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
        
        /// Child
      }
    }
  }
}
