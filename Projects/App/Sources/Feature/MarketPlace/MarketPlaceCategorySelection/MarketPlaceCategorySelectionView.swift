//
//  MarketPlaceCategorySelectionView.swift
//  App
//
//  Created by 쩡화니 on 11/15/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem
import DesignSystemFoundation

struct MarketPlaceCategorySelectionView: View {
  
  typealias Core = MarketPlaceCategorySelection
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var isSelected: Bool
    init(state: State) {
      isSelected = state.isSelected
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
  var body: some View {
    VStack(spacing: 0){
      
      VStack(spacing: 20) {
        guideComment
        MarketCategorySelectionView(store: marketCategorySelectionStore)
      }
      .padding(.top, 70)
      .padding(.horizontal, 22)
      
      Spacer()
      
      selectDoneButton
        .vBottom()
        .padding(.bottom, 20)
        .padding(.horizontal, 16)
    }
  }
}

extension MarketPlaceCategorySelectionView {
  
  private var guideComment: some View {
    Text("어떻게 햇살을 나누실 건가요?")
      .font(.titleB)
      .vTop()
      .hLeading()
  }
  
  private var selectDoneButton: some View {
    Button(action: {
      viewStore.send(.tappedSelectDoneButton)
    }){
      Text("선택 완료")
    }
    .buttonStyle(PrimaryButtonStyle())
    .disabled(!viewStore.isSelected)
  }
}

extension MarketPlaceCategorySelectionView {
  private var marketCategorySelectionStore: StoreOf<MarketCategorySelection> {
    return store.scope(state: \.marketCategorySelectionState, action: Action.marketCategorySelectionAction)
  }
}

#Preview {
  let store = Store(initialState: MarketPlaceCategorySelection.State()){
    MarketPlaceCategorySelection()
  }
  return MarketPlaceCategorySelectionView(store: store)
}
