//
//  MarketPlaceHomeCore.swift
//  App
//
//  Created by 쩡화니 on 11/9/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct MarketPlaceHome: Reducer {
  struct State: Equatable {
    
  }
  
  enum Action: Equatable {
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
