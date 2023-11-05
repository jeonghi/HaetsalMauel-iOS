//
//  MainTabCore.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import ComposableArchitecture

struct MainTab: Reducer {
  
  struct State {
    var selectedTab: Tab = .홈
    var homeState: Home.State = .init()
    var communityHomeState: CommunityHome.State = .init()
    var chatHomeState: ChatHome.State = .init()
    var settingState: Setting.State = .init()
  }
  
  enum Tab: String, CaseIterable {
    case 홈
    case 햇터
    case 채팅
    case 소통
    case 우리마을
  }
  
  enum Action {
    /// Lift cycle
    case onAppear
    case onDisappear
    
    /// Tab
    case setTab(Tab)
    /// Child
    case homeAction(Home.Action) // 홈
    case communityAction(CommunityHome.Action) // 햇터
    case chatHomeAction(ChatHome.Action) // 채팅
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
        
        /// Tab
      case .setTab(let selectedTab):
        state.selectedTab = selectedTab
        return .none
        
        /// Child
      case .homeAction:
        return .none
      case .communityAction:
        return .none
      case .chatHomeAction:
        return .none
      }
    }
    
    Scope(state: \.homeState, action: /Action.homeAction){
      Home()
    }
    
    Scope(state: \.communityHomeState, action: /Action.communityAction){
      CommunityHome()
    }
    
    Scope(state: \.chatHomeState, action: /Action.chatHomeAction){
      ChatHome()
    }
  }
}
