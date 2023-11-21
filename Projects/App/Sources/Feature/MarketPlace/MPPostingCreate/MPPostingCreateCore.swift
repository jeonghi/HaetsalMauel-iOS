//
//  MPPostingCreateCore.swift
//  App
//
//  Created by 쩡화니 on 11/16/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct MPPostingCreate: Reducer {
  
  typealias Category = MarketCategory
  
  struct State: Equatable {
    var selectedCategory: Category? {
      marketCategorySelectionState.selectedCategory
    }
    var TransactionType: String
    var activityDate: Date // 활동날짜
    var activityTime: String // 활동 시간대
    var estimatedTime: Date // 예상 소요 시간
    var maximumNoPeople: Int // 최대 모집 인원
    
    /// Child
    var marketCategorySelectionState: MCSelection.State
    
    init(TransactionType: String = "", activityDate: Date = .init(), activityTime: String = "", estimatedTime: Date = .init(), maximumNoPeople: Int = 0, marketCategorySelectionState: MCSelection.State = .init()) {
      self.TransactionType = TransactionType
      self.activityDate = activityDate
      self.activityTime = activityTime
      self.estimatedTime = estimatedTime
      self.maximumNoPeople = maximumNoPeople
      self.marketCategorySelectionState = marketCategorySelectionState
    }
  }
  
  enum Action: Equatable {
    /// Life cycle
    case onAppear
    case onDisappear
    
    /// Child
    case marketCategorySelectionAction(MCSelection.Action)
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
        
      case .marketCategorySelectionAction(let act):
        return .none
      }
    }
    
    Scope(state: \.marketCategorySelectionState, action: /Action.marketCategorySelectionAction){
      MCSelection()
    }
  }
}
