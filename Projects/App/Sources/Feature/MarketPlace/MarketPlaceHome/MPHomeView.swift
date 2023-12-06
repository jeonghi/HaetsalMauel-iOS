//
//  MarketPlaceHomeView.swift
//  App
//
//  Created by 쩡화니 on 11/9/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import DesignSystemFoundation
import UISystem

struct MPHomeView {
  
  typealias Core = MPHome
  typealias State = Core.State
  typealias Action = Core.Action
  typealias Route = Core.Route
  typealias Tab = Core.Tab
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var selectedRoute: Route?
    var postList: [MarketPostEntity.Response]
    var selectedCat: MPCategory?
    var selectedTab: Tab?
    var isShowingFullSheet: Bool
    var fullSheetType: Core.FullSheetType?
    var isCheckedShowOnlyProceeding: Bool
    init(state: State) {
      selectedRoute = state.selectedRoute
      postList = state.postList
      selectedCat = state.selectedCat
      isShowingFullSheet = state.isShowingFullSheet
      fullSheetType = state.fullSheetType
      selectedTab = state.selectedTab
      isCheckedShowOnlyProceeding = state.showOnlyProceeding
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

// MARK: Layout init
extension MPHomeView: View {
  var body: some View {
    ZStack {
      NavigationLink(destination: MPPostingReadView(store: MPPostingReadStore), tag: Route.readPost, selection: viewStore.binding(get: \.selectedRoute, send: Action.setRoute)){
        EmptyView()
      }
      VStack(spacing: 0) {
        header
        contentVList 
      }
      newPostButton
        .vBottom()
        .hTrailing()
        .padding()

    }
    .background(Color(.white))
    .fullScreenCover(isPresented: viewStore.binding(get: \.isShowingFullSheet, send: Action.dismissFullSheet)){
      if let type = viewStore.fullSheetType {
        switch type {
        case .글쓰기:
          NavigationView {
            MPPostingCreateView(store: MPPostingCreateStore)
          }
        case .카테고리선택:
          NavigationView {MarketPlaceCategorySelectionView(store: marketPlaceCategorySelectionStore)
          }
        }
      }
    }
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
  }
}

// MARK: Component init
extension MPHomeView {
  
  private var header: some View {
    VStack {
      Button(action: {viewStore.send(.카테고리선택하기)}){
        HStack {
            Text("\(viewStore.selectedCat?.rawValue ?? "전체")")
              .font(.subB)
              .foregroundColor(Color(.systemgray07))
              .padding(.horizontal, 10)
              .padding(.vertical, 6)
              .background(RoundedRectangle(cornerRadius: 6).fill(Color(.systemgray02)))
          ImageAsset.chevronRight.toImage()
        }
        .hLeading()
        .padding(.horizontal, 10)
      }
      .frame(maxWidth: .infinity)
      filterList
    }
  }
  
  private var filterList: some View {
    VStack {
      Divider()
      HStack {
        ScrollingTab(selection: viewStore.binding(get: \.selectedTab, send: Action.selectTab), tabs: Tab.allCases)
        Spacer()
        Button(action: {viewStore.send(.tappedShowOnlyProceedingButton)}){
          HStack(spacing: 5){
            Text("모집중만 보기")
              .font(.descriptionR)
            ImageAsset.check.toImage()
              .renderingMode(.template)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(height: 24)
          }
        }
        .foregroundColor(viewStore.isCheckedShowOnlyProceeding ? Color(.black) : Color(.gray07))
      }
      .padding(.horizontal, 10)
      Divider()
    }
  }
  
  private var contentVList: some View {
    ScrollView {
      LazyVStack(spacing: 0) {

        ForEach(viewStore.postList, id: \.self){ data in
          Button(action: {viewStore.send(.tappedReadPost(data.postId))}){
            MPPostListCell(post: data)
              .padding(.horizontal, 16)
              .padding(.vertical, 16)
              .frame(maxWidth: .infinity)
              .background(Color(.white))
          }
          Divider()
        }
      }
      .padding(.top, 5)
    }
    .refreshable {
      viewStore.send(.requestGetPostList)
    }
    .background(Color(.systemgray02))
  }
  
  private var newPostButton: some View {
    Button(action:{viewStore.send(.tappedCreatePostButton)}){
      NewPostLabel()
    }
  }
}

// MARK: Store init
extension MPHomeView {
  
  private var marketPlaceCategorySelectionStore: StoreOf<MarketPlaceCategorySelection> {
    return store.scope(state: \.marketPlaceCategorySelectionState, action: Action.marketPlaceCategorySelectionAction)
  }
  
  private var MPPostingCreateStore: StoreOf<MPPostingCreate> {
    return store.scope(state: \.MPPostingCreateState, action: Action.MPPostingCreateAction)
  }
  
  private var MPPostingReadStore: StoreOf<MPPostingRead> {
    return store.scope(state: \.MPPostingReadState, action: Action.MPPostingReadAction)
  }
}

// MARK: Preview
#Preview {
  let store = Store(initialState: MPHome.State()){MPHome()}
  return NavigationView {MPHomeView(store: store)}
}
