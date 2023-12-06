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
import FirebaseAuth

struct Onboarding: Reducer {
  
  struct State {
    var selectedRoute: Route? = nil
    var showingFullSheet: Bool = false
    var signInState: SignIn.State = .init()
    var newProfileState: UPCreate.State = .init()
    var setPasswordState: SetPassword.State?
    var isLoading: Bool = false
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
    
    case isLoading(Bool)
    case loginDone
    case setPasswordDone
    case showFullSheet
    case dismissFullSheet
    
    ///
    
    /// Kakao Login Handler
    case kakaoLoginCallback(OAuthToken?, Error?)
    
    /// Apple Login Handler
    case appleLoginCallback(String?, Error?)
    
    /// Network
    case requestKakaoLogin(String)
    case requestFirebaseLogin(String)
    case requestSignInResponse(Result<SignInEntity.Response?, HTTPError>)
    
    /// Child
    case signInAction(SignIn.Action)
    case newProfileAction(UPCreate.Action)
    case setPasswordAction(SetPassword.Action)
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
      case .isLoading(let isLoading):
        state.isLoading = isLoading
        return .none
        
      case .setRoute(let selectedRoute):
        state.selectedRoute = selectedRoute
        return .none
      case .loginDone:
        return .none
      case .setPasswordDone:
        return .none
        
      case .showFullSheet:
        state.setPasswordState = .init()
        state.showingFullSheet = true
        return .none
      case .dismissFullSheet:
        state.showingFullSheet = false
        state.setPasswordState = nil
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
        
      case .appleLoginCallback(let idToken, let error):
        if let error {
          logger.log(.error, error)
          return .none
        }else {
          guard let idToken = idToken else {
            logger.log(.error, "id토큰 없음")
            return .none
          }
          logger.log(.debug, "id토큰: \(idToken)")
          return .send(.requestFirebaseLogin(idToken))
        }
        
        /// Network
      case .requestKakaoLogin(let accessToken):
        let request = SignInEntity.KakaoLoginRequest(token: accessToken)
        
        logger.log(.debug, "카카오 로그인 콜백 서버에 액세스 토큰 전달 \(accessToken)")
        
        let publisher = Effect.publisher {
          authService.kakaoLogin(request)
            .receive(on: mainQueue)
            .map{Action.requestSignInResponse(.success($0))}
            .catch{Just(Action.requestSignInResponse(.failure($0)))}
        }
        
        return .merge(
          .send(.isLoading(true)),
          publisher
        )
        
      case .requestFirebaseLogin(let idToken):
        let request = SignInEntity.AppleLoginRequest(token: idToken)
        
        logger.log(.debug, "파이어베이스 로그인 콜백 서버에 id 토큰 전달 \(idToken)")
        
        let publisher = Effect.publisher {
          authService.firebaseLogin(request)
            .receive(on: mainQueue)
            .map{Action.requestSignInResponse(.success($0))}
            .catch{Just(Action.requestSignInResponse(.failure($0)))}
        }
        
        return .merge(
          .send(.isLoading(true)),
          publisher
        )
        
      case .requestSignInResponse(.success(let res)):
        guard let res = res, authService.saveToken(res.toOAuthToken()) else {
          logger.log(.error, "서버 응답 토큰 없음")
          return .none
        }
        logger.log(.debug, "서버 응답 토큰 정상")
        return .merge(
          .send(.isLoading(false)),
          .send(.loginDone)
        )
        
      case .requestSignInResponse(.failure(let error)):
        print(error)
        return .send(.isLoading(false))
        
        /// Child
      case .signInAction(.requestSignInResponse(.success(let res))):
        return .send(.requestSignInResponse(.success(res)))
      case .signInAction:
        return .none
      case .newProfileAction(.tappedNextButton):
        return .none
      case .newProfileAction:
        return .none
      case .setPasswordAction(.passwordSetDone):
        return .concatenate([
        .send(.dismissFullSheet),
        .send(.setPasswordDone)
        ])
      case .setPasswordAction(.passwordSetFail):
        return .send(.dismissFullSheet)
      case .setPasswordAction:
        return .none
      }
    }
    .ifLet(\.setPasswordState, action: /Action.setPasswordAction){
      SetPassword()
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
