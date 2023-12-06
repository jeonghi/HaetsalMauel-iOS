//
//  WithdrawalReasonCore.swift
//  App
//
//  Created by 쩡화니 on 11/13/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import ComposableArchitecture

struct WithdrawalReason: Reducer {
  struct State {
    var reasonList: [String] = [
      "앱을 쓰지 않아요",
      "알림이 너무 많이 와요",
      "비매너 사용자를 만났어요",
      "새 계정을 만들고 싶어요",
      "기타"
    ]
    var isAnythingSelected: Bool {
      selectedReason != nil
    }
    var selectedReason: String? = nil
    var withdrawalDetailReasonState: WithdrawalDetailReason.State = .init()
  }
  enum Action {
    case onAppear
    case selectReason(String?)
    case withdrawalDetailReasonAction(WithdrawalDetailReason.Action)
  }
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        state.selectedReason = nil
        return .none
      case .selectReason(let selectedReason):
        state.selectedReason = selectedReason
        return .none
      case .withdrawalDetailReasonAction(let act):
        return .none
      }
    }
    Scope(state: \.withdrawalDetailReasonState, action: /Action.withdrawalDetailReasonAction){
      WithdrawalDetailReason()
    }
  }
}
