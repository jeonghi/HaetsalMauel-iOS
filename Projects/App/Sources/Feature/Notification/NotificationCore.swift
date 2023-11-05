//
//  NotificationCore.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//
import ComposableArchitecture

struct Notification: Reducer {
  struct State {
    var tabs: [Tab] = Tab.allCases
    var selectedTab: Tab = Tab.all
  }
  
  enum Tab: String, CaseIterable {
    case all = "전체" // 전체
    case activity = "활동" // 활동
  }
  
  enum Action {
    case onAppear
    case onDisappear
    case selectTab(Tab)
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
      case .selectTab(let selectedTab):
        state.selectedTab = selectedTab
        return .none
      }
    }
  }
}
