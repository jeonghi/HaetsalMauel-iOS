//
//  CMVoteCreateView.swift
//  App
//
//  Created by 쩡화니 on 11/16/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import DesignSystemFoundation
import UISystem

struct CMVoteCreateView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  typealias Core = CMVoteCreate
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var isFilledAllForm: Bool
    init(state: State) {
      isFilledAllForm = state.isFilledAllForm
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
  
  var body: some View {
    VStack {
      PostTextFormView(store: textFormStore)
        .padding(16)
        .frame(maxHeight: .infinity)
      버튼들
        .padding(.horizontal, 16)
        .padding(.bottom, 28)
      
    }
    .setCustomNavCloseButton()
    .setCustomNavBarTitle("새로운 투표만들기")
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
  }
}

extension CMVoteCreateView {
  private var 버튼들: some View {
    HStack(spacing: 10) {
      Button(action: {dismiss()}){
        Text("이전")
      }
      .buttonStyle(SecondaryButtonStyle())
      Button(action: {dismiss()}){
        Text("다음")
      }
      .buttonStyle(PrimaryButtonStyle())
      .disabled(!viewStore.isFilledAllForm)
    }
  }
}

extension CMVoteCreateView {
  private var textFormStore: StoreOf<PostTextForm> {
    return store.scope(state: \.textFormState, action: Action.textFormAction)
  }
}

#Preview {
  let store = Store(initialState: CMVoteCreate.State()){CMVoteCreate()}
  return NavigationView {CMVoteCreateView(store: store)}
}
