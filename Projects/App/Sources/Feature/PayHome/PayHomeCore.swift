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
    var selectedTab: Tab = .진행중
  }
  
  enum Action: Equatable {
    /// Life cycle
    case onAppear
    case onDisappear
    
    /// Child
    case setTab(Tab)
  }
  
  enum Tab: String, CaseIterable, Equatable {
    case 진행중
    case 보냄
    case 받음
    case 취소
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
      case .setTab(let selectedTab):
        state.selectedTab = selectedTab
        return .none
      }
    }
  }
}
