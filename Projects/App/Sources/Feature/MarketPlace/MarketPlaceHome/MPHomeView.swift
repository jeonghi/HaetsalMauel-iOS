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
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  typealias Category = Core.Category
  typealias Tab = Core.Tab
  
  struct ViewState: Equatable {
    var selectedCat: Category?
    var selectedTab: Tab?
    var isShowingFullSheet: Bool
    var fullSheetType: Core.FullSheetType?
    init(state: State) {
      selectedCat = state.selectedCat
      isShowingFullSheet = state.isShowingFullSheet
      fullSheetType = state.fullSheetType
      selectedTab = state.selectedTab
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
      VStack(spacing: 0) {
        header
        contentVList
        
      }
      newPostButton
        .vBottom()
        .hTrailing()
        .padding()
      if let _ = viewStore.selectedCat {} else {
        Color.white
      }
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
          MarketPlaceCategorySelectionView(store: marketPlaceCategorySelectionStore)
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
          if let cat = viewStore.selectedCat?.rawValue {
            Text("\(cat)")
              .font(.subB)
              .foregroundColor(Color(.systemgray07))
              .padding(.horizontal, 10)
              .padding(.vertical, 6)
              .background(RoundedRectangle(cornerRadius: 6).fill(Color(.systemgray02)))
          }
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
      }
      .padding(.horizontal, 10)
      Divider()
    }
  }
  
  private var contentVList: some View {
    ScrollView {
      LazyVStack(spacing: 0) {

        NavigationLink(destination: MPPostingReadView(store: .init(initialState: MPPostingRead.State()){MPPostingRead()})) {
          MPPostListCell(postType: .도움요청, postStatus: .모집중, pointAmount: 100, title: "이번주 토요일 같이 말동무 해주실 분", commentCnt: 1, locationName: "정릉3동", createdAt: Date())
            .padding(.vertical, 16)
        }
        Divider()
        MPPostListCell(postType: .도움요청, postStatus: .모집완료, pointAmount: 200, title: "죽 좀 끓여주실분", commentCnt: 0, locationName: "정릉3동", createdAt: Date())
          .padding(.vertical, 16)
        MPPostListCell(postType: .도움제공, postStatus: .모집완료, pointAmount: 200, title: "대신 장봐드립니다", commentCnt: 0, locationName: "정릉3동", createdAt: Date())
          .padding(.vertical, 16)
        MPPostListCell(postType: .도움제공, postStatus: .모집중, pointAmount: 200, title: "전등 교체 해드려요", commentCnt: 100, locationName: "정릉3동", createdAt: Date())
          .padding(.vertical, 16)
        Divider()
      }
      .padding(.horizontal, 16)
      .background(Color(.white))
      .padding(.top, 5)
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
}

// MARK: Preview
#Preview {
  let store = Store(initialState: MPHome.State()){MPHome()}
  return NavigationView {MPHomeView(store: store)}
}
