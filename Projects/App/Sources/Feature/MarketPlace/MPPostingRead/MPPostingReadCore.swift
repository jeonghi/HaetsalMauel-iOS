//
//  MPPostringReadCore.swift
//  App
//
//  Created by 쩡화니 on 11/16/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct MPPostingRead: Reducer {
  struct State: Equatable {
    var showingActionSheet: Bool = false
    var showingPopup: Bool = false
  }
  
  enum PostingType {
    case Mine
    case Others
  }
  
  enum Action: Equatable {
    /// Life cycle
    case onAppear
    case onDisappear
    
    /// Action Sheet
    case showingActionSheet(Bool)
    case dismissActionSheet
    
    /// Popup
    case showingPopup(Bool)
    case dismissPopup
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
        
        /// Action Sheet
      case .showingActionSheet(let showing):
        state.showingActionSheet = showing
        return .none
      case .dismissActionSheet:
        state.showingActionSheet = false
        return .none
        
        /// Popup
      case .showingPopup(let showing):
        state.showingPopup = showing
        return .none
      case .dismissPopup:
        state.showingPopup = false
        return .none
      }
    }
  }
}
