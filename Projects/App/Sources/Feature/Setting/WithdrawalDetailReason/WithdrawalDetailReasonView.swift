//
//  WithdrawalDetailReasonView.swift
//  App
//
//  Created by 쩡화니 on 12/5/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem
import DesignSystemFoundation

struct WithdrawalDetailReasonView {
  
  @Environment(\.dismiss) private var dismiss
  
  typealias Core = WithdrawalDetailReason
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var detailReason: String
    var isShowingPopup: Bool
    init(state: State) {
      detailReason = state.detailReason
      isShowingPopup = state.isShowingPopup
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

// MARK: Layout init
extension WithdrawalDetailReasonView: View {
  var body: some View {
    VStack(spacing: 0) {
      Color.white.frame(height: 1)
      ScrollView {
        VStack(spacing: 30) {
          Color.clear
          VStack(spacing: 16){
            Text("소중한 의견을 알려주시면 더 나은\n서비스를 만들어나갈게요")
              .font(.titleB)
              .foregroundColor(Color(.black))
              .hLeading()
            Text("더 나은 햇살마을이 될 수 있도록 계속해서\n노력하겠습니다.")
              .font(.subR)
              .foregroundColor(Color(.systemgray06))
              .hLeading()
          }
          .hLeading()
          입력폼
        }
        .padding(.horizontal, 22)
      }
      버튼들
        .padding(.horizontal, 22)
        .padding(.bottom, 20)
    }
    .eumPopup(isShowing: viewStore.binding(get: \.isShowingPopup, send: Action.dismissPopup)){
      AnyView(
        EumPopupView(title:"정말 탈퇴하시겠습니까?", type: .oneLineTwoButton, firstButtonName: "취소", secondButtonName: "완료", firstButtonAction: {viewStore.send(.dismissPopup)}, secondButtonAction: {viewStore.send(.tappedWithdrawalButton)})
      )
    }
    .background(Color.white)
    .foregroundColor(Color.black)
    .setCustomNavBarTitle("")
    .setCustomNavBackButton()
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
  }
}


// MARK: Component init
extension WithdrawalDetailReasonView {
  
  private var 입력폼: some View {
    TextEditor(text: viewStore.binding(get: \.detailReason, send: Action.updateDetailReason))
      .foregroundColor(Color.black)
      .colorMultiply(Color(.systemgray02))
      .textFieldStyle(.plain)
      .frame(minHeight: 204, maxHeight: 204)
      .padding(12)
      .frame(maxWidth: .infinity)
      .background(
        ZStack {
          RoundedRectangle(cornerRadius: 10)
            .fill(Color(.systemgray02))
        }
      )
  }
  
  private var 버튼들: some View {
    HStack(spacing: 10) {
      Button(action: {viewStore.send(.tappedNextButton)}){
        Text("탈퇴하기")
      }.buttonStyle(SecondaryButtonStyle())
      Button(action: {dismiss()}){
        Text("계속 함께하기")
      }.buttonStyle(PrimaryButtonStyle())
    }
  }
}


#Preview {
  let store = Store(initialState: WithdrawalDetailReason.State()){
    WithdrawalDetailReason()
  }
  return NavigationView {WithdrawalDetailReasonView(store: store)}
}
