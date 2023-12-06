//
//  MPApplyCreateView.swift
//  App
//
//  Created by 쩡화니 on 12/2/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import DesignSystemFoundation
import UISystem

struct MPApplyCreateView {
  
  @Environment(\.dismiss) var dismiss
  
  typealias Core = MPApplyCreate
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var introduction: String
    var showingPopup: Bool
    var isDismiss: Bool
    init(state: State) {
      isDismiss = state.isDismiss
      showingPopup = state.showingPopup
      introduction = state.introduction
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

extension MPApplyCreateView: View {
  var body: some View {
    
    if(viewStore.isDismiss){
      dismiss()
    }
    
    return VStack{
      ScrollView {
        VStack {
          applyForm
            .hLeading()
            .padding(.vertical, 30)
          
        }
        .padding(.horizontal, 22)
      }
      
      신청완료버튼
        .padding(.horizontal, 22)
    }
    .eumPopup(isShowing: viewStore.binding(get: \.showingPopup, send: Action.showingPopup)){
      AnyView(
        EumPopupView(title: "신청 하시겠습니까?", type: .oneLineTwoButton, firstButtonName: "취소", secondButtonName: "완료", firstButtonAction: {viewStore.send(.showingPopup(false))}, secondButtonAction: {viewStore.send(.tappedCreateApplyButton)} )
      )
    }
    .hideKeyboardWhenTappedAround()
    .background(Color(.white))
    .foregroundColor(Color(.black))
    .setCustomNavBarTitle("신청하기")
    .setCustomNavBackButton()
  }
}

extension MPApplyCreateView {
  
  private var 신청완료버튼: some View {
    Button(action: {viewStore.send(.showingPopup(true))}){
      Text("신청 완료")
    }
    .buttonStyle(PrimaryButtonStyle())
  }
  private var applyForm: some View {
    VStack(alignment: .leading, spacing: 30) {
      VStack(alignment: .leading, spacing: 16) {
        Text("신청 전 확인해주세요!")
          .font(.titleB)
          .foregroundColor(Color(.black))
        Text("참여 신청 후 도움 제공자로 선정되면 참여를\n취소할 수 없어요.")
          .font(.subR)
          .foregroundColor(Color(.systemgray07))
          .multilineTextAlignment(.leading)
      }
      
      VStack(alignment: .leading, spacing: 10){
        Text("신청 한 마디")
          .font(.subB)
        TextField("", text: viewStore.binding(get: \.introduction, send: Action.updateIntroduction), prompt: Text("상배방에게 간단한 인사말을 남겨요").font(.subR))
          .textStyle(.init(font: .subR, color: Color(.black)))
          .textFieldStyle(.plain)
          .padding(.vertical, 12)
          .padding(.horizontal, 10)
          .frame(maxWidth: .infinity)
          .background(
            RoundedRectangle(cornerRadius: 10)
              .fill(Color(.systemgray02))
              .overlay(
                RoundedRectangle(cornerRadius: 10)
                  .stroke(Color(.systemgray03), lineWidth: 1)
              )
              .padding(1)
          )
      }
    }
  }
}

#Preview {
  let store = Store(initialState: MPApplyCreate.State(postId: 2)){
    MPApplyCreate()
  }
  return NavigationView{MPApplyCreateView(store: store)}
}
