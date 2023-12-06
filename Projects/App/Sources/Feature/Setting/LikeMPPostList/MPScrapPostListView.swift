//
//  LikeMPPostListView.swift
//  App
//
//  Created by 쩡화니 on 11/28/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem
import DesignSystemFoundation

struct MPScrapPostListView {
  
  typealias Core = MPScrapPostList
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var myScrapPostList: [MarketPostEntity.Response]
    init(state: State) {
      myScrapPostList = state.myScrapPostList
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

extension MPScrapPostListView: View {
  var body: some View {
    VStack(spacing: 0) {
      Color.white.frame(height: 1)
      if(viewStore.myScrapPostList.isEmpty){
        신청내역이_없는_경우
      }else {
        ScrollView {
          신청내역이_있는_경우
        }
        .refreshable {
          viewStore.send(.requestMyScrapPostList)
        }
        .background(
          Color(.systemgray02)
        )
      }
    }
    .background(Color.white)
    .foregroundColor(Color.black)
    .setCustomNavBarTitle("관심 게시글")
    .setCustomNavBackButton()
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
  }
}

extension MPScrapPostListView {
  private var 신청내역이_없는_경우: some View {
    Text("아직 관심있게 본 게시글이 없어요.\n햇터에서 관심 게시글 등록을 할 수 있어요.")
      .multilineTextAlignment(.center)
      .multilineTextAlignment(.center)
      .foregroundColor(Color(.systemgray06))
      .padding(.vertical, 60)
  }
  private var 신청내역이_있는_경우: some View {
    return LazyVStack(spacing: 0) {
      ForEach(viewStore.myScrapPostList, id: \.self){ post in
        NavigationLink(destination: MPPostingReadView(store: .init(initialState: MPPostingRead.State(postId: post.postId)){MPPostingRead()})){
          MPPostListCell(post: post)
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(Color.white)
        }
        Divider()
          .padding(.horizontal, 16)
      }
    }.background(Color.white)
  }
}

#Preview {
  let store = Store(initialState: MPScrapPostList.State()){
    MPScrapPostList()
  }
  return MPScrapPostListView(store: store)
}
