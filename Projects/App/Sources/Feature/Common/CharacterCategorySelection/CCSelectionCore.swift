//
//  CCSelectionCore.swift
//  App
//
//  Created by 쩡화니 on 11/20/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import ComposableArchitecture

struct CCSelection: Reducer {
  
  typealias Category = CharacterCategory
  
  struct State: Equatable {
    var selectedCategory: Category?
    var isSelectedAnyOne: Bool {
      selectedCategory != nil
    }
  }
  
  enum Action: Equatable {
    case onAppear
    case onDisappear
    case selectCategory(Category)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
      case .selectCategory(let newSelectedCategory):
        guard let currSelectedCategory = state.selectedCategory else {
          // 선택된 카테고리가 없다면
          state.selectedCategory = newSelectedCategory
          return .none
        }
        // 선택된 카테고리가 있는데 이미 같은 아이라면
        if(currSelectedCategory == newSelectedCategory){
          state.selectedCategory = nil
        }else{
          state.selectedCategory = newSelectedCategory
        }
        return .none
      }
    }
  }
}
