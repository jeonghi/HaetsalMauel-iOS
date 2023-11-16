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
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var showingPopup: Bool
    init(state: State){
      showingPopup = state.showingPopup
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
    }
    .setCustomNavBarTitle("설정")
    .setCustomNavBackButton()
    .background(Color(.white))
    .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        //        NavigationLink(destination: EmptyView()){
        //          containerBox(leadingText: "글씨 크기", trailingText: "보통")
        //        }
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
        Button(action: {viewStore.send(.logoutButtonTapped)}){
          containerBox(leadingText: "로그아웃")
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
        NavigationLink(destination: WithdrawalReasonView(store: withdrawalReasonStore)){
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
