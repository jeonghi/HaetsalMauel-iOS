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
import Kingfisher

struct HomeView: View {
  
  typealias Core = Home
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    
    /// 화면 데이터
    var address: String
    var characterUrl: URL?
    var balance: Int64
    var characterName: String
    var levelName: String
    var nickName: String
    
    /// 로딩
    var isLoading: Bool
    
    /// 팝업
    var showingPopup: Bool
    
    init(state: State) {
      address = state.address
      characterUrl = state.characterUrl
      balance = state.balance
      characterName = state.characterName
      levelName = state.levelName
      nickName = state.nickName
      
      isLoading = state.isLoading
      
      showingPopup = state.showingPopup
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
  
  // MARK: Layout init
  var body: some View {
    ZStack {
      
      if viewStore.isLoading {
        ProgressView()
      } else {
        VStack(spacing: 0){
          Color.clear.frame(height: 1)
          ScrollView {
            프로필
              .padding(.top, 10)
            VStack(spacing: 10){
              햇살카드대시보드
              활동신청목록
              햇살지수대시보드
            }
            .padding(.top, 10)
            .padding(.horizontal, 10)
            .padding(.bottom, 20)
          }
        }
      }
    }
    .eumPopup(isShowing: viewStore.binding(get: \.showingPopup, send: Action.showingPopup)){
      AnyView (
        VStack(spacing: 20) {
          RoundedRectangle(cornerRadius: 6)
            .frame(width: 67, height: 5)
            .foregroundColor(Color(.gray06))
          LevelGuildView()
        }
          .padding(22)
          .background(
            Color(.white)
              .cornerRadius(12, corners: .allCorners)
          )
          .padding(.vertical, 40)
      )
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .foregroundColor(Color(.black))
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
  
  private var leadingItem: some View {
    HStack(spacing: 0) {
      ImageAsset.biLogo.toImage()
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .frame(height: 24)
        .foregroundColor(Color.white)
      ImageAsset.koreanLogo.toImage()
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .frame(height: 24)
        .foregroundColor(Color.white)
    }
  }
  
  private var 활동신청목록: some View {
    NavigationLink(destination: MPMyApplyView(store: .init(initialState: MPMyApply.State()){MPMyApply()})){
      containerBox (
        HStack {
          VStack(alignment: .leading, spacing: 10){
            HStack(spacing: 2) {
              ImageAsset.위치.toImage()
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(height: 24)
              
              Text("\(viewStore.address)")
                .font(.subR)
            }
            .foregroundColor(Color(.systemgray07))
            Text("활동 신청 목록")
              .font(.headerB)
          }
          .hLeading()
          
          화살표
            .foregroundColor(Color(.primaryLight))
            .background(
              Circle()
                .foregroundColor(Color(.primary))
            )
        },
        color: Color(.white)
      )
    }
  }
  
  private var 프로필: some View {
    return VStack(spacing: 30) {
      Text("\(viewStore.nickName) 님 안녕하세요!")
        .foregroundColor(Color.white)
        .font(.titleB)
      KFImage(viewStore.characterUrl)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(height: 225)
    }
  }
  
  private var 햇살카드대시보드: some View {
    NavigationLink(destination: PayHomeView(store: payHomeStore)){
      containerBox(
        HStack(spacing: 15) {
          ImageAsset.햇살아이콘.toImage()
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 43)
          
          VStack(alignment: .leading, spacing: 1){
            Text("지금 바로 보낼 수 있어요")
              .font(.subR)
            
            HStack(spacing: 5) {
              Text("\(viewStore.balance)")
                .font(.largeTitleB)
              Text("햇살")
                .font(.titleB)
            }
          }
          .hLeading()
          
          
          화살표
            .foregroundColor(Color(.primary))
            .background(
              Circle()
                .foregroundColor(Color(.primaryLight))
            )
          
        }.foregroundColor(Color(.white))
        ,
        color: Color(.primary)
      )
    }
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
                Text("\(viewStore.levelName)")
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
            .frame(height: 5)
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
      },
      color: .white
    )
  }
  
  private var 화살표: some View {
    ImageAsset.rightArrow.toImage()
      .resizable()
      .renderingMode(.template)
      .aspectRatio(contentMode: .fit)
      .frame(width: 48)
      .padding(5)
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
  
  @ViewBuilder private func containerBox(_ content: some View, color: Color = .white) -> some View {
    ZStack {
      color
        .cornerRadius(20, corners: .allCorners)
      content
        .padding(.vertical, 20)
        .padding(.horizontal, 22)
    }
    .frame(maxWidth: .infinity)
  }
}


// MARK: Store init
extension HomeView {
  private var payHomeStore: StoreOf<PayHome> {
    return Store(initialState: PayHome.State()){PayHome()}
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
