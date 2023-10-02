//
//  NotificationView.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem

struct NotificationView: View {
  
  typealias Core = Notification
  typealias State = Core.State
  typealias Action = Core.Action
  typealias Tab = Core.Tab
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    
    var selectedTab: Tab
    var tabs: [Tab]
    
    init(state: State) {
      selectedTab = state.selectedTab
      tabs = state.tabs
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
  var body: some View {
    VStack(spacing: 0){
      SlidingTab<Tab>(selection: viewStore.binding(get:\.selectedTab, send: Action.selectTab), tabs: viewStore.tabs)
      Spacer()
      Text(viewStore.selectedTab.rawValue)
      Spacer()
    }
    .navigationBarTitle("알림", displayMode: .inline)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

struct NotificationView_Previews: PreviewProvider {
  static var previews: some View {
    let store = Store(initialState: Notification.State()){
      Notification()
    }
    NavigationView {
      NotificationView(store: store)
    }
  }
}
