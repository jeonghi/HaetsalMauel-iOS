//
//  LoginModel.swift
//  App
//
//  Created by 쩡화니 on 11/26/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import EumNetwork
import EumAuth
import Foundation

enum SignInEntity {
  
  struct LocalLoginRequest: Codable, JSONConvertible {
    let email: String
    let password: String
  }
  
  struct AppleLoginRequest: Codable, JSONConvertible {
    let token: String
  }
  
  struct KakaoLoginRequest: Codable, JSONConvertible {
    let token: String
  }
  
  struct Response: Codable {
    let accessToken: String
    let grantType: String
    let refreshToken: String
    let refreshTokenExpirationTime: Int64
    let role: UserRole
  }
}

enum UserRole: String, Codable {
  case authUser = "ROLE_AUTH_USER"
  case organization = "ROLE_ORGANIZATION"
  case temporaryUser = "ROLE_TEMPORARY_USER"
  case user = "ROLE_USER"
  case test = "TEST"
}

extension SignInEntity.Response {
  func toOAuthToken() -> OAuthToken {
      return OAuthToken(
          tokenType: self.grantType,
          accessToken: self.accessToken,
          refreshToken: self.refreshToken,
          expirationTime: TimeInterval(self.refreshTokenExpirationTime / 1000) // 밀리초를 초로 변환
      )
  }
}
