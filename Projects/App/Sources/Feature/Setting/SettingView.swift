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
import Foundation

struct SettingView: View {
  
  typealias Core = Setting
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var showingPopup: Bool
    var userName: String
    init(state: State){
      showingPopup = state.showingPopup
      userName = state.nickName
    }
  }
  
  init(store: StoreOf<Core>){
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
  
  var body: some View {
    // 여기에 작성
    VStack(spacing: 0){
      list
    }
    .eumPopup(isShowing: viewStore.binding(get: \.showingPopup, send: Action.showingPopup)){
      AnyView (
        EumPopupView.init(
          title: "로그아웃 하시겠습니까?",
          type: .twoLineTwoButton,
          firstButtonName: "로그아웃",
          secondButtonName: "취소",
          firstButtonAction: {
            viewStore.send(.showingPopup(false))
            viewStore.send(.logout)
          },
          secondButtonAction: {
            viewStore.send(.showingPopup(false))
          }
        )
      )
    }
    .setCustomNavBarTitle("설정")
    .setCustomNavBackButton()
    .background(Color(.white))
    .foregroundColor(Color(.black))
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onAppear{
      
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
  }
}

extension SettingView {
  private var list: some View {
    List {
      Section() {
        NavigationLink(destination: UserProfileSettingView(store: userProfileSettingStore)){
          containerBox(leadingText: "\(viewStore.userName)", leadingFont: .headerB, trailingText: "내 정보 수정")
        }
      }
      Section(header: Text("게시글 관리")) {
        NavigationLink(destination: MPScrapPostListView(store: .init(initialState: MPScrapPostList.State()){MPScrapPostList()})){
          containerBox(leadingText: "관심 게시글")
        }
        NavigationLink(destination: MyPostListView(store: .init(initialState: MyPostList.State()){MyPostList()})){
          containerBox(leadingText: "내가 쓴 게시글")
        }
      }
      .listRowSeparator(.hidden)
      Section(header: Text("햇살 관리")) {
        NavigationLink(destination: EmptyView()){
          containerBox(leadingText: "카드 비밀번호 변경")
        }
      }
      .listRowSeparator(.hidden)
      Section(header: Text("서비스 이용")) {
        
        NavigationLink(destination: 문의하기){
          containerBox(leadingText: "문의하기")
        }
        
        NavigationLink(destination: 이용약관){
          containerBox(leadingText: "이용약관")
        }
        
        NavigationLink(destination: 개인정보처리방침){
          containerBox(leadingText: "개인정보처리방침")
        }
        Button(action: {viewStore.send(.logoutButtonTapped)}){
          containerBox(leadingText: "로그아웃")
        }
      }
      .listRowSeparator(.hidden)
      Section(header: Text("소프트웨어 정보")) {
        containerBox(leadingText: "버전", trailingText: "최신버전")
      }
      .listRowSeparator(.hidden)
      
      Section {
        NavigationLink(destination: WithdrawalReasonView(store: withdrawalReasonStore)){
          containerBox(leadingText: "탈퇴하기")
        }
      }
      .listRowSeparator(.hidden)
      
    }
    .environment(\.defaultMinListHeaderHeight, 0)
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

extension SettingView {
  private var 문의하기: some View {
    ZStack {
      Color.white
      WebView(url: "https://achieved-crawdad-960.notion.site/63f6effbdefd4a82a2a70be9c577c642?pvs=4".toURL())
    }
  }
  
  private var 이용약관: some View {
    ZStack {
      Color.white
      WebView(url: "https://achieved-crawdad-960.notion.site/191b1734f32840258d7c113fc6b53858?pvs=4".toURL())
    }
  }
  
  private var 개인정보처리방침: some View {
    ZStack {
      Color.white
      WebView(url: "https://achieved-crawdad-960.notion.site/2cbd879e8f0147139b3f9ee7a5b6b9dd?pvs=4".toURL())
    }
  }
}


// MARK: Store init
extension SettingView {
  private var userProfileSettingStore: StoreOf<UserProfileSetting> {
    return store.scope(state: \.userProfileSettingState, action: Action.userProfileSettingAction)
  }
  private var withdrawalReasonStore: StoreOf<WithdrawalReason> {
    return store.scope(state: \.withdrawalReasonState, action: Action.withdrawalReasonAction)
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
