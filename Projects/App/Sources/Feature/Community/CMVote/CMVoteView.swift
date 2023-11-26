//
//  CommunityVoteView.swift
//  App
//
//  Created by 쩡화니 on 11/15/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import DesignSystemFoundation
import UISystem

struct CMVoteView: View {
  
  typealias Core = CMVote
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
          voteList
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
    .setCustomNavBarTitle("투표")
    .toolbar {
      ToolbarItemGroup(placement: .navigationBarTrailing){
        Button(action:{}){
          fitToImage(.검색, 24)
        }
        .foregroundColor(Color(.black))
      }
    }
    .fullScreenCover(isPresented: viewStore.binding(get: \.isShowingFullSheet, send: Action.dismissFullSheet)){
      NavigationView{CMVoteCreateView(store: CMVoteCreateStore)}
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

extension CMVoteView {
  
  private func fitToImage(_ image: ImageAsset, _ imageHeight: CGFloat) -> some View {
    image.toImage()
      .renderingMode(.template)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(height: imageHeight)
  }

  
  private var voteList: some View {
    LazyVStack(spacing: 0){
      NavigationLink(destination: CMVoteReadView(store: CMVoteReadStore)){
        CMVoteListCell(postStatus: .투표중, title: "봉국사 앞쪽 도로 움푹 파진거 보강 공사가 필요할 것 같아요", locationName: "정릉 제2동", createdAt: Date())
          .padding(.vertical, 16)
      }
      Divider()
      CMVoteListCell(postStatus: .종료됨, title: "제목", locationName: "정릉 제3동", createdAt: Date()-310000)
        .padding(.vertical, 16)
      Divider()
      CMVoteListCell(postStatus: .종료됨, title: "제목", locationName: "정릉 제3동", createdAt: Date()-310000)
        .padding(.vertical, 16)
      Divider()
      CMVoteListCell(postStatus: .종료됨, title: "제목", locationName: "정릉 제3동", createdAt: Date()-310000)
        .padding(.vertical, 16)
      Divider()
    }
    .padding(.horizontal, 16)
  }
  
  private var newPostButton: some View {
    Button(action:{viewStore.send(.showingFullSheet)}){
      NewPostLabel()
    }
  }
}

extension CMVoteView {
  
  private var CMVoteReadStore: StoreOf<CMVoteRead> {
    return store.scope(state: \.CMVoteReadState, action: Action.CMVoteReadAction)
  }
  
  private var CMVoteCreateStore: StoreOf<CMVoteCreate> {
    return store.scope(state: \.CMVoteCreateState, action: Action.CMVoteCreateAction)
  }
}

#Preview {
  let store = Store(initialState: CMVote.State()){CMVote()}
  return NavigationView {CMVoteView(store: store)}
}
