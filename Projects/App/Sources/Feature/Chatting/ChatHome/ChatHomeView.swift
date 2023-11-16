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

extension ChatHomeView: View {
  var body: some View {
    VStack(spacing: 0) {
      탭바
      ScrollView {
        탭바내용
      }
    }
    .vTop()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onAppear{
      viewStore.send(.onAppear)
    }
  }
}

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
        내_게시글
      case .이웃_게시글:
        이웃_게시글
      }
    }
  }
  
  private var 내_게시글: some View {
    LazyVStack(spacing: 0) {
      NavigationLink( destination: EumChatView(store: eumChatStore)){
        ChatListCell(profileUrl: URL(string: ""), userName: "성북구 토박이", description: "이번주 토요일 오후 1시 30분에 성북이발소에서", createdAt: Date(), unread: 100)
      }
      
      NavigationLink( destination: EumChatView(store: eumChatStore)){
        ChatListCell(profileUrl: URL(string: ""), userName: "마을 이장님", description: "더미데이터더미데이터데이터더미데이터더미데이터더미데이터데이터더미데이터", createdAt: Date(), unread: 1)
      }
        
      ChatListCell(profileUrl: URL(string: ""), userName: "정릉동 수호신", description: "더미데이터더미데이터데이터더미데이터", createdAt: Date(), unread: 0)
      }
  }
  
  private var 이웃_게시글: some View {
    LazyVStack(spacing: 0) {
      NavigationLink( destination: EumChatView(store: eumChatStore)){
        ChatListCell(profileUrl: URL(string: ""), userName: "닉네임", description: "채팅 내용", createdAt: Date(), unread: 0)
      }
      ChatListCell(profileUrl: URL(string: ""), userName: "닉네임", description: "채팅 내용", createdAt: Date(), unread: 1)
      ChatListCell(profileUrl: URL(string: ""), userName: "닉네임", description: "채팅 내용", createdAt: Date(), unread: 0)
    }
  }
}

extension ChatHomeView {
  private var eumChatStore: StoreOf<EumChat> {
    return Store(initialState: EumChat.State()){EumChat()}
  }
}

struct ChatHomeView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      let store = Store(initialState: ChatHome.State()){
        ChatHome()
      }
      NavigationView {
        ChatHomeView(store: store)
      }
    }
  }
}
