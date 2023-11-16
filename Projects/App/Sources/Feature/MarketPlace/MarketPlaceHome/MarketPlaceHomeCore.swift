//
//  MarketPlaceHomeCore.swift
//  App
//
//  Created by 쩡화니 on 11/9/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct MPHome: Reducer {
  struct State {
    var isShowingFullSheet: Bool = false
    var marketPlaceCategorySelectionState: MarketPlaceCategorySelection.State = .init()
    var selectedCat: MarketCategory? {
      marketPlaceCategorySelectionState.selectedCat
    }
    var fullSheetType: FullSheetType? = nil
    var MPPostingCreateState: MPPostingCreate.State = .init()
  }
  
  enum FullSheetType {
    case 카테고리선택
    case 글쓰기
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    
    /// Custom
    case tappedCreatePostButton
    
    /// Full sheet
    case updateFullSheetType(FullSheetType?)
    case isShowingFullSheet
    case dismissFullSheet
    
    case 카테고리선택하기
    case 글쓰기
    
    /// Child
    case marketPlaceCategorySelectionAction(MarketPlaceCategorySelection.Action)
    case MPPostingCreateAction(MPPostingCreate.Action)
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        guard let _ = state.selectedCat else {
          return .send(.카테고리선택하기)
        }
        return .none
      case .onDisappear:
        return .none
        
      case .tappedCreatePostButton:
        return .send(.글쓰기)
        
      case .updateFullSheetType(let type):
        state.fullSheetType = type
        return .none
      case .isShowingFullSheet:
        state.isShowingFullSheet = true
        return .none
      case .dismissFullSheet:
        state.isShowingFullSheet = false
        return .none
        
      case .카테고리선택하기:
        return .merge(
          .send(.updateFullSheetType(.카테고리선택)),
          .send(.isShowingFullSheet)
        )
        
      case .글쓰기:
        return .merge(
          .send(.updateFullSheetType(.글쓰기)),
          .send(.isShowingFullSheet)
        )
        
        /// Child
      case .marketPlaceCategorySelectionAction(.tappedSelectDoneButton):
        return .merge(
          .send(.dismissFullSheet),
          .send(.updateFullSheetType(nil))
        )
      case .marketPlaceCategorySelectionAction:
        return .none
      case .MPPostingCreateAction(let act):
        return .none
      }
    }
    Scope(state: \.marketPlaceCategorySelectionState, action: /Action.marketPlaceCategorySelectionAction){
      MarketPlaceCategorySelection()
    }
    Scope(state: \.MPPostingCreateState, action: /Action.MPPostingCreateAction){
      MPPostingCreate()
    }
  }
}
