//
//  MPPartyApplicationListView.swift
//  App
//
//  Created by 쩡화니 on 11/21/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem
import DesignSystemFoundation

struct MPApplicationListView: View {
  
  typealias Core = MPApplicationList
  typealias State = Core.State
  typealias Action = Core.Action
  typealias PopupType = Core.PopupType
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var isLoading: Bool
    var isShowingPopup: Bool
    var popupType: PopupType
    var applyCellModels: [MPPostApplyListCell.ViewModel]
    var isAnyChecked: Bool
    
    init(state: State) {
      isLoading = state.isLoading
      isShowingPopup = state.isShowingPopup
      popupType = state.popupType
      applyCellModels = state.applyCellModels
      isAnyChecked = state.isAnyChecked
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
  var body: some View {
    ZStack {
      VStack(spacing: 20) {
        
        참여대기자수_라벨
          .hLeading()
          .padding(.top, 16)
          .padding(.horizontal, 16)
        
        if viewStore.applyCellModels.isEmpty {
          참여대기자_없음
        }else {
          ScrollView {
            참여대기자_목록
          }
          .refreshable {
            viewStore.send(.requestGetApplicantList)
          }
        }
        참여수락
          .padding(.horizontal, 16)
      }
      if(viewStore.isLoading){
        Color.white
        ProgressView()
      }
    }
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
    .onLoad{
      viewStore.send(.onLoad)
    }
    .eumPopup(isShowing: viewStore.binding(get: \.isShowingPopup, send: Action.dismissPopup)){
      switch viewStore.popupType {
      case .참여수락여부확인:
        AnyView(
          EumPopupView(title: "선택한 이웃의 참여를 수락하시겠습니까?", type: .oneLineTwoButton, firstButtonName: "취소", secondButtonName: "완료", firstButtonAction: {viewStore.send(.tappedButton(.AcceptCancel))}, secondButtonAction: {viewStore.send(.tappedButton(.AcceptConfirm))})
        )
      case .정상확인:
        AnyView(
          EumPopupView(title: "참여 수락 완료", subtitle: "참여 이웃과의 채팅방이 개설되었어요",type: .twoLineOneButton, firstButtonName: "채팅방으로", firstButtonAction: {viewStore.send(.tappedButton(.GoChatRoom))})
        )
      }
    }
    .setCustomNavBackButton()
    .setCustomNavBarTitle("신청 목록")
  }
}

extension MPApplicationListView {
  
  private var 참여대기자수_라벨: some View {
    Text("참여 대기자 \(viewStore.applyCellModels.count)")
      .font(.subB)
  }
  
  private var 참여대기자_목록: some View {
    
    return LazyVStack(spacing: 0) {
      ForEach(viewStore.applyCellModels, id:\.self){ model in
        Button(action: {viewStore.send(.check(model.id))}){
          MPPostApplyListCell(model)
        }
      }
    }
  }
  
  private var 참여대기자_없음: some View {
    Text("현재 참여 대기중인 이웃이 없어요")
      .font(.subR)
      .foregroundColor(Color(.systemgray06))
      .hCenter()
      .vCenter()
  }
  
  private var 참여수락: some View {
    Button(action: {viewStore.send(.tappedButton(.Accept))}){
      Text("참여 수락")
    }
    .buttonStyle(PrimaryButtonStyle())
    .disabled(!viewStore.isAnyChecked)
  }
}

#Preview {
  let store = Store(initialState: MPApplicationList.State(postId: 4)){
    MPApplicationList()
  }
  return NavigationView{MPApplicationListView(store: store)}
}
