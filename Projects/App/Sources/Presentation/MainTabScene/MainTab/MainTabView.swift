//
//  MainTab.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct MainTabView: View {
  
  typealias Core = MainTab
  typealias State = Core.State
  typealias Action = Core.Action
  typealias Route = Core.Route
  
  private let store: StoreOf<Core>
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    
    var route: Route
    
    init(state: State) {
      route = state.route
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
          get: \.route,
          send: Action.setRoute
        )
      ){
        
        HomeView(store: homeStore)
          .tag(Route.home)
          .tabItem {
            VStack {
              Image(systemName: "house.fill")
              Text("홈")
            }
          }
        
        Color.white
          .tag(Route.communiy)
          .tabItem {
            VStack {
              Image(systemName: "house.fill")
              Text("커뮤니티")
            }
          }
        
        Color.white
          .tag(Route.chat)
          .tabItem {
            VStack {
              Image(systemName: "house.fill")
              Text("채팅")
            }
          }
        
        SettingView(store: settingStore)
          .tag(Route.etc)
          .tabItem {
            VStack {
              Image(systemName: "house.fill")
              Text("기타")
            }
          }
      }
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
  
  private var settingStore: StoreOf<Setting> {
    return store.scope(state: \.settingState, action: Action.settingAction)
  }
}

// MARK: - Preview
struct MainTab_Previews: PreviewProvider {
  static var previews: some View {
    
    let store = Store(initialState: MainTab.State()){MainTab()}
    MainTabView(store: store)
  }
}
