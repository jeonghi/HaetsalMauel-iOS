//
//  PostTextFormCore.swift
//  App
//
//  Created by 쩡화니 on 11/21/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import ComposableArchitecture

struct PostTextForm: Reducer {
  
  struct State {
    var title: String = ""
    var content: String = ""
  }
  
  
  enum Action {
    case onAppear
    case onDisappear
    
    case updateTitle(String)
    case updateContent(String)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
        
      case .updateTitle(let updatedTitle):
        state.title = updatedTitle
        return .none
      case .updateContent(let updatedContent):
        state.content = updatedContent
        return .none
      }
    }
  }
}
