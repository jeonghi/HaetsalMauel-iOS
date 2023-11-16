//
//  WithdrawalReasonView.swift
//  App
//
//  Created by 쩡화니 on 11/13/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct WithdrawalReasonView {
  
  typealias Core = WithdrawalReason
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var reasonList: [String]
    init(state: State) {
      reasonList = state.reasonList
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
    
  }
}
extension WithdrawalReasonView: View {
  var body: some View {
    VStack(alignment: .leading){
      guideComment
        .padding(.top, 30)
        .padding(.horizontal, 22)
      reasonListView
        .padding(.horizontal, 22)
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

extension WithdrawalReasonView {
  private var guideComment: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("탈퇴 이유가 궁금해요")
        .font(.titleB)
      Text("계정을 삭제하면 활동 기록, 게시글, 채팅 등 모든 기록이 삭제됩니다")
        .font(.subR)
        .multilineTextAlignment(.leading)
        .foregroundColor(Color(.systemgray07))
    }
  }
  
  private var reasonListView: some View {
    LazyVStack {
      ForEach(viewStore.reasonList, id:\.self) { reason in
        Button(action: {viewStore.send(.selectReason(reason))}){
            Text(reason)
            .font(.headerR)
            .padding(.vertical, 10)
            .hLeading()
            .foregroundColor(Color(.black))
        }
      }
    }
  }
}

#Preview {
  let store = Store(initialState: WithdrawalReason.State()){WithdrawalReason()}
  return WithdrawalReasonView(store: store)
}
