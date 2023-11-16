//
//  NewProfileCore.swift
//  App
//
//  Created by 쩡화니 on 11/13/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct NewProfile: Reducer {
  struct State: Equatable {
    var nickName: String = ""// 닉네임
    var location: String = ""// 지역
    var selectedCharacter: String = ""// 선택된 캐릭터
    var isAllInfoFilled: Bool {
      true
    }
  }
  
  enum Action: Equatable {
    /// Life cycle
    case onAppear
    case onDisappear
    
    case updateNickName(String)
    case selectCharacter(String)
    case tappedNextButton
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
        
      case .selectCharacter(let selectedCharacter):
        state.selectedCharacter = selectedCharacter
        return .none
      case .tappedNextButton:
        return .none
      }
    }
  }
}

