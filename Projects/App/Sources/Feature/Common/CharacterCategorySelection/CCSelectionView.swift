//
//  CCSelectionView.swift
//  App
//
//  Created by 쩡화니 on 11/20/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem
import DesignSystemFoundation

struct CCSelectionView: View {
  
  typealias Core = CCSelection
  typealias State = Core.State
  typealias Action = Core.Action
  typealias Category = Core.Category
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var selectedCat: Category?
    init(state: State) {
      selectedCat = state.selectedCategory
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
  var body: some View {
    VStack(spacing: 0) {
      buttonGrid
    }
  }
}

extension CCSelectionView {
  private var buttonGrid: some View {
    LazyVGrid(
      columns: Array(repeating: GridItem(.flexible(), spacing: 7, alignment: .center),
                    count: 2),
      alignment: .center,
      spacing: 7
    ){
      ForEach(Category.allCases, id: \.self ){ cat in
        Button(action: {viewStore.send(.selectCategory(cat))}){
          CategoryButton(cat.cvtAssetImage(), cat.rawValue, cat == viewStore.selectedCat)
        }
      }
    }
  }
}

#Preview {
  let store = Store(initialState: CCSelection.State()){
    CCSelection()
  }
  return CCSelectionView(store: store)
    .padding(.horizontal, 20)
}
