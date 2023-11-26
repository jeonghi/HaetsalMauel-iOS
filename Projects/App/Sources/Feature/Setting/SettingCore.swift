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
    var withdrawalReasonState: WithdrawalReason.State = .init()
    var showingPopup: Bool = false
  }
  
  enum Action {
    case logoutButtonTapped
    case showingPopup(Bool)
    case logout // 로그아웃
    case signOut // 회원탈퇴
    case userProfileSettingAction(UserProfileSetting.Action)
    case withdrawalReasonAction(WithdrawalReason.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .logoutButtonTapped:
        return .send(.showingPopup(true))
      case .showingPopup(let showingPopup):
        state.showingPopup = showingPopup
        return .none
      case .logout:
        guard authService.logout() else {
          return .none
        }
        return .none
      case .signOut:
        return .none
      case .userProfileSettingAction:
        return .none
      case .withdrawalReasonAction(let act):
        return .none
      }
    }
    Scope(state: \.userProfileSettingState, action: /Action.userProfileSettingAction){
      UserProfileSetting()
    }
    Scope(state: \.withdrawalReasonState, action: /Action.withdrawalReasonAction){
      WithdrawalReason()
    }
  }
  
  @Dependency(\.appService.authService) var authService
}
