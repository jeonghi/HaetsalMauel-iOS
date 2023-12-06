//
//  MoyaHeaderTokenPlugin.swift
//  EumNetwork
//
//  Created by 쩡화니 on 11/26/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Moya
import Foundation
import EumAuth

final class MoyaHeaderTokenPlugin: PluginType {
  
  static let shared = MoyaHeaderTokenPlugin()
  private let tokenManager = TokenManager.shared
  
  private init() {}
  
  public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    guard let token = tokenManager.getToken() else {
      return request
    }
    var request = request
    request.addValue("\(token.tokenType) \(token.accessToken)", forHTTPHeaderField: "Authorization")
    return request
  }
}
