//
//  ChatHomeCore.swift
//  App
//
//  Created by JH Park on 2023/10/27.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct ChatHome: Reducer {
  struct State: Equatable {
    var selectedTab: Tab = .내_게시글
  }
  
  enum Action: Equatable {
    /// Life cycle
    case onAppear
    case onDisappear
    
    /// Child
    case setTab(Tab)
  }
  
  enum Tab: String, CaseIterable, Equatable {
    case 내_게시글 = "내 게시글"
    case 이웃_게시글 = "이웃 게시글"
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

