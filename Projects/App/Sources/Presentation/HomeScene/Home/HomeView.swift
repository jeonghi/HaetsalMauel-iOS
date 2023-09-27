//
//  HomeView.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
  
  typealias Core = Home
  typealias State = Core.State
  typealias Action = Core.Action
  typealias Route = Core.Route
  
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
    VStack(spacing: 0) {
      ScrollView(.vertical) {
        
        HStack {
          VStack(alignment: .leading, spacing: 10) {
            // 웰컴 멘트
            Text("최소융님 안녕하세요!")
            
            // 잔액
            VStack(alignment: .leading, spacing: 10) {
              // 타이틀
              Text("나의 품카드 잔액")
              // 잔액
              HStack {
                // 아이콘
                Circle()
                  .foregroundColor(Color.white)
                  .frame(width: 32, height: 32)
                // 잔액 라벨
                Text("598 폼")
                Spacer()
              }
            }
            
          }
          .foregroundColor(Color.white)
          Spacer()
        }
        .padding(.top, 60)
        .padding(.horizontal, 20)
        
        // 현재 진행중인 활동 내용
        ZStack {
          // 배경
          RoundedRectangle(cornerRadius: 12)
            .foregroundColor(Color.white)
            .aspectRatio(327/198, contentMode: .fill)
          
          // 컨텐츠
          VStack{
            Text("최근 발생한 이벤트")
          }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 8)
        .padding(.top, 20)
        
        // 우리 동네 행사
        ZStack {
          // 배경
          RoundedRectangle(cornerRadius: 12)
            .foregroundColor(Color.white)
            .aspectRatio(327/198, contentMode: .fill)
          
          // 컨텐츠
          VStack {
            Text("행사 관련 컨텐츠")
          }
          
        }
        .padding(.horizontal, 8)
        .padding(.top, 12)
        
        
      }.frame(maxWidth: .infinity)
    }
    .navigationBarItems(
      leading: HStack {
        Text("이음")
      },
      trailing: HStack {
        NavigationLink(destination: NotificationView()) {
          Image(systemName: "bell.badge.fill")
            .resizable()
            .frame(width:24, height:24)
        }
      }
    )
    .ignoresSafeArea(edges: .bottom)
    .background(Color.green)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    
    let store = Store(initialState: Home.State()){
      Home()
    }
    NavigationView {
      HomeView(store: store)
    }
  }
}
