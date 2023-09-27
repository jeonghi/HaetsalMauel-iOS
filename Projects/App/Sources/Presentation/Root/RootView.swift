//
//  AppView.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
  
  typealias Core = Root
  typealias State = Core.State
  typealias Action = Core.Action
  typealias Route = Core.Route
  
  private let store: StoreOf<Core>
  @ObservedObject var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var route: Route
    init(state: State){
      route = state.route
      
    }
  }
  
  init(store: StoreOf<Core>){
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
  
  var body: some View {
    Group {
      ZStack {
        Color.white
        switch viewStore.route {
        case .onboarding:
          IfLetStore(
            onboardingStore,
            then: OnboardingView.init
          )
        case .mainTab:
          IfLetStore(
            mainTabStore,
            then: MainTabView.init
          )
        }
      }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear{
          viewStore.send(.onAppear)
        }
    }
  }
}

extension RootView {
  private var onboardingStore: Store<Onboarding.State?, Onboarding.Action> {
    return store.scope(state: \.onboardingState, action: Action.onboardingAction)
  }
  private var mainTabStore: Store<MainTab.State?, MainTab.Action> {
    return store.scope(state: \.mainTabState, action: Action.mainTabAction)
  }
}

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    let store = Store(initialState: Root.State()){
      Root()
    }
    RootView(store: store)
  }
}
