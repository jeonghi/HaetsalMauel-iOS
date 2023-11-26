//
//  NewProfileCore.swift
//  App
//
//  Created by 쩡화니 on 11/13/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct UPCreate: Reducer {
  
  typealias Category = CharacterCategory
  
  struct State: Equatable {
    var nickName: String = ""// 닉네임
    var location: String = ""// 지역
    var selectedCategory: Category? {
      CCSelectionState.selectedCategory
    }
    var CCSelectionState: CCSelection.State = .init()
    
    var isAllInfoFilled: Bool {
      true
    }
  }
  
  enum Action: Equatable {
    /// Life cycle
    case onAppear
    case onDisappear
    
    case updateNickName(String)
    case tappedNextButton
    
    case CCSelectionAction(CCSelection.Action)
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
        
      case .updateNickName(let updatedNickName):
        state.nickName = updatedNickName
        return .none
        
      case .tappedNextButton:
        return .none
        
      case .CCSelectionAction(let act):
        return .none
      }
    }
    
    Scope(state: \.CCSelectionState, action: /Action.CCSelectionAction){
      CCSelection()
    }
  }
}

