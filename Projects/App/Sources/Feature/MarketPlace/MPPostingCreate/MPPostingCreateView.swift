//
//  MPPostingCreateView.swift
//  App
//
//  Created by 쩡화니 on 11/16/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem
import DesignSystemFoundation

struct MPPostingCreateView {
  
  @Environment(\.dismiss) private var dismiss
  
  typealias Core = MPPostingCreate
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
}

extension MPPostingCreateView: View {
  var body: some View {
    VStack {
      Color.white.frame(height: 1)
      ScrollView(showsIndicators: false){
        타이틀
          .padding(.horizontal, 23.5)
          .padding(.top, 40)
          .padding(.bottom, 16)
        비추기종류
          .padding(.horizontal, 23.5)
        분할
        입력폼
          .padding(.horizontal, 23.5)
        분할
        글내용
        버튼들
          .padding(.horizontal, 16)
          .padding(.bottom, 58)
          .padding(.top, 10)
      }
    }
    .setCustomNavCloseButton()
    .setCustomNavBarTitle("글쓰기")
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
  }
}

extension MPPostingCreateView {
  
  private var 타이틀: some View {
    Text("이웃과 햇살을 나눠요")
      .hLeading()
      .font(.headerB)
      .foregroundColor(Color(.black))
  }
  
  private var 분할: some View {
    Rectangle()
      .fill(Color(.systemgray02))
      .frame(height: 5)
      .padding(.top, 45)
      .padding(.bottom, 20)
  }
  
  private var 입력폼: some View {
    VStack(spacing: 30) {
      거래유형
      활동장소
      활동날짜
      활동시간대
      예상소요시간
      최대모집인원
    }
  }
  
  private var 글내용: some View {
    VStack {
      
    }
  }
  
  private var 비추기종류: some View {
    containerBox("비추기 종류"){
      MarketCategorySelectionView(store: MarketCategorySelectionStore)
    }
  }
  
  private var 거래유형: some View {
    containerBox("거래 유형"){
      
    }
  }
  
  private var 활동장소: some View {
    containerBox("활동 장소"){
      
    }
  }
  
  private var 활동날짜: some View {
    containerBox("활동 날짜"){
      
    }
  }
  
  private var 활동시간대: some View {
    containerBox("활동 시간대"){
      
    }
  }
  
  private var 예상소요시간: some View {
    containerBox("예상 소요 시간"){
      
    }
  }
  
  private var 최대모집인원: some View {
    containerBox("최대 모집 인원"){
      
    }
  }
  
  private var 버튼들: some View {
    HStack {
      Button(action:{}){
        Text("작성취소")
      }
      .buttonStyle(SecondaryButtonStyle())
      Button(action: {}){
        Text("작성완료")
      }
      .buttonStyle(PrimaryButtonStyle())
    }
  }
  
  private func containerBox<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
    VStack(spacing: 20) {
      Text(title)
        .font(.subB)
        .hLeading().foregroundColor(Color(.black))
      content()
        .hLeading()
    }
    .frame(maxHeight: .infinity)
  }
}

// MARK: Store init
extension MPPostingCreateView {
  private var MarketCategorySelectionStore: StoreOf<MarketCategorySelection> {
    return store.scope(state: \.marketCategorySelectionState, action: Action.marketCategorySelectionAction)
  }
}

#Preview {
  let store = Store(initialState: MPPostingCreate.State()){
    MPPostingCreate()
  }
  return NavigationView{MPPostingCreateView(store: store)}
}
