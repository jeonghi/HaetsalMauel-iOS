//
//  SettingView.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem
import DesignSystemFoundation

struct SettingView: View {
  
  typealias Core = Setting
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  struct ViewState: Equatable {
    init(state: State){
      
    }
  }
  
  init(store: StoreOf<Core>){
    self.store = store
  }
  
  var body: some View {
    // 여기에 작성
    VStack(spacing: 0){
      list
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .navigationBarTitle("설정")
    .navigationBarHidden(false)
    .navigationBarTitleDisplayMode(.inline)
  }
}

extension SettingView {
  private var list: some View {
    List {
      Section {
        NavigationLink(destination: UserProfileSettingView(store: userProfileSettingStore)){
          containerBox(leadingText: "최소융", leadingFont: .headerB, trailingText: "내 정보 수정")
        }
      }
      Section {
        NavigationLink(destination: EmptyView()){
          containerBox(leadingText: "글씨 크기", trailingText: "보통")
        }
        NavigationLink(destination: EmptyView()){
          containerBox(leadingText: "관심 게시글")
        }
      }
      .listRowSeparator(.hidden)
      Section {
        NavigationLink(destination: EmptyView()){
          containerBox(leadingText: "카드 비밀번호 변경")
        }
      }
      .listRowSeparator(.hidden)
      Section {
        NavigationLink(destination: EmptyView()){
          containerBox(leadingText: "문의하기")
        }
      }
      .listRowSeparator(.hidden)
      Section {
        containerBox(leadingText: "버전", trailingText: "최신버전")
        NavigationLink(destination: EmptyView()){
          containerBox(leadingText: "오픈소스 라이선스")
        }
      }
      .listRowSeparator(.hidden)
      
      Section {
        Button(action: {print("로그아웃")}){
          containerBox(leadingText: "로그아웃")
        }
        Button(action: {print("로그아웃")}){
          containerBox(leadingText: "탈퇴하기")
        }
      }
      .listRowSeparator(.hidden)
    }
    .listStyle(.grouped)
  }
  private func containerBox(leadingText: String, leadingFont: Font = .headerR, leadingColor: Color = Color.black, trailingText: String? = nil, trailingFont: Font = .subB, trailingColor: Color = Color(.systemgray07)) -> some View {
    HStack(spacing: 0) {
      Text("\(leadingText)")
        .font(leadingFont)
        .foregroundColor(leadingColor)
      Spacer()
      
      Text("\(trailingText ?? "")")
        .font(trailingFont)
        .foregroundColor(trailingColor)
    }
  }
}


// MARK: Store init
extension SettingView {
  private var userProfileSettingStore: StoreOf<UserProfileSetting> {
    return store.scope(state: \.userProfileSettingState, action: Action.userProfileSettingAction)
  }
}

struct SettingView_Previews: PreviewProvider {
  static var previews: some View {
    let store = Store(initialState: Setting.State()){
      Setting()
    }
    NavigationView {
      SettingView(store: store)
    }
  }
}
