//
//  OnboardingView.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct OnboardingView: View {
  
  typealias Core = Onboarding
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
      
      // 타이틀
      HStack {
        VStack(alignment: .leading, spacing: 16) {
          // 메인 타이틀
          Text("모두에게 동일한 시간\n시간을 거래하는 타임페이")
          
          // 서브 타이틀
          Text("나의 시간을 가치있게 써보아요")
        }
        Spacer()
      }
      .padding(.horizontal, 22)
      .padding(.top, 72)
      
      Spacer()
      
      // 임시 이미지
      Color.gray
        .frame(width: 100, height: 100)
        .padding(.top, 77)
      
      // 둘러보기
      Button(action: {viewStore.send(.skipButtonTapped)}){
        Text("시작전에 둘러보기")
      }
      .padding(.top, 48)
      .padding(.bottom, 78)
      
      Spacer()
      
      VStack {
        Button(action: {}){
          Text("타임페이 시작하기")
        }
        Button(action: {}){
          Text("카카오로 시작하기")
        }
        Button(action: {}){
          Text("Apple로 시작하기")
        }
      }
      .padding(.bottom, 50)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onAppear {
      viewStore.send(.onAppear)
    }
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    
    let store = Store(initialState: Onboarding.State()){Onboarding()}
    OnboardingView(store: store)
  }
}
