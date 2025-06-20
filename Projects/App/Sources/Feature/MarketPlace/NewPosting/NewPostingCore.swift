//
//  NewPostingCore.swift
//  App
//
//  Created by JH Park on 2023/10/03.
//  Copyright © 2023 com.eum. All rights reserved.
//

import Foundation
import ComposableArchitecture
import UISystem
import SwiftUI

struct NewPosting: Reducer {
  
  struct State {
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
