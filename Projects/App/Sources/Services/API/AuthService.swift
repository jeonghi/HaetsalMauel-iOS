//
//  AuthService.swift
//  App
//
//  Created by 쩡화니 on 11/20/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import EumNetwork
import Combine
import EumAuth

protocol AuthServiceType {
  var isLoggedIn: Bool { get }
  func kakaoLogin(_ request: SignInEntity.KakaoLoginRequest) -> AnyPublisher<SignInEntity.Response?, HTTPError>
  func firebaseLogin(_ request: SignInEntity.AppleLoginRequest) -> AnyPublisher<SignInEntity.Response?, HTTPError>
  func localLogin(_ request: SignInEntity.LocalLoginRequest) -> AnyPublisher<SignInEntity.Response?, HTTPError>
  func verifyToken() -> AnyPublisher<SignInEntity.VerifyResponse?, HTTPError>
  func saveToken(_ token: OAuthToken) -> Bool
  func resetToken() -> Bool
  func withdrawal(_ body: WithdrawalEntity.Request) -> AnyPublisher<Box?, HTTPError>
  func getWithdrawalReasonList() -> AnyPublisher<[WithdrawalEntity.ReasonCategory]?, HTTPError>
  func logout() -> Bool
}

final class AuthService: AuthServiceType {
  func withdrawal(_ body: WithdrawalEntity.Request) -> AnyPublisher<Box?, EumNetwork.HTTPError> {
    return network.request(.withdrawal(body), responseType: Box.self)
  }
  
  func getWithdrawalReasonList() -> AnyPublisher<[WithdrawalEntity.ReasonCategory]?, EumNetwork.HTTPError> {
    return network.request(.getWithdrawalReasonList, responseType: [WithdrawalEntity.ReasonCategory].self)
  }
  
  
  static var shared = AuthService()
  let network = Network<AuthAPI>()
  private let tokenManager = TokenManager.shared
  
  var isLoggedIn: Bool {
    return tokenManager.getToken() != nil
  }
  
  private init(){}
  
  func kakaoLogin(_ request: SignInEntity.KakaoLoginRequest) -> AnyPublisher<SignInEntity.Response?, EumNetwork.HTTPError> {
    return network.request(.kakaoLogin(request), responseType: SignInEntity.Response.self)
  }
  
  func firebaseLogin(_ request: SignInEntity.AppleLoginRequest) -> AnyPublisher<SignInEntity.Response?, EumNetwork.HTTPError> {
    network.request(.firebaseLogin(request), responseType: SignInEntity.Response.self)
  }
  
  func localLogin(_ request: SignInEntity.LocalLoginRequest) -> AnyPublisher<SignInEntity.Response?, EumNetwork.HTTPError> {
    network.request(.localLogin(request), responseType: SignInEntity.Response.self)
  }
  
  func verifyToken() -> AnyPublisher<SignInEntity.VerifyResponse?, HTTPError> {
    return network.request(.verify, responseType: SignInEntity.VerifyResponse.self)
  }
  
  func saveToken(_ token: OAuthToken) -> Bool {
    tokenManager.setToken(token)
    guard let _  = tokenManager.getToken() else {
      return false
    }
    return true
  }
  
  func resetToken() -> Bool {
    tokenManager.deleteToken()
    guard let _ = tokenManager.getToken() else {
      return true
    }
    return false
  }
  
  func logout() -> Bool {
     return resetToken()
  }
}
