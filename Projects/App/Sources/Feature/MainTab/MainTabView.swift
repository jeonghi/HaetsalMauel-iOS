//
//  MainTab.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import UIKit
import ComposableArchitecture
import UISystem
import DesignSystemFoundation

struct MainTabView: View {
  
  typealias Core = MainTab
  typealias State = Core.State
  typealias Action = Core.Action
  typealias Tab = Core.Tab
  
  private let store: StoreOf<Core>
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    
    var selectedTab: Tab
    
    init(state: State) {
      selectedTab = state.selectedTab
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
    
  }
  
  var body: some View {
    
    TabView(
      selection: viewStore.binding(
        get: \.selectedTab,
        send: Action.setTab
      )
    ){
      HomeView(store: homeStore)
        .tag(Tab.홈)
        .tabItem {
          VStack {
            Group {
              if(viewStore.selectedTab == .홈){
                fitToImage(ImageAsset.홈fill, 28)
              } else{
                fitToImage(ImageAsset.홈, 28)
              }
            }
            Text("홈")
          }
        }
      
      MPHomeView(store: marketPlaceHomeStore)
        .tag(Tab.햇터)
        .tabItem {
          VStack {
            viewStore.selectedTab == .햇터 ? fitToImage(ImageAsset.햇터fill, 28) : fitToImage(ImageAsset.햇터, 28)
            Text("햇터")
          }
        }
      
      
      /// 채팅
      ChatHomeView(store: chatHomeStore)
        .tag(Tab.채팅)
        .tabItem {
          VStack {
            viewStore.selectedTab == .채팅 ? fitToImage(.채팅fill, 28) : fitToImage(.채팅, 28)
            Text("채팅")
          }
        }
      
      /// 소통
//      CMHomeView(store: communityStore)
//        .tag(Tab.소통)
//        .tabItem {
//          VStack {
//            viewStore.selectedTab == .소통 ? fitToImage(.소통fill, 28) : fitToImage(.소통, 28)
//            Text("소통")
//          }
//        }
      
      /// 우리 마을
      EventHomeView(store: eventHomeStore)
        .tag(Tab.행사)
        .tabItem {
          VStack {
            viewStore.selectedTab == .행사 ? fitToImage(.우리마을fill, 28) : fitToImage(.우리마을, 28)
            Text("행사")
          }
        }
    }
    .navigationBarTitleDisplayMode(.inline)
    .accentColor(Color(.primary))
    .toolbar {
      switch viewStore.selectedTab {
      case .홈:
        ToolbarItemGroup(placement: .navigationBarLeading){
          HStack(spacing: 0) {
            fitToImage(.localLogo, 24)
            fitToImage(.koreanLogo, 24)
          }
          .foregroundColor(Color(.white))
        }
        ToolbarItemGroup(placement: .navigationBarTrailing){
          HStack {
            NavigationLink(
              destination: SettingView(store: settingStore)
            ){
              fitToImage(.setting, 24)
            }
            .foregroundColor(Color(.white))
          }
        }
        
      case .햇터:
        ToolbarItemGroup(placement: .principal){
          Text(viewStore.selectedTab.rawValue)
            .foregroundColor(Color(.black))
            .font(.headerB)
        }
        ToolbarItemGroup(placement: .navigationBarTrailing){
          NavigationLink(destination: MPSearchView(store: marketPlaceSearchStore)) {
            fitToImage(.검색, 24)
          }
          .foregroundColor(Color(.black))
        }
        
      default:
        ToolbarItemGroup(placement: .principal){
          Text(viewStore.selectedTab.rawValue)
            .foregroundColor(Color(.black))
            .font(.headerB)
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear {
      viewStore.send(.onDisappear)
    }
  }
}
// MARK: - Store init
extension MainTabView {
  private var homeStore: StoreOf<Home> {
    return store.scope(
      state: \.homeState,
      action: Action.homeAction
    )
  }
  
  private var communityStore: StoreOf<CMHome> {
    return store.scope(state: \.communityHomeState, action: Action.communityAction)
  }
  
  private var chatHomeStore: StoreOf<ChatHome> {
    return store.scope(state: \.chatHomeState, action: Action.chatHomeAction)
  }
  
  private var marketPlaceHomeStore: StoreOf<MPHome> {
    return store.scope(state: \.marketPlaceHomeState, action: Action.marketPlaceHomeAction)
  }
  
  private var eventHomeStore: StoreOf<EventHome> {
    return store.scope(state: \.eventHomeState, action: Action.eventHomeAction)
  }
  
  private var settingStore: StoreOf<Setting> {
    return store.scope(state: \.settingState, action: Action.settingAction)
  }
  
  private var marketPlaceSearchStore: StoreOf<MPSearch> {
    return .init(initialState: MPSearch.State()){MPSearch()}
  }
  
  private func fitToImage(_ image: ImageAsset, _ imageHeight: CGFloat) -> some View {
    image.toImage()
      .renderingMode(.template)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(height: imageHeight)
  }
}

// MARK: - Preview
struct MainTab_Previews: PreviewProvider {
  static var previews: some View {
    
    let store = Store(initialState: MainTab.State()){MainTab()}
    
    NavigationView {
      MainTabView(store: store)
    }
  }
}
