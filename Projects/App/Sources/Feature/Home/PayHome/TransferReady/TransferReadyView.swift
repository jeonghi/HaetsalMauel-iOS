//
//  TransferReadyView.swift
//  App
//
//  Created by JH Park on 2023/10/14.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem

struct TransferReadyView: View {
  
  typealias Core = TransferReady
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    
    var userName: String
    var amount: Int
    
    init(state: State) {
      userName = state.userName
      amount = state.amount
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}



extension TransferReadyView {
  var body: some View {
    VStack(spacing: 0){
      log
        .vCenter()
        .padding(.horizontal, 20)
      
      nextButton
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

extension TransferReadyView {
  
  private var log: some View {
    Group {
      Text("\(viewStore.userName)")
        .foregroundColor(Color(.accent3))
        .bold()
      +
      Text("님께\n")
      +
      Text("\(viewStore.amount) 햇살")
        .foregroundColor(Color(.primary))
        .bold()
      + Text("을 보낼까요?")
    }
    .multilineTextAlignment(.center)
    .aspectRatio(contentMode: .fit)
    .frame(maxWidth: .infinity)
  }
  
  private var nextButton: some View {
    Button(action: {}){
      Text("다음")
    }
    .buttonStyle(PrimaryButtonStyle())
    .aspectRatio(343/60, contentMode: .fit)
    .frame(maxWidth: .infinity)
  }
}

struct TransferReadyView_Previews: PreviewProvider {
  static var previews: some View {
    let store = Store(initialState: TransferReady.State(userName: "박소융", amount: 10)){
      TransferReady()
    }
    TransferReadyView(store: store)
  }
}
