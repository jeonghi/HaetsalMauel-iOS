//
//  SignUpView.swift
//  App
//
//  Created by JH Park on 2023/10/30.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem

struct SignInView {
  
  typealias Core = SignIn
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  @ObservedObject var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var isTextFieldAllFilled: Bool
    var id: String
    var password: String

    var isShowingSheet: Bool
    var showPassword: Bool
    init(state: State){
      isTextFieldAllFilled = state.isTextFieldAllFilled
      id = state.id
      password = state.password
      isShowingSheet = state.isShowingSheet
      showPassword = state.showPassword
    }
  }
  
  init(store: StoreOf<Core>){
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

extension SignInView: View {
  var body: some View {
    return VStack(spacing: 0) {
      Color.white.frame(height: 1)
      ScrollView {
        VStack(spacing: 48) {
          guideComment
            .hLeading()
            .padding(.horizontal, 16)
            .padding(.top, 30)
          
          textFieldVStack
            .padding(.horizontal, 22)
        }
      }
      .frame(maxHeight: .infinity)
      
      VStack(spacing: 18) {
        signUpGuide
        nextButton
      }
      .padding(.horizontal, 16)
      .padding(.bottom, 20)
    }
    .sheet(isPresented: viewStore.binding(get: \.isShowingSheet, send: Action.isShowingSheet)){
      WebView(url: "https://eumweb.netlify.app/", viewModel: .init())
    }
    .hideKeyboardWhenTappedAround()
    .navigationBarTitle("")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarHidden(false)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .setCustomNavBackButton()
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
  }
}

extension SignInView {
  
  private var guideComment: some View {
    Text("로그인 정보를 입력해주세요.")
      .hLeading()
      .font(.titleB)
  }
  
  private var textFieldVStack: some View {
    VStack(spacing: 20){
      
      containerBox("아이디"){
        idField
      }
      
      containerBox("비밀번호"){
        passwordField
      }
    }
  }
  
  private var idField: some View {
      EumTextField(
          text: viewStore.binding(
              get: \.id,
              send: Action.updateId
          ),
          mode: .email,
          placeholder: "아이디를 입력해주세요"
      )
  }

  private var passwordField: some View {
      EumTextField(
          text: viewStore.binding(
              get: \.password,
              send: Action.updatePassword
          ),
          mode: .password,
          isSecure: !viewStore.showPassword,
          showPasswordAction: {
              viewStore.send(.tappedShowPassword)
          },
          placeholder: "비밀번호를 입력해주세요"
      )
  }
  
  private var signUpGuide: some View {
    HStack(spacing: 5) {
      Text("아직 계정이 없으신가요?")
        .font(.subR)
        .foregroundColor(Color(.systemgray07))
      Button(action: {viewStore.send(.isShowingSheet(true))}) {
        Text("기관 가입안내")
          .font(.subR)
          .underline()
          .multilineTextAlignment(.center)
          .foregroundColor(Color(.primary))
      }
    }
  }
  
  private var nextButton: some View {
      Button(action: {viewStore.send(.tappedLoginButton)}){
        Text("확인")
      }
      .buttonStyle(PrimaryButtonStyle())
      .disabled(!viewStore.isTextFieldAllFilled)
  }
  
  private func containerBox<Content: View>(_ title: String, @ViewBuilder _ content: () -> Content) -> some View {
    VStack(alignment: .leading, spacing: 10){
      Text(title)
        .font(.subB)
      content()
        .font(.subR)
    }
  }
}

#Preview {
  VStack(spacing: 0){
    NavigationView {
      let store = Store(initialState: SignIn.State()){
        SignIn()
      }
      SignInView(store: store)
    }
  }
}
