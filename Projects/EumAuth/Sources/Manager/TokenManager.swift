//
//  TokenManager.swift
//  ProjectDescriptionHelpers
//
//  Created by 쩡화니 on 11/27/23.
//

import Foundation
import KeychainAccess

public protocol TokenManagable {
  /// 토큰을 저장
  func setToken(_ token: OAuthToken?)
  /// 저장된 토큰 가져오기
  func getToken() -> OAuthToken?
  /// 저장된 토큰 삭제하기
  func deleteToken()
}

final public class TokenManager: TokenManagable {
  
  public static let shared = TokenManager()
  
  private let OAuthTokenKey = "kr.k-eum.auth.oauth_token"
  
  var token: OAuthToken?
  
  private init() {
    self.token = Properties.loadCodable(key: OAuthTokenKey)
  }
  
  public func setToken(_ token: OAuthToken?) {
    Properties.saveCodable(key: OAuthTokenKey, data: token)
    self.token = Properties.loadCodable(key: OAuthTokenKey)
  }
  
  public func getToken() -> OAuthToken? {
    return self.token
  }
  
  public func deleteToken() {
    Properties.delete(OAuthTokenKey)
    self.token = nil
  }
}
