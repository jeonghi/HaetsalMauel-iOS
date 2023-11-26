//
//  PostTextFormView.swift
//  App
//
//  Created by 쩡화니 on 11/21/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem
import DesignSystemFoundation

struct PostTextFormView {
  
  @Environment(\.dismiss) private var dismiss
  
  typealias Core = PostTextForm
  typealias State = Core.State
  typealias Action = Core.Action
  
  let titlePlaceholder: String = "제목을 입력하세요"
  let contentPlaceholder: String = "본문을 입력하세요"
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var title: String
    var content: String
    init(state: State) {
      title = state.title
      content = state.content
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

extension PostTextFormView: View {
  var body: some View {
    return VStack(spacing: 10) {
      TextField(titlePlaceholder , text: viewStore.binding(get: \.title, send: Action.updateTitle))
        .lineLimit(1)
        .frame(maxWidth: .infinity)
        .font(.headerB)
      TextEditor(text: viewStore.binding(get: \.content, send: Action.updateContent))
        .font(.subR)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .hLeading()
        .vTop()
    }.padding(.horizontal, 5)
  }
}

#Preview {
  let store = Store(initialState: PostTextForm.State()){
    PostTextForm()
  }
  return PostTextFormView(store: store)
}
