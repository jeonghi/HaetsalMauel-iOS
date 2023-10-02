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

struct UserProfileSettingView: View {
  
  typealias Core = UserProfileSetting
  typealias State = Core.State
  typealias Action = Core.Action
  typealias Route = Core.Route
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var nickName: String
    var comment: String
    init(state: State) {
      nickName = state.nickName
      comment = state.comment
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
  
  var body: some View {
    VStack {
      ScrollView {
        scrollContentView
      }.padding(.top, 30)
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
    
    return VStack(alignment: .leading, spacing: 30){
      
      // TODO: 닉네임
      
      Text("닉네임")
      CountedTextField(
        text: viewStore.binding(
          get: \.nickName,
          send: Action.setNickName
        ),
        placeHolder: "닉네임을 입력해주세요",
        maxLength: 255
      )
      
      // TODO: 한마디
      
      Text("한마디")
      CountedTextField(
        text: viewStore.binding(
          get: \.comment,
          send: Action.setComment
        ),
        placeHolder: "한마디를 입력해주세요",
        maxLength: 255
      )
      
      // TODO: 캐릭터

      Text("캐릭터")

      Button(action: {}){
        RoundedRectangle(cornerRadius: 16)
          .foregroundColor(Color.gray)
          .frame(width: 106, height: 115)
      }
      
      // TODO: 지역
      Text("지역")
      HStack {
        Button(action: {}){
          RoundedRectangle(cornerRadius: 16)
            .foregroundColor(Color.gray)
            .frame(width: 100, height: 45)
        }
        Button(action: {}){
          RoundedRectangle(cornerRadius: 16)
            .foregroundColor(Color.gray)
            .frame(width: 100, height: 45)
        }
      }
      
      Spacer()
      
      
      // TODO: 버튼
      Button(action: {}){
        RoundedRectangle(cornerRadius: 16)
          .foregroundColor(Color(.primary))
          .frame(height: 50)
          .overlay {
            Text("수정완료")
              .foregroundColor(Color.white)
          }
      }
      
    }.padding(.horizontal, 20)
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
