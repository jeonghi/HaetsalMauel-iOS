//
//  OnboardingCore.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import ComposableArchitecture
import KakaoSDKUser
import KakaoSDKAuth
import EumNetwork
import Combine

struct Onboarding: Reducer {
  
  struct State {
    var selectedRoute: Route? = nil
    var signInState: SignIn.State = .init()
    var newProfileState: UPCreate.State = .init()
  }
  
  enum Route {
    case createProfile
  }
  
  enum SocialLoginAdvisor {
    case kakao // 카카오
    case google // 구글
    case apple // 애플
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    case setRoute(Route?)
    
    case loginDone
    
    /// Kakao Login Handler
    case kakaoLoginCallback(OAuthToken?, Error?)
    
    /// Network
    case requestKakaoLogin(String)
    case requestKakaoLoginResponse(Result<SignInEntity.Response?, HTTPError>)
    
    /// Child
    case signInAction(SignIn.Action)
    case newProfileAction(UPCreate.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
      
        /// Custom
      case .setRoute(let selectedRoute):
        state.selectedRoute = selectedRoute
        return .none
      case .loginDone:
        return .none
        
        /// Kakao Login Handler
      case .kakaoLoginCallback(let token, let error):
        if let error {
          logger.log(.error, error)
          return .none
        }else {
          guard let accessToken = token?.accessToken else {
            logger.log(.warning, "엑세스토큰 없음")
            return .none
          }
          return .send(.requestKakaoLogin(accessToken))
        }
        
        /// Network
      case .requestKakaoLogin(let accessToken):
        let request = SignInEntity.KakaoLoginRequest(token: accessToken)
        
        logger.log(.debug, "카카오 로그인 콜백 서버에 액세스 토큰 전달 \(accessToken)")
        
        return .publisher {
          authService.kakaoLogin(request)
            .receive(on: mainQueue)
            .map{Action.requestKakaoLoginResponse(.success($0))}
            .catch{Just(Action.requestKakaoLoginResponse(.failure($0)))}
        }
      case .requestKakaoLoginResponse(.success(let res)):
        guard let token = res?.toOAuthToken(), authService.saveToken(token) else {
          logger.log(.error, "서버 응답 토큰 없음")
          return .none
        }
        logger.log(.debug, "서버 응답 토큰 정상")
        return .send(.loginDone)
      case .requestKakaoLoginResponse(.failure(let error)):
        print(error)
        return .none
        
        /// Child
      case .signInAction(.loginDone):
        return .send(.loginDone)
      case .signInAction:
        return .none
      case .newProfileAction(.tappedNextButton):
        return .none
      case .newProfileAction:
        return .none
      }
    }
    Scope(state: \.signInState, action: /Action.signInAction){
      SignIn()
    }
    Scope(state: \.newProfileState, action: /Action.newProfileAction){
      UPCreate()
    }
  }
  
  // MARK: Dependency
  @Dependency(\.appService.authService) var authService
  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.logger) var logger
}
