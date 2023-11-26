//
//  CMDiscussionCreateCore.swift
//  App
//
//  Created by 쩡화니 on 11/16/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import ComposableArchitecture

struct CMDiscussionCreate: Reducer {
  
  struct State {
    var isFilledAllForm: Bool {
      !textFormState.content.isEmpty && !textFormState.title.isEmpty
    }
    var textFormState: PostTextForm.State = .init()
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    
    case textFormAction(PostTextForm.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
        
      case .textFormAction:
        return .none
      }
    }
    
    Scope(state: \.textFormState, action: /Action.textFormAction){
      PostTextForm()
    }
  }
}
