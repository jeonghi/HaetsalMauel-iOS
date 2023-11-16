//
//  CMDiscussionCreateView.swift
//  App
//
//  Created by 쩡화니 on 11/16/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import DesignSystemFoundation
import UISystem

struct CMDiscussionCreateView: View {

  typealias Core = CMDiscussionCreate
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    
    init(state: State) {
      
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
  
  var body: some View {
    VStack {
      Color.white.frame(height: 1)
      ScrollView {
        버튼들
          .padding(.horizontal, 16)
          .padding(.bottom, 28)
      }
    }
    .setCustomNavCloseButton()
    .setCustomNavBarTitle("새로운 의견쓰기")
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
  }
}

extension CMDiscussionCreateView {
  private var 버튼들: some View {
    HStack(spacing: 10) {
      Button(action: {}){
        Text("이전")
      }
      .buttonStyle(SecondaryButtonStyle())
      Button(action: {}){
        Text("다음")
      }
      .buttonStyle(PrimaryButtonStyle())
    }
  }
}

#Preview {
  let store = Store(initialState: CMDiscussionCreate.State()){CMDiscussionCreate()}
  return NavigationView {CMDiscussionCreateView(store: store)}
}

