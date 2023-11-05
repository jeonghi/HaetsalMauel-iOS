//
//  HomeCore.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import ComposableArchitecture

struct Home: Reducer {
  
  struct State {
    var showingPopup: Bool = false
    var settingState: Setting.State = .init()
    var payHomeState: PayHome.State = .init()
  }
  
  
  enum Action {
    case onAppear
    case onDisappear
    case settingAction(Setting.Action)
    case payHomeAction(PayHome.Action)
    case showingPopup(Bool)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
      case .settingAction:
        return .none
      case .payHomeAction:
        return .none
      case .showingPopup(let showingPopup):
        state.showingPopup = showingPopup
        return .none
      }
    }
    Scope(state: \.payHomeState, action: /Action.payHomeAction){
      PayHome()
    }
    Scope(state: \.settingState, action: /Action.settingAction){
      Setting()
    }
    
  }
}
