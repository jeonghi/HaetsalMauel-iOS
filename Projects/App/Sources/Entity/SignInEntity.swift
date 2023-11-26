//
//  LoginModel.swift
//  App
//
//  Created by 쩡화니 on 11/26/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import EumNetwork

enum SignInEntity {
  
  struct LocalLoginRequest: Codable, JSONConvertible {
    let email: String
    let password: String
  }
  
  struct AppleLoginRequest: Codable, JSONConvertible {
    let accessToken: String
  }
  
  struct KakaoLoginRequest: Codable, JSONConvertible {
    let accessToken: String
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
