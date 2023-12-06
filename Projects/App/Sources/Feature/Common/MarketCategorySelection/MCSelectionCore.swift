//
//  CommunityCategorySelectionCore.swift
//  App
//
//  Created by JH Park on 2023/10/02.
//  Copyright © 2023 com.eum. All rights reserved.
//

import ComposableArchitecture

struct MCSelection: Reducer {
  
  typealias Category = MPCategory
  
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
