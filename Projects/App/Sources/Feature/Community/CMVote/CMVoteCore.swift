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
    var isShowingFullSheet: Bool = false
    
    var CMVoteReadState: CMVoteRead.State = .init()
    var CMVoteCreateState: CMVoteCreate.State = .init()
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    
    /// fulloverSheet
    case showingFullSheet
    case dismissFullSheet
    
    /// Child
    case CMVoteReadAction(CMVoteRead.Action)
    case CMVoteCreateAction(CMVoteCreate.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
        
      case .showingFullSheet:
        state.isShowingFullSheet = true
        return .none
      case .dismissFullSheet:
        state.isShowingFullSheet = false
        return .none
        
        /// Child
      case .CMVoteReadAction(let act):
        return .none
      case .CMVoteCreateAction(.onAppear):
        state.CMVoteCreateState = .init()
        return .none
      case .CMVoteCreateAction:
        return .none
      }
    }
    Scope(state: \.CMVoteReadState, action: /Action.CMVoteReadAction){
      CMVoteRead()
    }
    Scope(state: \.CMVoteCreateState, action: /Action.CMVoteCreateAction){
      CMVoteCreate()
    }
  }
}
