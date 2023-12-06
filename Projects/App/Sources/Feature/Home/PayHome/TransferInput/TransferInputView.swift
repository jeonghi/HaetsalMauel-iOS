//
//  TransferInputView.swift
//  App
//
//  Created by JH Park on 2023/10/14.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem

struct TransferInputView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  typealias Core = TransferInput
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var isDismiss: Bool
    var receiverName: String
    var amount: String
    var isShowingPopup: Bool
    var isShowingFullsheet: Bool
    var allFilledInputField: Bool
    var password: String
    init(state: State) {
      isDismiss = state.isDismiss
      receiverName = state.receiverName
      amount = state.amount
      isShowingPopup = state.isShowingPopup
      isShowingFullsheet = state.isShowingFullSheet
      allFilledInputField = state.allFilledInputField
      password = state.password
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

// MARK: View
extension TransferInputView {
  var body: some View {
    if(viewStore.isDismiss) {
      dismiss()
    }
    return ZStack {
      ScrollView {
        commentText
          .padding(.top, 30)
          .padding(.horizontal, 20)
        textFieldBox
          .padding(.top, 48)
          .padding(.horizontal, 20)
        Color.white
      }
      nextButton
        .vBottom()
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
    .eumPopup(isShowing: viewStore.binding(get: \.isShowingPopup, send: Action.dismissPopup)){
      AnyView(EumPopupView(title: "\(viewStore.receiverName)님께\n\(viewStore.amount) 햇살을 보냅니다", type: .oneLineTwoButton, firstButtonName: "취소", secondButtonName: "확인", firstButtonAction: {viewStore.send(.dismissPopup)}, secondButtonAction: {viewStore.send(.tappedSendButton)}))
    }
    .fullScreenCover(isPresented: viewStore.binding(get: \.isShowingFullsheet, send: Action.dismissFullSheet), onDismiss: nil){
    
      NavigationView {
        OTPVerificationView(placeholder: "카드 보안을 위해 비밀번호를\n입력해주세요.",  viewStore.binding(get: \.password, send: Action.updatePassword))
          .setCustomNavCloseButton()
          .setCustomNavBarTitle("")
      }
    }
    .hideKeyboardWhenTappedAround()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(.white))
    .foregroundColor(Color(.black))
    .setCustomNavBackButton()
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear {
      viewStore.send(.onDisappear)
    }
  }
}

// MARK: SubView
extension TransferInputView {
  private var commentText: some View {
    VStack(alignment: .leading, spacing: 15){
      Text("누구에게 햇살을 보낼까요?")
        .font(.titleB)
        .foregroundColor(Color(.black))
      Text("이웃과 함께 햇살을 나눠봐요")
        .font(.subR)
        .foregroundColor(Color(.systemgray07))
    }
      .hLeading()
  }
  private var textFieldBox: some View {
    VStack(spacing: 20){
      containerBox("받는 사람 닉네임") {
        EumTextField(text: viewStore.binding(get: \.receiverName, send: Action.updateReceiverName), mode: .normal)
      }
      containerBox("보낼 햇살 갯수") {
        EumTextField(text: viewStore.binding(get: \.amount, send: Action.updateAmount), mode: .number)
      }
    }
  }
  
  private var nextButton: some View {
    
    HStack {
      Button(action:{
        dismiss()
      }){
        Text("이전")
      }
      .buttonStyle(SecondaryButtonStyle())
      Button(action:{
        viewStore.send(.tappedNextButton)
      }){
        Text("다음")
      }
      .buttonStyle(PrimaryButtonStyle())
      .disabled(!viewStore.allFilledInputField)
    }
  }
  
  private func containerBox<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
    VStack(spacing: 20) {
      Text(title)
        .font(.subB)
        .hLeading()
      content()
        .hLeading()
    }
    .frame(maxHeight: .infinity)
  }
}

// MARK: Store init
extension TransferInputView {
}

struct TransferInputView_Previews: PreviewProvider {
  static var previews: some View {
    let store = Store(initialState: TransferInput.State()){
      TransferInput()
    }
    TransferInputView(store: store)
  }
}
