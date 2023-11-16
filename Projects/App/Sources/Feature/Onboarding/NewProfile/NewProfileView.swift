//
//  NewProfileView.swift
//  App
//
//  Created by 쩡화니 on 11/13/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem

struct NewProfileView {
  typealias Core = NewProfile
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  @ObservedObject var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var nickName: String
    var isAllInfoFilled: Bool
    init(state: State){
      nickName = state.nickName
      isAllInfoFilled = state.isAllInfoFilled
    }
  }
  
  init(store: StoreOf<Core>){
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

extension NewProfileView: View {
  var body: some View {
    VStack(spacing: 0){
      ScrollView {
        VStack(spacing: 30) {
          닉네임_텍스트필드
          캐릭터_선택_버튼
          지역_선택_버튼
        }
          .padding(.top, 30)
        nextButton
          .padding(.top, 30)
          .padding(.bottom, 20)
      }
      .padding(.horizontal, 20)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

extension NewProfileView {
  private var 닉네임_텍스트필드: some View {
    let tf = EumTextField(
      text: viewStore.binding(get: \.nickName, send: Action.updateNickName),
      mode: .normal)
    return containerBox("닉네임"){
      tf
    }
  }
  
  private var 캐릭터_선택_버튼: some View {
    let btn = VStack {
      
    }
    return containerBox("캐릭터"){
      btn
    }
  }
  
  private var 지역_선택_버튼: some View {
    let btn = VStack {
      
    }
    return containerBox("지역"){
      btn
    }
  }
  
  private var nextButton: some View {
    Button(action: {viewStore.send(.tappedNextButton)}){
      Text("다음")
    }
    .disabled(!viewStore.isAllInfoFilled)
    .buttonStyle(PrimaryButtonStyle())
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

#Preview {
  let store = Store(initialState: NewProfile.State()){NewProfile()}
  return NewProfileView(store: store)
}
