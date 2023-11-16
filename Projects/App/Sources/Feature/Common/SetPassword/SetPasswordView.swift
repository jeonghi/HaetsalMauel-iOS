//
//  SetPasswordView.swift
//  App
//
//  Created by 쩡화니 on 11/14/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem
import DesignSystemFoundation

struct SetPasswordView {
  
  @Environment(\.dismiss) private var dismiss
  
  typealias Core = SetPassword
  typealias State = Core.State
  typealias Action = Core.Action
  typealias Step = Core.Step
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var currStep: Step
    var initialPassword: String
    var oneMorePassword: String
    init(state: State) {
      currStep = state.currStep
      initialPassword = state.initalPassword
      oneMorePassword = state.oneMorePassword
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

extension SetPasswordView: View {
  
  var body: some View {
    VStack {
      switch viewStore.currStep {
      case .initial:
        OTPVerificationView(
          placeholder: "카드 보안을 위해 비밀번호를 설정해주세요.",
          viewStore.binding(get: \.initialPassword, send: Action.updateInitialPassword)
        )
      case .oneMore:
        OTPVerificationView(
          placeholder: "입력하신 비밀번호를 한번 더 입력해주세요.",
          viewStore.binding(get: \.oneMorePassword, send: Action.updateOneMorePassword)
        )
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .navigationBarBackButtonHidden()
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .topBarLeading){
        HStack {
          Button(action: {dismiss()}){
            ImageAsset.닫기.toImage()
              .renderingMode(.template)
              .resizable()
              .foregroundColor(Color(.black))
              .aspectRatio(contentMode: .fit)
              .frame(height: 24)
          }
        }
      }
      ToolbarItem(placement: .principal){
        Text("비밀번호 설정")
          .foregroundColor(Color(.black))
          .font(.headerB)
      }
    }
  }
}

#Preview {
  let store = Store(initialState: SetPassword.State()){
    SetPassword()
  }
  return SetPasswordView(store: store)
}
