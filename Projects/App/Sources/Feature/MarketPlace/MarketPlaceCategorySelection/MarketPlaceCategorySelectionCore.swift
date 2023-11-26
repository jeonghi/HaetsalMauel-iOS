//
//  MarketPlaceCategorySelection.swift
//  App
//
//  Created by 쩡화니 on 11/15/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct MarketPlaceCategorySelection: Reducer {
  struct State: Equatable {
    var marketCategorySelectionState: MCSelection.State = .init()
    var isSelected: Bool {
      marketCategorySelectionState.isSelectedAnyOne
    }
    var selectedCat: MarketCategory? {
      marketCategorySelectionState.selectedCategory
    }
  }
  
  enum Action: Equatable {
    /// Life cycle
    case onAppear
    case onDisappear
    
    case marketCategorySelectionAction(MCSelection.Action)
    case tappedSelectDoneButton
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
      case .marketCategorySelectionAction(_):
        return .none
      case .tappedSelectDoneButton:
        return .none
      }
    }
    
    Scope(state: \.marketCategorySelectionState, action: /Action.marketCategorySelectionAction){
      MCSelection()
    }
  }
}
