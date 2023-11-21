//
//  CommunityCategorySelectionView.swift
//  App
//
//  Created by JH Park on 2023/10/02.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem
import DesignSystemFoundation

struct MCSelectionView: View {
  
  typealias Core = MCSelection
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

extension MCSelectionView {
  private var buttonGrid: some View {
    LazyVGrid(
      columns: Array(repeating: GridItem(.flexible(), spacing: 5),
                    count: 3),
      alignment: .center,
      spacing: 10
    ){
      ForEach(Category.allCases, id: \.self ){ cat in
        Button(action: {viewStore.send(.selectCategory(cat))}){
          CategoryButton(cat.cvtAssetImage(), cat.rawValue, cat == viewStore.selectedCat)
        }
      }
    }
  }
}

struct CommunityCategorySelectionView_Previews: PreviewProvider {
  static var previews: some View {
    
    let store = Store(initialState: MCSelection.State()){
      MCSelection()
    }
    MCSelectionView(store: store)
      .padding(10)
  }
}
