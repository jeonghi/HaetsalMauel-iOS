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
import DesignSystemFoundation

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
    configNavBar()
  }
  
  func configNavBar() {
    
    let appearance = UINavigationBarAppearance()
    let navigationBar = UINavigationBar()
    appearance.configureWithTransparentBackground()
    navigationBar.tintColor = .white
    navigationBar.standardAppearance = appearance;
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
  }
  
  // MARK: Layout init
  var body: some View {
    
    VStack(spacing: 0){
      ScrollView {
        ZStack {
          greetingText
            .vTop()
            .hLeading()
          profileEditButton
            .vTop()
            .hTrailing()
        }
        .padding(.top, 10)
        .padding(.horizontal, 30)
        
        ZStack {
          userCharacter
          userBadge
            .vBottom()
            .hLeading()
            .padding(.leading, 10)
        }
        .hCenter()
        .padding(.top, 27)
        .padding(.horizontal, 104)
        
        levelText
          .hCenter()
          .padding(.top, 27)
        
        dashBoard
          .hCenter()
          .padding(.horizontal, 30)
          .padding(.top, 46)
      }
    }
    .background(
      LinearGradient(
        gradient: Gradient(
          colors: [
            Color(red: 0.737, green: 0.89, blue: 0.996),
            Color(red: 0.957, green: 0.961, blue: 0.965)
          ]
        ),
        startPoint: .top,
        endPoint: .bottom)
    )
    .navigationTitle("") // 네비게이션 타이틀 없음
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarItems(
      leading: HStack {
        ImageAsset.koreanLogo.toImage()
      },
      trailing: HStack {
        Button(action:{}){
          Image(systemName: "line.3.horizontal")
            .foregroundColor(Color.white)
        }
      }
    )
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
  }
}


// MARK: Component init
extension HomeView {
  // MARK: 인사말
  private var greetingText: some View {
    return Text("박정환 님 안녕하세요!")
      .font(.body)
  }
  
  // MARK: 내 정보 수정 내비게이션 버튼
  private var profileEditButton: some View {
    return Button(action:{}){
      HStack {
        Text("내 정보 수정")
        Image(systemName: "chevron.right")
      }
      .foregroundColor(Color.gray)
    }
  }
  
  // MARK: 캐릭터
  private var userCharacter: some View {
    return ImageAsset.character.toImage()
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(maxWidth: .infinity)
  }
  
  // MARK: 캐릭터 인증 뱃지
  private var userBadge: some View {
    return ImageAsset.userBadge.toImage()
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(maxWidth: 40)
  }
  
  // MARK: 레벨표시
  private var levelText: some View {
    return Text("Lv 7. 아기 햇님")
      .font(.headline)
  }
  
  // MARK: 햇살 대시보드
  private var dashBoard: some View {
    DashBoard()
      .background(
        RoundedRectangle(cornerRadius: 12)
          .foregroundColor(Color.white)
      )
  }
  
  // MARK: 카드 탭
  private var cardTap: some View {
    VStack {
      
    }
  }
}


// MARK: Store init
extension HomeView {
  private var notificationStore: StoreOf<Notification> {
    return store.scope(state: \.notificationState, action: Action.notificationAction)
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
