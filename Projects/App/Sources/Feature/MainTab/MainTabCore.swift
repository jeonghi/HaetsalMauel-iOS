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
    
    /// TabBar
    var homeState: Home.State = .init()
    var marketPlaceHomeState: MPHome.State = .init()
    var communityHomeState: CMHome.State = .init()
    var chatHomeState: ChatHome.State = .init()
    var eventHomeState: EventHome.State = .init()
    
    /// Navigation Bar
    var settingState: Setting.State = .init()
  }
  
  enum Tab: String, CaseIterable {
    case 홈
    case 햇터
    case 채팅
    case 소통
    case 행사
  }
  
  enum Action {
    /// Lift cycle
    case onAppear
    case onDisappear
    
    /// TabBar
    case setTab(Tab)
    
    case homeAction(Home.Action) // 홈
    case marketPlaceHomeAction(MPHome.Action) // 햇터
    case communityAction(CMHome.Action) // 의견 나누기
    case chatHomeAction(ChatHome.Action) // 채팅
    case eventHomeAction(EventHome.Action) // 행사
    
    /// NavigationBar
    case settingAction(Setting.Action) // 설정
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
        
        /// Tab Bar
      case .setTab(let selectedTab):
        state.selectedTab = selectedTab
        return .none
      case .homeAction:
        return .none
      case .marketPlaceHomeAction:
        return .none
      case .communityAction:
        return .none
      case .chatHomeAction:
        return .none
      case .eventHomeAction:
        return .none
        
        /// NavigationBar
      case .settingAction:
        return .none
      }
    }
    
    Scope(state: \.homeState, action: /Action.homeAction){
      Home()
    }
    
    Scope(state: \.marketPlaceHomeState, action: /Action.marketPlaceHomeAction){
      MPHome()
    }
    
    Scope(state: \.communityHomeState, action: /Action.communityAction){
      CMHome()
    }
    
    Scope(state: \.chatHomeState, action: /Action.chatHomeAction){
      ChatHome()
    }
    
    Scope(state: \.eventHomeState, action: /Action.eventHomeAction){
      EventHome()
    }
    
    Scope(state: \.settingState, action: /Action.settingAction){
      Setting()
    }
  }
}
