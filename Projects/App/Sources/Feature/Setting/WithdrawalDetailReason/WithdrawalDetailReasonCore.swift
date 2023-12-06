//
//  WithdrawalDetailReasonCore.swift
//  App
//
//  Created by 쩡화니 on 12/5/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture
import Combine
import EumNetwork

struct WithdrawalDetailReason: Reducer {
  
  struct State {
    var detailReason: String = ""
    var isShowingPopup: Bool = false
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    
    /// 뷰 정의
    case updateDetailReason(String)
    
    /// 버튼
    case tappedCancelProcessButton
    case tappedNextButton
    case tappedWithdrawalButton
    
    /// 팝업
    case showingPopup
    case dismissPopup
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
        
        /// 뷰 정의
      case .updateDetailReason(let updated):
        state.detailReason = updated
        return .none
        
      case .tappedNextButton:
        return .send(.showingPopup)
      case .tappedWithdrawalButton:
        return .none
      case .tappedCancelProcessButton:
        return .none
        
        /// Custom
      case .showingPopup:
        state.isShowingPopup = true
        return .none
      case .dismissPopup:
        state.isShowingPopup = false
        return .none
        
      }
    }
  }
  
  @Dependency(\.appService.marketService) var marketService
  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.logger) var logger
}
