//
//  MPMyPostListView.swift
//  App
//
//  Created by 쩡화니 on 12/3/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import DesignSystemFoundation
import UISystem

struct MyPostListView {
  
  typealias Core = MyPostList
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var myPostList: [MarketPostEntity.Response]
    init(state: State) {
      myPostList = state.myPostList
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

extension MyPostListView: View {
  var body: some View {
    VStack(spacing: 0) {
      Color.white.frame(height: 1)
      if(viewStore.myPostList.isEmpty){
        내가_쓴_게시글이_없는_경우
      }else {
        ScrollView {
          내가_쓴_게시글이_있는_경우
        }
        .background(
          Color(.systemgray02)
        )
      }
    }
    .background(Color.white)
    .foregroundColor(Color.black)
    .setCustomNavBarTitle("내가 쓴 게시글")
    .setCustomNavBackButton()
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
  }
}

extension MyPostListView {
  private var 내가_쓴_게시글이_없는_경우: some View {
    Text("아직 내가 작성한 게시글이 없어요.\n글을 작성하고 이웃들과 함께 소통해봐요!")
      .multilineTextAlignment(.center)
      .multilineTextAlignment(.center)
      .foregroundColor(Color(.systemgray06))
      .padding(.vertical, 60)
  }
  private var 내가_쓴_게시글이_있는_경우: some View {
    return LazyVStack(spacing: 0) {
      ForEach(viewStore.myPostList, id: \.self){ post in
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
