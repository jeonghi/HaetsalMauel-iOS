//
//  MainTab.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
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
    
    NavigationView {
      TabView(
        selection: viewStore.binding(
          get: \.selectedTab,
          send: Action.setTab
        )
      ){
        
        /// 홈
        HomeView(store: homeStore)
          .tag(Tab.홈)
          .tabItem {
            VStack {
              Group {
                if(viewStore.selectedTab == .홈){
                  ImageAsset.홈fill.toImage()
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }else{
                  ImageAsset.홈.toImage()
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }
              }
              .frame(height: 28)
              Text("홈")
            }
          }
        
        /// 햇터
        Color.white
          .tag(Tab.햇터)
          .tabItem {
            VStack {
              Group {
                if(viewStore.selectedTab == .햇터){
                  ImageAsset.햇터fill.toImage()
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }else{
                  ImageAsset.햇터.toImage()
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }
              }
              .frame(height: 28)
              Text("햇터")
            }
          }
        
        /// 채팅
        ChatHomeView(store: chatHomeStore)
          .tag(Tab.채팅)
          .tabItem {
            VStack {
              Group {
                if(viewStore.selectedTab == .채팅){
                  ImageAsset.채팅fill.toImage()
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }else{
                  ImageAsset.채팅.toImage()
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }
              }
              .frame(height: 28)
              Text("채팅")
            }
          }
        
        /// 소통
        CommunityHomeView(store: communityStore)
          .tag(Tab.소통)
          .tabItem {
            VStack {
              Group {
                if(viewStore.selectedTab == .소통){
                  ImageAsset.소통fill.toImage()
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }else{
                  ImageAsset.소통.toImage()
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }
              }
              .frame(height: 28)
              Text("소통")
            }
          }
        
        /// 우리 마을
        Color.white
          .tag(Tab.우리마을)
          .tabItem {
            VStack {
              Group {
                if(viewStore.selectedTab == .우리마을){
                  ImageAsset.우리마을fill.toImage()
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }else{
                  ImageAsset.우리마을.toImage()
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }
              }
              .frame(height: 28)
              Text("우리마을")
            }
          }
      }
      .accentColor(Color(.primary))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .navigationViewStyle(.stack)
    .onAppear{
      viewStore.send(.onAppear)
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
  
  private var communityStore: StoreOf<CommunityHome> {
    return store.scope(state: \.communityHomeState, action: Action.communityAction)
  }
  
  private var chatHomeStore: StoreOf<ChatHome> {
    return store.scope(state: \.chatHomeState, action: Action.chatHomeAction)
  }
}

// MARK: - Preview
struct MainTab_Previews: PreviewProvider {
  static var previews: some View {
    
    let store = Store(initialState: MainTab.State()){MainTab()}
    MainTabView(store: store)
  }
}
