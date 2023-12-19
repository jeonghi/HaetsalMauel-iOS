//
//  ChatHomeView.swift
//  App
//
//  Created by JH Park on 2023/10/27.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem

struct ChatHomeView {
  
  typealias Core = ChatHome
  typealias State = Core.State
  typealias Action = Core.Action
  typealias Tab = Core.Tab
  
  private let store: StoreOf<Core>
  @ObservedObject var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var selectedTab: Tab
    init(state: State){
      selectedTab = state.selectedTab
    }
  }
  
  init(store: StoreOf<Core>){
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

// MARK: Layout init
extension ChatHomeView: View {
  var body: some View {
    ZStack {
      VStack(spacing: 0) {
        Color.white.frame(height: 1)
        탭바
        ScrollView {
          탭바내용
        }
        .refreshable {
          
        }
      }
    }
    .background(Color(.white))
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
  }
}

// MARK: Component init
extension ChatHomeView {
  private var 탭바: some View {
    SlidingTab(
      selection: viewStore.binding(
        get: \.selectedTab,
        send: Action.setTab
      ),
      tabs: Tab.allCases
    )
    .padding(.horizontal, 16)
  }
  
  private var 탭바내용: some View {
    VStack(spacing: 0) {
      switch viewStore.selectedTab {
      case .내_게시글:
        EmptyView()
      case .이웃_게시글:
        EmptyView()
      }
    }
  }
}

// MARK: Store init
extension ChatHomeView {
  private var eumChatStore: StoreOf<EumChat> {
    return Store(initialState: EumChat.State()){EumChat()}
  }
}

// MARK: Preview
#Preview {
  let store = Store(initialState: ChatHome.State()){
    ChatHome()
  }
  return NavigationView {
    ChatHomeView(store: store)
  }
}
