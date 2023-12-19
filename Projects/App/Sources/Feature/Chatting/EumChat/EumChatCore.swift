//
//  EumChatCore.swift
//  App
//
//  Created by 쩡화니 on 11/11/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture
import Combine
import ExyteChat
import ExyteMediaPicker

struct EumChat: Reducer {
  struct State: Equatable {
    
    var userName: String = "홍길동"
    var messages: [Message] = []
    var chatTitle: String = ""
    var chatStatus: String = ""
    var chatCover: URL? = nil
    
    var showingActionSheet: Bool = false
    var showingPopup: Bool = false
    
    // MARK: private
    private var subscriptions = Set<AnyCancellable>()
  }
  
  enum ActionSheetType {
    case 신고하기
    case 채팅방나가기
  }
  
  enum Action: Equatable {
    /// Life cycle
    case onAppear
    case onDisappear
    
    case tappedActionSheet(ActionSheetType)
    
    /// Action Sheet
    case showingActionSheet(Bool)
    case dismissActionSheet
    
    /// Popup
    case showingPopup(Bool)
    case dismissPopup
    
    /// Network
    case requestGetData
    case requestGetDataReponse
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
        
      case .tappedActionSheet(let type):
        return .none
        
        /// Action Sheet
      case .showingActionSheet(let showing):
        state.showingActionSheet = showing
        return .none
      case .dismissActionSheet:
        state.showingActionSheet = false
        return .none
        
        /// Popup
      case .showingPopup(let showing):
        state.showingPopup = showing
        return .none
      case .dismissPopup:
        state.showingPopup = false
        return .none
        
        /// Network
      case .requestGetData:
        return .none
      case .requestGetDataReponse:
        return .none
      }
    }
  }
}
