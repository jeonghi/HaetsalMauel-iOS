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

struct EumChatView {
  typealias Core = EumChat
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var messages: [Message]
    init(state: State) {
      messages = state.messages
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
      
      ChatHeader(postStatus: .모집완료, postType: .도움요청, title: "제목", pointAmount: 300, meetingPlace: "활동 장소")
      
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
