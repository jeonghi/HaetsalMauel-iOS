//
//  PayHomeView.swift
//  App
//
//  Created by JH Park on 2023/11/01.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem
import DesignSystemFoundation

struct PayHomeView {
  
  typealias Core = PayHome
  typealias State = Core.State
  typealias Action = Core.Action
  typealias Tab = Core.Tab
  private let store: StoreOf<Core>
  @ObservedObject var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var selectedTab: Tab
    var showingSetPasswordSheet: Bool
    var showingPopup: Bool
    init(state: State){
      selectedTab = state.selectedTab
      showingSetPasswordSheet = state.showingSetPasswordSheet
      showingPopup = state.showingPopup
    }
  }
  
  init(store: StoreOf<Core>){
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

extension PayHomeView: View {
  var body: some View {
    VStack(spacing: 0) {
      ScrollView {
        카드대시보드
          .padding(.top, 20)
          .padding(.horizontal, 16)
        
        분리
          .padding(.vertical, 20)
        
        교환내역
          .padding(.horizontal, 16)
      }
    }
    .eumPopup(isShowing: viewStore.binding(get: \.showingPopup, send: Action.dismissPopup)){
      EumPopupView(title: "설정완료", subtitle: "비밀번호가 성공적으로 설정되었습니다", type: .twoLineOneButton, firstButtonName: "확인", firstButtonAction: {viewStore.send(.dismissPopup)})
    }
    .fullScreenCover(isPresented: viewStore.binding(get: \.showingSetPasswordSheet, send: Action.dismissSetPasswordSheet)){
      NavigationView {
        IfLetStore(setPasswordStore, then: SetPasswordView.init)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .navigationBarTitle("햇살 카드", displayMode: .inline)
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear {
      
    }
  }
}

extension PayHomeView {
  
  private var 카드대시보드: some View {
    VStack(spacing: 10){
      카드
    }
  }
  
  private var 카드: some View {
    VStack(alignment: .leading){
      HStack {
        
        ImageAsset.햇살아이콘.toImage()
          .resizable()
          .renderingMode(.template)
          .scaledToFit()
          .frame(height: 29.3)
        
        HStack(alignment: .center) {
          Text("20")
            .font(.extraB)
          Text("햇살")
            .font(.titleB)
        }
      }
      .hLeading()
      
      햇살보내기_버튼
        .hTrailing()
    }
    .foregroundColor(Color.white)
    .padding(20)
    .frame(maxWidth: .infinity)
    .background(
      Color(.primary)
        .cornerRadius(10, corners: .allCorners)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 4, y: 4)
    )
  }
  
  private var 햇살보내기_버튼: some View {
    Button(action: {viewStore.send(.tappedRemittanceButton)}){
      HStack {
        Text("햇살 보내기")
          .foregroundColor(Color(.primary))
          .font(.headerR)
      }
      .padding(.horizontal, 15)
      .padding(.vertical, 10)
      .background(
        RoundedRectangle(cornerRadius: 12)
          .fill(Color(.buttonSelected))
      )
    }
  }
  
  private var 교환내역: some View {
    VStack {
      Text("교환 내역")
        .font(.titleB)
        .hLeading()
        .padding(.horizontal, 5)
      탭바
    }
  }
  
  private var 분리: some View {
    Rectangle()
      .frame(height: 10)
      .foregroundColor(Color(.divider))
      .frame(maxWidth: .infinity)
    
  }
  
  private var 탭바: some View {
    return VStack {
      SlidingTab(
        selection: viewStore.binding(
          get: \.selectedTab,
          send: Action.setTab
        ),
        tabs: Tab.allCases
      )
      switch viewStore.selectedTab {
      case .보냄:
        Text("")
      case .받음:
        Text("")
      }
    }
  }
  
  private func fitToImage(_ image: ImageAsset, _ imageHeight: CGFloat) -> some View {
    image.toImage()
      .renderingMode(.template)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(height: imageHeight)
  }
}

extension PayHomeView {
  private var setPasswordStore: Store<SetPassword.State?, SetPassword.Action> {
    return store.scope(state: \.setPasswordState, action: Action.setPasswordAction)
  }
}

struct PayHomeView_Previews: PreviewProvider {
  static var previews: some View {
    let store: StoreOf<PayHome> = Store(initialState: PayHome.State()){
      PayHome()
    }
    NavigationView {
      PayHomeView(store: store)
    }
  }
}
