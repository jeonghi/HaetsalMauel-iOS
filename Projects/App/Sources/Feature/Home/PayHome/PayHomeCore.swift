//
//  PayHomeCore.swift
//  App
//
//  Created by JH Park on 2023/11/01.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct PayHome: Reducer {
  struct State: Equatable {
    var selectedTab: Tab = .보냄
    
    var setPasswordState: SetPassword.State? = nil
    var showingSetPasswordSheet: Bool = false
    var showingPopup: Bool = false
  }
  
  enum Action: Equatable {
    /// Life cycle
    case onAppear
    case onDisappear
    
    /// Password
    case showingSetPasswordSheet(Bool)
    case dismissSetPasswordSheet
    
    /// Popup
    case showingPopup
    case dismissPopup
    
    case setPasswordAction(SetPassword.Action)
    
    /// Custom
    case tappedRemittanceButton
    
    /// Child
    case setTab(Tab)
  }
  
  enum Tab: String, CaseIterable, Equatable {
    case 보냄
    case 받음
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
        
        /// Custom
      case .tappedRemittanceButton:
        state.setPasswordState = .init()
        return .send(.showingSetPasswordSheet(true))
        
        /// Password
      case .showingSetPasswordSheet(let showing):
        state.showingSetPasswordSheet = showing
        return .none
      case .dismissSetPasswordSheet:
        state.showingSetPasswordSheet = false
        return .none
        
        /// Popup
      case .showingPopup:
        state.showingPopup = true
        return .none
      case .dismissPopup:
        state.showingPopup = false
        return .none
        
      case .setPasswordAction(.passwordSetDone):
        return .merge(
            .send(.dismissSetPasswordSheet),
            .send(.showingPopup)
          )
      case .setPasswordAction:
        return .none
        
        /// Child
      case .setTab(let selectedTab):
        state.selectedTab = selectedTab
        return .none
      }
    }
    .ifLet(\.setPasswordState, action: /Action.setPasswordAction){
      SetPassword()
    }
  }
}
