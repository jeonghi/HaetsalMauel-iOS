//
//  AppCore.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import ComposableArchitecture
import EumAuth
import EumNetwork
import Combine

struct Root: Reducer {
  struct State {
    
    var route: Route = .onboarding
    var onboardingState: Onboarding.State? = .init()
    var mainTabState: MainTab.State?
    var fromSetting: FromSetting?
    
    enum FromSetting {
      case logout
      case signOut
    }
  }
  
  enum Route {
    case onboarding // 온보딩
    case mainTab // 메인탭
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    case setRoute(Route)
    
    /// Authentication
    case signOut
    case signIn
    case withdrawal
    
    /// Alert
    
    /// 네트워크 처리
    case requestVerifyToken
    case requestVerifyTokenResponse(Result<SignInEntity.VerifyResponse?, HTTPError>)
    
    /// Child
    case onboardingAction(Onboarding.Action)
    case mainTabAction(MainTab.Action)
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        if authService.isLoggedIn {
          return .send(.requestVerifyToken)
        } else {
          return .send(.setRoute(.onboarding))
        }      
      case .onDisappear:
        return .none
      case .setRoute(let selectedRoute):
        switch selectedRoute {
        case .mainTab:
          state.mainTabState = .init()
        case .onboarding:
          state.onboardingState = .init()
        }
        state.route = selectedRoute
        return .none
        
        /// Authentication
      case .signOut:
        return .none
      case .signIn:
        return .none
      case .withdrawal:
        return .none
      
        /// 네트워크 처리
      case .requestVerifyToken:
        return .publisher {
          authService.verifyToken()
            .receive(on: mainQueue)
            .map{Action.requestVerifyTokenResponse(.success($0))}
            .catch{Just(Action.requestVerifyTokenResponse(.failure($0)))}
        }
      case .requestVerifyTokenResponse(.success(let res)):
        guard let res = res else {
          logger.log(.warning, res)
          return .none
        }
        switch res.role {
        case .unprofileUser:
          logger.log(.debug, "프로필이 없는 유저입니다. 프로필 생성 화면으로 이동합니다")
          return .send(.onboardingAction(.setRoute(.createProfile)))
        case .unpasswordUser:
          logger.log(.debug, "패스워드 설정이 되지 않은 유저입니다. 패스워드 설정 화면으로 이동합니다.")
          return .send(.onboardingAction(.showFullSheet))
        default:
          logger.log(.info, "메인 탭으로 이동합니다. 사용자 권한: \(res.role)")
          return .send(.setRoute(.mainTab))
        }
      case .requestVerifyTokenResponse(.failure(let error)):
        logger.log(.error, error)
        authService.resetToken()
        return .send(.setRoute(.onboarding))
        
        /// Child
      case .onboardingAction(.loginDone):
        return .send(.onAppear)
      case .onboardingAction(.setPasswordDone):
        return .send(.onAppear)
      case .onboardingAction(.newProfileAction(.requestCreateProfileResponse(.success(_)))):
        return .send(.onAppear)
        
      case .onboardingAction:
        return .none
        
      case .mainTabAction(.settingAction(.logout)):
        state.mainTabState = nil
        return .send(.setRoute(.onboarding))
        
        /// 탈퇴 성공시 온보딩으로 이동
      case .mainTabAction(.settingAction(.withdrawalReasonAction(.withdrawalDetailReasonAction(.requestWithdrawalServiceResponse(.success(_)))))):
        return .send(.setRoute(.onboarding))
      case .mainTabAction(.settingAction(.signOut)):
        return .send(.setRoute(.onboarding))
      case .mainTabAction:
        return .none
      }
    }
    .ifLet(\.mainTabState, action: /Action.mainTabAction){
      MainTab()
    }
    .ifLet(\.onboardingState, action: /Action.onboardingAction){
      Onboarding()
    }
  }
  
  @Dependency(\.appService.authService) var authService
  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.logger) var logger
}
