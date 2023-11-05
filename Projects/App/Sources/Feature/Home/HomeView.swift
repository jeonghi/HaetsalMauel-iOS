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
import PopupView

struct HomeView: View {
  
  typealias Core = Home
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var showingPopup: Bool
    init(state: State) {
      showingPopup = state.showingPopup
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
  
  // MARK: Layout init
  var body: some View {
    
    VStack(spacing: 0){
      ScrollView {
        프로필
          .padding(.vertical, 20)
        햇살카드대시보드
          .padding(.horizontal, 10)
        햇살지수대시보드
          .padding(.top, 10)
          .padding(.horizontal, 10)
      }
    }
    .background(
      LinearGradient(
        gradient: Gradient(
          colors: [
            Color(.deepSkyBlue),
            Color(.lightSkyBlue),
            Color(.white)
          ]
        ),
        startPoint: .top,
        endPoint: .bottom)
    )
    .navigationTitle("") // 네비게이션 타이틀 없음
    .navigationBarHidden(false)
    .navigationBarTitleDisplayMode(.inline)
    
    .popup(isPresented: viewStore.binding(get: \.showingPopup, send: Action.showingPopup)){
      ZStack {
        Color(.white)
          .cornerRadius(12, corners: .allCorners)
        
        VStack(spacing: 20) {
          RoundedRectangle(cornerRadius: 6)
            .frame(width: 67, height: 5)
            .foregroundColor(Color(.gray06))
          LevelGuildView()
        }
        .padding(22)
      }
      .padding(.horizontal, 8)
      .padding(.vertical, 30)
    } customize: {
      $0
        .isOpaque(true)
        .position(.center)
        .animation(.easeInOut)
        .closeOnTapOutside(true)
        .backgroundColor(.black.opacity(0.5))
    }
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
  
  private var 프로필: some View {
    return VStack(spacing: 30) {
      Text("햇살주민 님 안녕하세요!")
        .foregroundColor(Color.black)
        .font(.titleB)
        .padding(20)
        .background(
          ZStack {
            Color.white
              .cornerRadius(16, corners: .allCorners)
          }
        )
      ImageAsset.character.toImage()
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(height: 225)
    }
  }
  
  private var 햇살카드대시보드: some View {
    containerBox(
      HStack() {
        ImageAsset.biLogo.toImage()
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(height: 60)
        VStack(alignment: .leading, spacing: 5){
          Text("지금 바로 보낼 수 있어요")
            .font(.descriptionB)
            .foregroundColor(Color(.gray07))
          Text("20 햇살")
            .font(.largeTitleB)
        }
        Spacer()
        NavigationLink(destination: PayHomeView(store: payHomeStore)){
          RoundedRectangle(cornerRadius: 12)
            .frame(width: 80, height: 32)
            .foregroundColor(Color(.primary))
            .overlay(
              Text("햇살카드")
                .font(.subR)
                .foregroundColor(Color.white)
            )
        }
      }
    )
  }
  
  private var 햇살지수대시보드: some View {
    containerBox(
      HStack() {
        VStack(alignment: .leading, spacing: 10){
          HStack {
            Text("나의 햇살 지수는?")
            Spacer()
            Button(action: {viewStore.send(.showingPopup(true))}){
              HStack {
                Text("아기 햇님")
                ImageAsset.questionmarkCircleFill
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(height: 18)
              }
            }
          }
          .foregroundColor(Color.black)
          .font(.headerB)
          progressBar(20/100)
            .frame(height: 10)
          HStack {
            Circle()
              .foregroundColor(Color(.primary))
              .frame(width: 12, height: 12)
            Text("다음 성장까지")
              .font(.subR)
            Text("20/100")
              .font(.subB)
          }
          .foregroundColor(Color(.gray07))
        }
      }
    )
  }
  
  private func progressBar(_ value: Float) -> some View {
    
    GeometryReader { geometry in
      ZStack(alignment: .leading) {
        Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
          .opacity(0.3)
          .foregroundColor(Color(.gray07))
        
        Rectangle().frame(width: min(CGFloat(value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
          .foregroundColor(Color(.primary))
      }.cornerRadius(45.0)
    }
  }
  
  @ViewBuilder private func containerBox(_ content: some View) -> some View {
    ZStack {
      Color.white
        .cornerRadius(20, corners: .allCorners)
      content
        .padding(.vertical, 20)
        .padding(.horizontal, 22)
    }
    .frame(maxHeight: .infinity)
  }
}


// MARK: Store init
extension HomeView {
  private var settingStore: StoreOf<Setting> {
    return store.scope(state: \.settingState, action: Action.settingAction)
  }
  private var payHomeStore: StoreOf<PayHome> {
    return store.scope(state: \.payHomeState, action: Action.payHomeAction)
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
