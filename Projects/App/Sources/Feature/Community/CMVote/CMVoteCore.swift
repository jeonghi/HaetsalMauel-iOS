//
//  CommunityVoteCore.swift
//  App
//
//  Created by 쩡화니 on 11/15/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import ComposableArchitecture

struct CMVote: Reducer {
  
  struct State {
    var CMVoteReadState: CMVoteRead.State = .init()
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    
    case CMVoteReadAction(CMVoteRead.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
        
      case .CMVoteReadAction(let act):
        return .none
      }
    }
    Scope(state: \.CMVoteReadState, action: /Action.CMVoteReadAction){
      CMVoteRead()
    }
    
  }
}
