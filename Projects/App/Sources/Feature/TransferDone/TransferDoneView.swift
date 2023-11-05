//
//  TransferDoneView.swift
//  App
//
//  Created by JH Park on 2023/10/14.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem
import DesignSystemFoundation

struct TransferDoneView: View {
  
  typealias Core = TransferDone
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

extension TransferDoneView {
  var body: some View {
    VStack(spacing: 0){
      
      VStack(spacing: 20){
        ImageAsset.check.toImage()
          .resizable()
          .foregroundColor(Color.orange)
          .aspectRatio(1/1, contentMode: .fit)
          .frame(maxWidth: 60, maxHeight: 60)
        log
          .padding(.top, 20)
      }
      .padding(.top, 122)
      
      Spacer()
      
      doneButton
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
extension TransferDoneView {
  private var log: some View {
    Group {
      Text("\(viewStore.userName)")
        .foregroundColor(Color(.accent3))
      +
      Text("님께\n")
      +
      Text("\(viewStore.amount) 햇살")
        .foregroundColor(Color(.primary))
      + Text("을 보냈어요")
    }
    .multilineTextAlignment(.center)
  }
  
  private var doneButton: some View {
    Button(action:{print("하하")}){
      Text("확인")
    }
    .buttonStyle(PrimaryButtonStyle())
    .aspectRatio(343/60, contentMode: .fit)
    .frame(maxWidth: .infinity)
  }
}

#if(DEBUG)
struct TransferDoneView_Previews: PreviewProvider {
  static var previews: some View {
    let store = Store(initialState: TransferDone.State(userName: "박소융", amount: 1000)){
      TransferDone()
    }
    TransferDoneView(store: store)
  }
}
#endif
