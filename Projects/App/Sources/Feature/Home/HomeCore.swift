//
//  HomeCore.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import ComposableArchitecture
import EumNetwork
import Combine
import Foundation
import SwiftUI

struct Home: Reducer {
  
  
  
  struct State {
    
    @AppStorage("userName") var nickName : String = ""
    /// 화면 데이터
    var address: String = ""
    var characterUrl: URL? = nil
    var balance: Int64 = 0
    var characterName: String = ""
    var levelName: String = ""
    
    /// 로딩
    var isLoading: Bool = true
    
    /// 팝업
    var showingPopup: Bool = false
  }
  
  
  enum Action {
    case onAppear
    case onDisappear
    
    case isLoading(Bool)
    case showingPopup(Bool)
    
    /// 네트워크
    case requestGetProfile
    case requestGetProfileResponse(Result<ProfileEntity.Response?, HTTPError>)
    case requestGetMyPayInfo
    case requestGerMyPayInfoResponse(Result<PayAccountEntity.Response?, HTTPError>)
    

  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        
      case .onAppear:
        return .concatenate([
          .send(.isLoading(true)),
          .merge(
            .send(.requestGetProfile),
            .send(.requestGetMyPayInfo)
          )
        ])
      case .onDisappear:
        return .none
        
      case .isLoading(let isLoading):
        state.isLoading = isLoading
        return .none
        
      case .showingPopup(let showingPopup):
        state.showingPopup = showingPopup
        return .none
        
        /// 네트워크
      case .requestGetProfile:
        
        return .publisher {
          profileService.readProfile()
            .receive(on: mainQueue)
            .map{Action.requestGetProfileResponse(.success($0))}
            .catch{Just(Action.requestGetProfileResponse(.failure($0)))}
        }
        
      case .requestGetProfileResponse(.success(let res)):
        guard let res = res else {
          logger.log(.warning, res)
          return .none
        }
        logger.log(.debug, res)
        state.address = res.address
        state.characterUrl = URL(string: res.avatarPhotoURL)
        state.characterName = res.characterName
        state.levelName = res.levelName
        state.nickName = res.nickname
        return .send(.isLoading(false))
        
      case .requestGetProfileResponse(.failure(let error)):
        logger.log(.error, error)
        return .none
        
      case .requestGetMyPayInfo:
        return .publisher{
          payService.getMyCardInfo()
            .receive(on: mainQueue)
            .map{Action.requestGerMyPayInfoResponse(.success($0))}
            .catch{Just(Action.requestGerMyPayInfoResponse(.failure($0)))}
        }
      case .requestGerMyPayInfoResponse(.success(let res)):
        guard let res = res else {
          return .none
        }
        state.balance = res.balance
        return .none
      case .requestGerMyPayInfoResponse(.failure(let error)):
        return .none
      }
    }
  }
  
  @Dependency(\.appService.profileService) var profileService
  @Dependency(\.appService.payService) var payService
  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.logger) var logger
}
