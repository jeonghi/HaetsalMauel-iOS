//
//  EventHomeView.swift
//  App
//
//  Created by 쩡화니 on 11/13/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct EventHomeView {
  typealias Core = EventHome
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  @ObservedObject var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    
    init(state: State){
    }
  }
  
  init(store: StoreOf<Core>){
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}


extension EventHomeView: View {
  var body: some View {
    VStack {
      WebView(url: "https://eumweb.netlify.app/", viewModel: WebViewModel())
    }
    .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  let store = Store(initialState: EventHome.State()){EventHome()}
  return VStack {
    EventHomeView(store: store)
  }
}
