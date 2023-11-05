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
    init(state: State){
      selectedTab = state.selectedTab
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
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .navigationBarTitle("햇살카드", displayMode: .inline)
    .onAppear{
      viewStore.send(.onAppear)
    }
  }
}

extension PayHomeView {
  
  private var 카드대시보드: some View {
    VStack(spacing: 10){
      카드
      카드버튼
    }
  }
  
  private var 카드: some View {
    ZStack {
      Color(.primary)
        .cornerRadius(10, corners: .allCorners)
      VStack(alignment: .leading){
        HStack {
          ImageAsset.biLogo.toImage().resizable().aspectRatio(contentMode: .fit)
            .frame(height: 60)
          Text("최소융")
            .font(.titleB)
          Spacer()
        }
        
        HStack {
          Text("20")
            .font(.largeTitleB)
          Text("햇살")
            .font(.titleB)
          Spacer()
        }
      }
      .padding(20)
    }
    .foregroundColor(Color.white)
    .frame(maxWidth: .infinity)
  }
  
  private var 카드버튼: some View {
    HStack(spacing: 10){
      Button(action: {}){
        RoundedRectangle(cornerRadius: 12)
          .aspectRatio(166/50, contentMode: .fit)
          .frame(maxWidth: .infinity)
          .foregroundColor(Color(.buttonDefaultBackground))
          .overlay(
            HStack {
              ImageAsset.햇살아이콘.toImage()
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 24)
              Text("햇살 보내기")
            }
              .foregroundColor(Color(.buttonDefaultForeground))
          )
      }
      Button(action: {}){
        RoundedRectangle(cornerRadius: 12)
          .aspectRatio(166/50, contentMode: .fit)
          .frame(maxWidth: .infinity)
          .foregroundColor(Color(.buttonOtherBackground))
          .overlay(
            Text("내역 보기")
              .foregroundColor(Color(.buttonOtherForeground))
          )
      }
    }
    .font(.headerB)
  }
  
  private var 교환내역: some View {
    VStack {
      Text("교환내역")
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
      case .진행중:
        Text("")
      case .보냄:
        Text("")
      case .받음:
        Text("")
      case .취소:
        Text("")
      }
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
