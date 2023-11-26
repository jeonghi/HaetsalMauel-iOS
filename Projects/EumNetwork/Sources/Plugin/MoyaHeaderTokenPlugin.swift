//
//  MoyaHeaderTokenPlugin.swift
//  EumNetwork
//
//  Created by 쩡화니 on 11/26/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Moya
import Foundation

final class MoyaHeaderTokenPlugin: PluginType {
  public init() {}
  
  public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    guard let token = retrieveToken() else {
      return request
    }
    var request = request
    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    return request
  }
  
  public func retrieveToken() -> String? {
    return nil
  }
}
