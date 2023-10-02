//
//  UserProfileSettingCore.swift
//  App
//
//  Created by JH Park on 2023/09/30.
//  Copyright © 2023 com.eum. All rights reserved.
//
import ComposableArchitecture

struct UserProfileSetting: Reducer {
  
  struct State {
    var route: Route? = nil
    var nickName: String = "" /// 닉네임
    var comment: String = "" /// 한마디
  }
  
  enum Route {
  }
  
  
  enum Action {
    case onAppear
    case onDisappear
    case setRoute(Route)
    case setNickName(String)
    case setComment(String)
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .onAppear:
      return .none
    case .onDisappear:
      return .none
    case .setRoute(let selectedRoute):
      state.route = selectedRoute
      return .none
    case .setNickName(let nickName):
      state.nickName = nickName
      return .none
    case .setComment(let comment):
      state.comment = comment
      return .none
    }
  }
}
