//
//  OnboardingView.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import UISystem
import DesignSystemFoundation
import ComposableArchitecture
import KakaoSDKUser

struct OnboardingView: View {
  
  typealias Core = Onboarding
  typealias State = Core.State
  typealias Action = Core.Action
  typealias Route = Core.Route
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var selectedRoute: Route?
    var showingFullSheet: Bool
    var isLoading: Bool
    init(state: State) {
      selectedRoute = state.selectedRoute
      showingFullSheet = state.showingFullSheet
      isLoading = state.isLoading
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
  
  var body: some View {
    
    ZStack {
      VStack(spacing: 0) {
        
        NavigationLink(
          tag: Route.createProfile,
          selection: viewStore.binding(get: \.selectedRoute, send: Action.setRoute),
          destination: {UPCreateView(store: UPCreateStore)},
          label: EmptyView.init
        )
        
        VStack(alignment: .leading, spacing: 16){
          title
          subTitle
        }
        .hLeading()
        .padding(.top, 72)
        .padding(.horizontal, 22)
        
        BILogo
          .padding(.top, 77)
          .padding(.horizontal, 127)
        
        loginButtonVStack
          .vCenter()
          .padding(.horizontal, 22)
          .padding(.top, 52)
          .padding(.bottom, 55)
        
        skipButton
          .padding(.horizontal, 22)
          .padding(.bottom, 50)
      }
      
      if(viewStore.isLoading){
        Color.white.opacity(0.4)
          .ignoresSafeArea()
        ProgressView()
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .fullScreenCover(isPresented: viewStore.binding(get: \.showingFullSheet, send: Action.dismissFullSheet)){
      NavigationView {
        IfLetStore(setPasswordStore) {
          SetPasswordView(store: $0)
        }
      }
    }
    .onAppear {
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
  }
}

extension OnboardingView {
  private var title: some View {
    Text("모두에게 동일한 시간\n시간을 교환하는 햇살마을")
      .font(.titleB)
      .foregroundColor(Color(.black))
  }
  
  private var subTitle: some View {
    Text("함께 햇살을 모아 우리 마을을 화창하게 만들어요")
      .font(.subR)
      .foregroundColor(Color(.systemgray07))
  }
  
  private var BILogo: some View {
    ImageAsset.onboardingLogo.toImage()
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(maxWidth: .infinity)
  }
  
  private var skipButton: some View {
    
    HStack(spacing: 5){
      Text("기관 사용자이신가요?")
        .font(.subR)
        .foregroundColor(Color(.gray06))
      NavigationLink(destination: SignInView(store: signUpStore)){
        Text("기관으로 로그인")
          .underline()
          .font(.subR)
          .foregroundColor(Color(.primary))
      }
    }
  }
  
  private var loginButtonVStack: some View {
    VStack(spacing: 10){
      Button(action: {
        UserApi.shared.loginWithKakaoAccount{viewStore.send(.kakaoLoginCallback($0, $1))}
      }){
        TTLoginLabel(.kakao)
      }
      Button(action: {
        SignInService.shared.loginWithAppleAccount{
          viewStore.send(.appleLoginCallback($0, $1))
        }
      }){
        TTLoginLabel(.apple)
      }
    }
  }
}

extension OnboardingView {
  private var signUpStore: StoreOf<SignIn> {
    return store.scope(state: \.signInState, action: Action.signInAction)
  }
  private var UPCreateStore: StoreOf<UPCreate> {
    return store.scope(state: \.newProfileState, action: Action.newProfileAction)
  }
  
  private var setPasswordStore: Store<SetPassword.State?, SetPassword.Action> {
    return store.scope(state: \.setPasswordState, action: Action.setPasswordAction)
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    
    let store = Store(initialState: Onboarding.State()){Onboarding()}
    
    NavigationView {
      OnboardingView(store: store)
    }
  }
}
