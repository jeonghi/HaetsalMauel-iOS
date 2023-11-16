//
//  EumChatView.swift
//  App
//
//  Created by 쩡화니 on 11/11/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import SwiftUI
import ExyteChat
import ComposableArchitecture
import UISystem
import DesignSystemFoundation

struct EumChatView {
  
  @Environment(\.dismiss) private var dismiss
  
  typealias Core = EumChat
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var messages: [Message]
    var userName: String
    var showingActionSheet: Bool
    var showingPopup: Bool
    init(state: State) {
      messages = state.messages
      userName = state.userName
      showingActionSheet = state.showingActionSheet
      showingPopup = state.showingPopup
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

extension EumChatView: View {
  var body: some View {
    VStack(spacing: 0) {
      
      ChatHeader(postStatus: .모집완료, postType: .도움요청, title: "더미데이터더미데이터데이터더미데이터더미데이터더미데이터데이터더미데이터", pointAmount: 300, meetingPlace: "활동 장소")
        .background(
          Rectangle()
            .fill(Color(.white))
        )
        .overlay(
          Rectangle()
            .frame(height: 1)
            .foregroundColor(Color(.systemgray03)),
          alignment: .bottom
        )
      
      Rectangle()
        .foregroundColor(Color.gray.opacity(0.09))
        .frame(height: 7)
      
      ChatView(messages: viewStore.messages){ _ in
      }
      .enableLoadMore(offset: 3){ message in
        
      }
      .messageUseMarkdown(messageUseMarkdown: true)
      //    .chatNavigation(
      //      title: "안녕",
      //      status: "",
      //      cover: URL(string: "https://kr.object.ncloudstorage.com/k-eum/characterAsset/sun_middle%402x.png")
      //    )
      .mediaPickerTheme(
      )
    }
    .setCustomNavBackButton()
    .setCustomNavBarTitle("\(viewStore.userName)")
    .eumPopup(
      isShowing: viewStore.binding(get: \.showingPopup, send: Action.dismissPopup)
    ){
      EumPopupView(
        title: "채팅방에서 나가겠습니까?",
        subtitle: "채팅방을 나가면 채팅 목록 및 대화 내용이 삭제되고 복구할 수 없어요.",
        type: .twoLineTwoButton,
        firstButtonName: "네, 나갈래요",
        secondButtonName: "취소",
        firstButtonAction: {
          viewStore.send(.dismissPopup)
          dismiss()
        },
        secondButtonAction: {
          viewStore.send(.dismissPopup)
        }
      )
    }
    .eumActionSheet(
      isShowing: viewStore.binding(get: \.showingActionSheet, send: Action.showingActionSheet),
      buttons: [
        .init(title: "신고하기", action: {
          viewStore.send(.tappedActionSheet(.신고하기))
          viewStore.send(.dismissActionSheet)
        }),
        .init(title: "채팅방 나가기", action: {
          viewStore.send(.tappedActionSheet(.채팅방나가기))
          viewStore.send(.dismissActionSheet)
          viewStore.send(.showingPopup(true))
        })
      ]
    )
    .toolbar {
      ToolbarItemGroup(placement: .navigationBarTrailing){
        Button(action: {viewStore.send(.showingActionSheet(true))}){
          ImageAsset.기타_큰.toImage()
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 24)
        }
      }
    }
  }
}

#Preview {
  let store = Store(initialState: EumChat.State()){
    EumChat()
  }
  return NavigationView {
    EumChatView(store: store)
  }
}
