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
    var isShowingFullSheet: Bool
    init(state: State) {
      isShowingFullSheet = state.isShowingFullSheet
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
  
  var body: some View {
    ZStack {
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
      newPostButton
        .vBottom()
        .hTrailing()
        .padding()
    }
    .background(Color(.white))
    .setCustomNavBackButton()
    .setCustomNavBarTitle("수다떨기")
    .toolbar {
      ToolbarItemGroup(placement: .navigationBarTrailing){
        Button(action:{}){
          fitToImage(.검색, 24)
        }
        .foregroundColor(Color(.black))
      }
    }
    .fullScreenCover(isPresented: viewStore.binding(get: \.isShowingFullSheet, send: Action.dismissFullSheet)){
      NavigationView{CMDiscussionCreateView(store: CMDiscussionCreateStore)}
    }
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
  
  private func fitToImage(_ image: ImageAsset, _ imageHeight: CGFloat) -> some View {
    image.toImage()
      .renderingMode(.template)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(height: imageHeight)
  }
  
  private var discussionList: some View {
    LazyVStack(spacing: 0){
      NavigationLink(destination: CMDiscussionReadView(store: CMDiscussionReadStore)){
        CMDiscussionListCell(title: "다들 오늘 수능 잘보자 퐈이팅 넘나 떨려용 ㅎㅎㅎㅎ!! ㅎㅎㅎㅎ ", likeCnt: 3, commentCnt: 2, locationName: "정릉 제 2동", createdAt: Date())
          .padding(.vertical, 16)
      }
      Divider()
      CMDiscussionListCell(title: "제목", likeCnt: 2, commentCnt: 100, locationName: "정릉 제 2동", createdAt: Date())
        .padding(.vertical, 16)
      Divider()
      CMDiscussionListCell(title: "제목", likeCnt: 0, commentCnt: 2, locationName: "정릉 제 2동", createdAt: Date())
        .padding(.vertical, 16)
      Divider()
      CMDiscussionListCell(title: "제목", likeCnt: 1, commentCnt: 2, locationName: "정릉 제 2동", createdAt: Date())        .padding(.vertical, 16)
      Divider()
    }
    .padding(.horizontal, 16)
  }
}

extension CMDiscussionView {
  private var CMDiscussionReadStore: StoreOf<CMDiscussionRead> {
    return store.scope(state: \.CMDiscussionReadState, action: Action.CMDiscussionReadAction)
  }
  
  private var CMDiscussionCreateStore: StoreOf<CMDiscussionCreate> {
    return store.scope(state: \.CMDiscussionCreateState, action: Action.CMDiscussionCreateAction)
  }
  
  private var newPostButton: some View {
    Button(action:{viewStore.send(.showingFullSheet)}){
      NewPostLabel()
    }
  }
}

#Preview {
  let store = Store(initialState: CMDiscussion.State()){CMDiscussion()}
  return NavigationView {CMDiscussionView(store: store)}
}
