//
//  SettingCore.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct Setting: Reducer {
  
  struct State {
    var userProfileSettingState: UserProfileSetting.State = .init()
  }
  
  enum Action {
    case userProfileSettingAction(UserProfileSetting.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .userProfileSettingAction:
        return .none
      }
    }
    Scope(state: \.userProfileSettingState, action: /Action.userProfileSettingAction){
      UserProfileSetting()
    }
  }
}
