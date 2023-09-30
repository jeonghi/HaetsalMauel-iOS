//
//  HomeView.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem

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
    ScrollView {
      scrollContentView
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
    .background(Color.black.opacity(0.1))
    .ignoresSafeArea(edges: [.bottom])
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onAppear{
      
    }
    .onDisappear{
      
    }
  }
}


extension HomeView {
  private var homeProfileView: some View {
    HStack {
      Circle()
        .foregroundColor(Color.white)
        .frame(width: 45, height: 45)
      VStack(alignment: .leading) {
        Text("아기 햇님")
        Text("최소융")
      }
    }
  }
  
  private var scrollContentView: some View {
    
    return VStack {
      // MARK: 내 프로필
      UserProfile()
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .padding(.horizontal, 10)
        .padding(.vertical, 20)
        .background(
          Rectangle()
            .foregroundColor(Color(.primary))
            .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
        )
      
      
      // MARK: 햇살 대시보드
      ZStack {
        RoundedRectangle(cornerRadius: 12)
          .foregroundColor(Color.white)
        DashBoard()
          .padding()
      }.padding(.horizontal, 10)
      
      // TODO: 프로모션 배너 화면
      PromotionBanner()
        .cornerRadius(10, corners: .allCorners)
        .frame(height: 92)
        .padding(.horizontal, 10)
      
      // TODO: 동네 정보 화면
      ScrollView(.horizontal, showsIndicators: false){
        HStack {
          ForEach(1...3, id: \.self){ _ in
            Rectangle()
              .frame(width: 160, height: 160)
              .foregroundColor(Color.white)
              .cornerRadius(10, corners: .allCorners)
          }
        }
      }
      .padding(.leading, 10)
    }
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
