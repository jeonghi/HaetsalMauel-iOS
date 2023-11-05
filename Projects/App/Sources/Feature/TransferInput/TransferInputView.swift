//
//  TransferInputView.swift
//  App
//
//  Created by JH Park on 2023/10/14.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem

struct TransferInputView: View {
  
  typealias Core = TransferInput
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var accountNumber: String
    var amount: String
    
    init(state: State) {
      accountNumber = state.accountNumber
      amount = state.amount
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

// MARK: View
extension TransferInputView {
  var body: some View {
    VStack(spacing: 0){
      commentText
        .padding(.top, 30)
        .padding(.horizontal, 20)
      textFieldBox
        .padding(.top, 48)
        .padding(.horizontal, 20)
      nextButton
        .vBottom()
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

// MARK: SubView
extension TransferInputView {
  private var commentText: some View {
    Text("이웃에게 햇살을 보내요")
      .hLeading()
  }
  private var textFieldBox: some View {
    VStack(spacing: 0){
      
    }
  }
  private var nextButton: some View {
    Button(action:{}){
      Text("다음")
    }
    .buttonStyle(PrimaryButtonStyle())
    .aspectRatio(343/60, contentMode: .fit)
    .frame(maxWidth: .infinity)
  }
}

struct TransferInputView_Previews: PreviewProvider {
  static var previews: some View {
    let store = Store(initialState: TransferInput.State()){
      TransferInput()
    }
    TransferInputView(store: store)
  }
}
