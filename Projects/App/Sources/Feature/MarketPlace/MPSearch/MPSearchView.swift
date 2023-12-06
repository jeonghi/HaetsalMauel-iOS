//
//  MPSearchView.swift
//  App
//
//  Created by 쩡화니 on 11/28/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem

struct MPSearchView: View {
  
  @Environment(\.presentationMode) var presentationMode
  
  typealias Core = MPSearch
  typealias State = Core.State
  typealias Action = Core.Action
  typealias Route = Core.Route
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var selectedRoute: Route?
    var postList: [MarketPostEntity.Response]
    var searchText: String
    init(state: State) {
      selectedRoute = state.selectedRoute
      postList = state.postList
      searchText = state.searchText
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
  var body: some View {
    VStack(spacing: 0) {
      // TODO: 검색창
      // TODO: 검색 결과
      
      NavigationLink(
        tag: Route.readPost,
        selection: viewStore.binding(get: \.selectedRoute, send: Action.setRoute),
        destination: {
          IfLetStore(MPPostingReadStore){
            MPPostingReadView(store: $0)
          }
        },
        label: EmptyView.init
      )
      
      SearchFieldView(searchText: viewStore.binding(get: \.searchText, send: Action.updateSearchText), searchButtonAction: {viewStore.send(.requestGetPostList)})
        .padding(.horizontal, 16)
      
      ScrollView {
        if(viewStore.postList.isEmpty) {
          검색결과없음
        }else {
          검색결과
        }
      }
      .refreshable {
        viewStore.send(.requestGetPostList)
      }
    }
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
    .foregroundColor(Color(.black))
    .background(Color(.white))
    .setCustomNavBackButton()
    .setCustomNavBarTitle("검색")
  }
}

extension MPSearchView {
  private var 검색결과: some View {
    LazyVStack(spacing: 0){
      ForEach(viewStore.postList, id: \.self){ post in
        Button(action: {viewStore.send(.tappedPostCell(post.postId))}){
          MPPostListCell(post: post)
            .padding(.vertical, 16)
        }
        Divider()
      }
    }
    .padding(.horizontal, 16)
    .background(Color(.white))
    .padding(.top, 5)
  }
  private var 검색결과없음: some View {
    VStack(alignment: .center){
      Text("검색 결과가 없어요")
        .font(.subR)
        .foregroundColor(Color(.gray07))
        .padding(.vertical, 100)
    }
  }
}

extension MPSearchView {
  private var MPPostingReadStore: Store<MPPostingRead.State?, MPPostingRead.Action> {
    return store.scope(state: \.MPPostingReadState, action: Action.MPPostingReadAction)
  }
}


#Preview {
  let store = Store(initialState: MPSearch.State()){
    MPSearch()
  }
  return NavigationView {MPSearchView(store: store)}
}
