//
//  CommunityDiscussionView.swift
//  App
//
//  Created by 쩡화니 on 11/15/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import DesignSystemFoundation
import UISystem

struct CMDiscussionView: View {

  typealias Core = CMDiscussion
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
      Color.white
        .frame(height: 1)
      ScrollView {
        discussionList
          .background(Color(.white))
          .padding(.top, 5)
      }
      .background(
        Color(.systemgray02)
      )
    }
    .background(Color(.white))
    .setCustomNavBackButton()
    .setCustomNavBarTitle("의견")
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
  }
}

extension CMDiscussionView {
  private var discussionList: some View {
    LazyVStack(spacing: 0){
      NavigationLink(destination: CMDiscussionReadView(store: CMDiscussionReadStore)){
        CMDiscussionListCell(title: "제목", likeCnt: 0, commentCnt: 2, locationName: "정릉 제 2동", createdAt: Date())
          .padding(.vertical, 16)
      }
      Divider()
      CMDiscussionListCell(title: "제목", likeCnt: 0, commentCnt: 2, locationName: "정릉 제 2동", createdAt: Date())
        .padding(.vertical, 16)
      Divider()
      CMDiscussionListCell(title: "제목", likeCnt: 0, commentCnt: 2, locationName: "정릉 제 2동", createdAt: Date())
        .padding(.vertical, 16)
      Divider()
      CMDiscussionListCell(title: "제목", likeCnt: 0, commentCnt: 2, locationName: "정릉 제 2동", createdAt: Date())        .padding(.vertical, 16)
      Divider()
    }
    .padding(.horizontal, 16)
  }
}

extension CMDiscussionView {
  private var CMDiscussionReadStore: StoreOf<CMDiscussionRead> {
    return store.scope(state: \.CMDiscussionReadState, action: Action.CMDiscussionReadAction)
  }
}

#Preview {
  let store = Store(initialState: CMDiscussion.State()){CMDiscussion()}
  return NavigationView {CMDiscussionView(store: store)}
}
