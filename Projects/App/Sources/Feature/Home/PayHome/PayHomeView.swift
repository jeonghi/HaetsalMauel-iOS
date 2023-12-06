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
    var selectedTab: Tab?
    var showingSetPasswordSheet: Bool
    var showingPopup: Bool
    var payCardName: String
    var payBalance: Int64
    var transactionList: [TransactionEntity.History]
    var isLoadingTransaction: Bool
    var isLoadingPage: Bool
    init(state: State){
      selectedTab = state.selectedTab
      showingSetPasswordSheet = state.showingSetPasswordSheet
      showingPopup = state.showingPopup
      payCardName = state.payCardName
      payBalance = state.payBalance
      transactionList = state.transactionList
      isLoadingTransaction = state.isLoadingTransaction
      isLoadingPage = state.isLoadingPage
    }
  }
  
  init(store: StoreOf<Core>){
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

extension PayHomeView: View {
  var body: some View {
    ZStack {
      VStack(spacing: 0) {
        ScrollView {
          카드대시보드
            .padding(.top, 20)
            .padding(.horizontal, 16)
          
          분리
            .padding(.vertical, 20)
          
          교환내역탭
            .padding(.horizontal, 16)
          
          ZStack {
            VStack(spacing: 0) {
              if(!viewStore.transactionList.isEmpty){
                거래내역결과
              }else {
                거래내역없음
              }
            }
            if(viewStore.isLoadingTransaction){
              Color.white
              ProgressView()
                .padding(.vertical, 70)
            }
          }
        }
        .refreshable{
          viewStore.send(.onAppear)
        }
      }
      if(viewStore.isLoadingPage){
        Color.white
        ProgressView()
      }
    }
    .eumPopup(isShowing: viewStore.binding(get: \.showingPopup, send: Action.dismissPopup)){
      AnyView(
        EumPopupView(title: "설정완료", subtitle: "비밀번호가 성공적으로 설정되었습니다", type: .twoLineOneButton, firstButtonName: "확인", firstButtonAction: {viewStore.send(.dismissPopup)})
      )
    }
    .fullScreenCover(isPresented: viewStore.binding(get: \.showingSetPasswordSheet, send: Action.dismissSetPasswordSheet)){
      NavigationView {
        IfLetStore(setPasswordStore, then: SetPasswordView.init)
      }
    }
    .setCustomNavBarTitle("햇살 카드")
    .setCustomNavBackButton()
    .background(Color(.white))
    .foregroundColor(Color(.black))
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear {
      viewStore.send(.onDisappear)
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
      
      카드별명
      
      HStack {
        
        ImageAsset.햇살아이콘.toImage()
          .resizable()
          .renderingMode(.template)
          .scaledToFit()
          .frame(height: 29.3)
        
        HStack(alignment: .center) {
          Text("\(viewStore.payBalance)")
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
    NavigationLink(destination: TransferInputView(store: transferInputStore)){
      HStack {
        Text("햇살 보내기")
          .foregroundColor(Color(.primary))
          .font(.subB)
      }
      .padding(.horizontal, 15)
      .padding(.vertical, 10)
      .background(
        RoundedRectangle(cornerRadius: 12)
          .fill(Color(.buttonSelected))
      )
    }
  }
  
  private var 카드별명: some View {
    ZStack {
      TextField(text: viewStore.binding(get: \.payCardName, send: Action.updatePayCardName), prompt: nil){
        Text("카드 별명을 설정해보세요")
          .font(.headerR)
          .foregroundColor(Color(.white))
      }
    }
    .frame(maxWidth: .infinity)
    .padding(10)
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(Color(.black).opacity(0.3))
    )
  }
  
  private var 교환내역탭: some View {
    VStack(spacing: 0) {
      Text("교환 내역")
        .font(.titleB)
        .hLeading()
        .padding(.horizontal, 5)
      탭바
        .padding(.vertical, 16)
    }
  }
  
  private var 분리: some View {
    Rectangle()
      .frame(height: 10)
      .foregroundColor(Color(.divider))
      .frame(maxWidth: .infinity)
    
  }
  
  private var 탭바: some View {
    return ScrollingTab(selection: viewStore.binding(get: \.selectedTab, send: Action.selectTab), tabs: Tab.allCases, horizontalPadding: 10, verticalPaddingg: 6)
  }
  
  
  private var 거래내역결과: some View {
    ScrollView {
      LazyVStack(spacing: 0) {
        ForEach(viewStore.transactionList, id:\.self){
          PayTransactionListCell(transaction: $0)
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(Color(.white))
        }
      }
    }
  }
  
  private var 거래내역없음: some View {
    Text("아직 햇살 교환 내역이 없어요.\n햇터를 통해 이웃과 햇살을 교환해보세요.")
      .font(.subR)
      .foregroundColor(Color(.systemgray06))
      .multilineTextAlignment(.center)
      .vCenter()
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
  
  private var transferInputStore: StoreOf<TransferInput> {
    return Store(initialState: TransferInput.State()){
      TransferInput()
    }
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
