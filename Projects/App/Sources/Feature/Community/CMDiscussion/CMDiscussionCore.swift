//
//  CommunityDiscussionCore.swift
//  App
//
//  Created by 쩡화니 on 11/15/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import ComposableArchitecture

struct CMDiscussion: Reducer {
  
  struct State {
    var CMDiscussionReadState: CMDiscussionRead.State = .init()
    var CMDiscussionCreateState: CMDiscussionCreate.State = .init()
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    
    case CMDiscussionReadAction(CMDiscussionRead.Action)
    case CMDiscussionCreateAction(CMDiscussionCreate.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
      case .CMDiscussionReadAction(let act):
        return .none
      case .CMDiscussionCreateAction(let act):
        return .none
      }
    }
    Scope(state: \.CMDiscussionReadState, action: /Action.CMDiscussionReadAction){
      CMDiscussionRead()
    }
    Scope(state: \.CMDiscussionCreateState, action: /Action.CMDiscussionCreateAction){
      CMDiscussionCreate()
    }
  }
}
