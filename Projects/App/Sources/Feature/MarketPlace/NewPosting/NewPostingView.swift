//
//  NewPostingView.swift
//  App
//
//  Created by JH Park on 2023/10/03.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem

struct NewPostingView: View {
  
  @Environment(\.presentationMode) var presentationMode
  
  typealias Core = NewPosting
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

    }
  }
  
  private func dismissAction() {
    self.presentationMode.wrappedValue.dismiss()
  }
}

struct NewPostingView_Previews: PreviewProvider {
  static var previews: some View {
    
    let store = Store(initialState: NewPosting.State()){
      NewPosting()
    }
    NewPostingView(store: store)
  }
}
