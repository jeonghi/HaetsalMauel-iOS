//
//  CommunityHomeView.swift
//  App
//
//  Created by JH Park on 2023/10/02.
//  Copyright © 2023 com.eum. All rights reserved.
//
import ComposableArchitecture
import SwiftUI
import DesignSystemFoundation
import UISystem

struct CMHomeView: View {
  
  typealias Core = CMHome
  typealias State = Core.State
  typealias Action = Core.Action
  typealias Category = Core.Category
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var showingSheet: Bool
    init(state: State) {
      self.showingSheet = state.showingFullScreenOver
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
  
  var body: some View {
    ZStack {
      VStack {
        Color.white.frame(height: 1)
        ScrollView {
          어떤소통을원하세요
            .hLeading()
            .padding(.top, 20)
            .padding(.horizontal, 16)
          분할
            .padding(.vertical, 20)
          핫게시글목록
            .padding(.horizontal, 16)
        }
      }
    }
    .fullScreenCover(isPresented: viewStore.binding(get: \.showingSheet, send: Action.dismissFullScreenOver)){
      IfLetStore(newPostingStore){store in NewPostingView(store: store)}
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

extension CMHomeView {
  
  private var 어떤소통을원하세요: some View {
    VStack(alignment: .leading, spacing: 34.5){
      Text("어떤 소통을 원하세요?")
        .font(.headerB)
        .hLeading()
      카테고리목록
        .hLeading()
    }
  }
  
  private var 분할: some View {
    Rectangle()
      .fill(Color(.systemgray02))
      .frame(height: 5)
      .frame(maxWidth: .infinity)
  }
  
  private var 카테고리목록: some View {
    HStack(alignment: .center, spacing: 10) {
      NavigationLink(destination: CMVoteView(store: .init(initialState: CMVote.State()){CMVote()})){
        CategoryButton(Category.투표.cvtAssetImage(), Category.투표.rawValue, false)
          
      }
      NavigationLink(destination: CMDiscussionView(store: .init(initialState: CMDiscussion.State()){CMDiscussion()})){
        CategoryButton(Category.수다떨기.cvtAssetImage(), Category.수다떨기.rawValue, false)
      }
    }
  }
  
  private var 핫게시글목록: some View {
    VStack {
      핫게헤더
      LazyVStack {
        Text("지금은 인기있는 게시글이 없어요\n글을 작성해 마을을 따뜻하게 해주세요")
          .multilineTextAlignment(.center)
          .foregroundColor(Color(.systemgray06))
          .padding(.vertical, 40)
          .font(.subR)
      }
    }
  }
  
  private var 핫게헤더: some View {
    HStack {
      Text("지금 따뜻한 마을")
        .font(.headerB)
        .foregroundColor(Color(.black))
      Spacer()
      NavigationLink(destination: CMHotView(store: .init(initialState: CMHot.State()){CMHot()})){
        HStack(spacing: 2) {
          Text("더보기")
            .font(.subR)
          ImageAsset.chevronRight.toImage()
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .frame(height: 24)
        }
        .foregroundColor(Color(.gray07))
      }
    }
  }
}

// MARK: - Store init
extension CMHomeView {
  private var newPostingStore: Store<NewPosting.State?, NewPosting.Action> {
    return store.scope(state: \.newPostingState, action: Action.newPostingAction)
  }
}

#Preview {
  let store = Store(initialState: CMHome.State()){
    CMHome()
  }
  return NavigationView {
    CMHomeView(store: store)
  }
}
