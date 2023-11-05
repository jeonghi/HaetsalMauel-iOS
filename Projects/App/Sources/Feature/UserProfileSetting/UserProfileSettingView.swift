//
//  UserProfileSettingView.swift
//  App
//
//  Created by JH Park on 2023/09/30.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem
import PopupView

struct UserProfileSettingView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  typealias Core = UserProfileSetting
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var nickName: String
    var comment: String
    var showingCharacterPopup: Bool
    init(state: State) {
      nickName = state.nickName
      comment = state.comment
      showingCharacterPopup = state.showingCharacterPopup
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
  
  var body: some View {
    ScrollView {
      scrollContentView
        .padding(.top, 30)
        .padding(.horizontal, 20)
      editDoneButton
        .padding(.top, 45)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
    .popup(
      isPresented: viewStore.binding(
        get: \.showingCharacterPopup,
        send: Action.showingCharacterPopup
    )){
      ZStack {
        Color.white
      }
    } customize: {
        $0
          .isOpaque(true)
          .position(.bottom)
          .animation(.easeInOut)
          .closeOnTapOutside(true)
          .backgroundColor(.black.opacity(0.5))
    }
    .navigationBarTitle("내 정보 수정", displayMode: .inline)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
  }
}


extension UserProfileSettingView {
  
  private var scrollContentView: some View {
    
    return VStack(alignment: .leading, spacing: 15){
      
      containerBox("닉네임"){
        CountedTextField(
          text: viewStore.binding(
            get: \.nickName,
            send: Action.setNickName
          ),
          placeHolder: "닉네임을 입력해주세요",
          maxLength: 255
        )
      }
      
      containerBox("한마디"){
        CountedTextField(
          text: viewStore.binding(
            get: \.comment,
            send: Action.setComment
          ),
          placeHolder: "한마디를 입력해주세요",
          maxLength: 255
        )
      }
      
      containerBox("캐릭터"){
        Button(action: {}){
          RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color(.grayF7))
            .frame(width: 106, height: 115)
        }
      }
      
      containerBox("지역"){
        HStack {
          Button(action: {}){
            RoundedRectangle(cornerRadius: 10)
              .foregroundColor(Color(.grayF7))
              .frame(width: 100, height: 45)
          }
          Button(action: {}){
            RoundedRectangle(cornerRadius: 10)
              .foregroundColor(Color(.grayF7))
              .frame(width: 100, height: 45)
          }
        }
      }
    }
  }
  
  private var editDoneButton: some View {
    Button(action: {viewStore.send(.editDoneButtonTapped)
      dismiss()
    }){
      Text("수정 완료")
    }
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

struct UserProfileSettingView_Previews: PreviewProvider {
  static var previews: some View {
    
    let store = Store(initialState: UserProfileSetting.State()){
      UserProfileSetting()
    }
    NavigationView {
      UserProfileSettingView(store: store)
    }
  }
}
