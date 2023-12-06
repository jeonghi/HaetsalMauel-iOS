//
//  MPMyApplyView.swift
//  App
//
//  Created by 쩡화니 on 12/3/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem

struct MPMyApplyView {
  typealias Core = MPMyApply
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var myAppliedPostList: [MarketPostEntity.Response]
    init(state: State) {
      myAppliedPostList = state.myAppliedPostList
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

extension MPMyApplyView: View {
  var body: some View {
    VStack(spacing: 0) {
      Color.white.frame(height: 1)
      if(viewStore.myAppliedPostList.isEmpty){
        신청내역이_없는_경우
      }else {
        ScrollView {
          신청내역이_있는_경우
        }
        .background(
          Color(.systemgray02)
        )
      }
    }
    .background(Color.white)
    .foregroundColor(Color.black)
    .setCustomNavBarTitle("활동 신청 목록")
    .setCustomNavBackButton()
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
  }
}

extension MPMyApplyView {
  private var 신청내역이_없는_경우: some View {
    Text("아직 활동 신청 내역이 없어요.\n햇터를 통해 활동을 시작해보세요!")
      .foregroundColor(Color(.systemgray06))
      .padding(.vertical, 60)
  }
  private var 신청내역이_있는_경우: some View {
    return LazyVStack(spacing: 0) {
      ForEach(viewStore.myAppliedPostList, id: \.self){ post in
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
  let store = Store(initialState: MPMyApply.State()){
    MPMyApply()
  }
  return NavigationView {MPMyApplyView(store: store)}
}
