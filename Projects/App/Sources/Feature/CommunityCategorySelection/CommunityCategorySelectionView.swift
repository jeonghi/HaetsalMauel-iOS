//
//  CommunityCategorySelectionView.swift
//  App
//
//  Created by JH Park on 2023/10/02.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct CommunityCategorySelectionView: View {
  
  typealias Core = CommunityCategorySelection
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    
    init(state: State) {
      
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
  var body: some View {
    VStack {
      Text("커뮤니티 선택")
    }
  }
}

struct CommunityCategorySelectionView_Previews: PreviewProvider {
  static var previews: some View {
    
    let store = Store(initialState: CommunityCategorySelection.State()){
      CommunityCategorySelection()
    }
    CommunityCategorySelectionView(store: store)
  }
}
