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

struct UPCreateView {
  typealias Core = UPCreate
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

extension UPCreateView: View {
  var body: some View {
    
    ScrollView(showsIndicators: false) {
      VStack(spacing: 0){
        Text("프로필을 작성해주세요")
          .font(.titleB)
          .hLeading()
          .foregroundColor(Color(.black))
          .padding(.top, 30)
          .padding(.bottom, 48)
        
        VStack(spacing: 30) {
          닉네임_텍스트필드
          지역_선택_버튼
          캐릭터_선택_버튼
        }
        nextButton
          .padding(.top, 30)
          .padding(.bottom, 20)
      }
      .padding(.horizontal, 20)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .setCustomNavBackButton()
    .setCustomNavBarTitle("")
  }
}

extension UPCreateView {
  private var 닉네임_텍스트필드: some View {
    let tf = EumTextField(
      text: viewStore.binding(get: \.nickName, send: Action.updateNickName),
      mode: .normal)
    return containerBox("닉네임"){
      tf
    }
  }
  
  private var 캐릭터_선택_버튼: some View {
    
    return containerBox("캐릭터"){
      CCSelectionView(store: CCSelectionStore)
    }
  }
  
  private var 지역_선택_버튼: some View {
    let btn = VStack {
      
    }
    return containerBox("마을"){
      btn
    }
  }
  
  private var nextButton: some View {
    Button(action: {viewStore.send(.tappedNextButton)}){
      Text("프로필 생성하기")
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

extension UPCreateView {
  private var CCSelectionStore: StoreOf<CCSelection> {
    return store.scope(state: \.CCSelectionState, action: Action.CCSelectionAction)
  }
}

#Preview {
  let store = Store(initialState: UPCreate.State()){UPCreate()}
  return NavigationView {UPCreateView(store: store)}
}
