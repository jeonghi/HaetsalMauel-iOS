//
//  OAuth.swift
//  ProjectDescriptionHelpers
//
//  Created by 쩡화니 on 11/27/23.
//

import Foundation

public struct OAuthToken: Codable {
  public let tokenType: String
  public let accessToken: String
  public let refreshToken: String
  public let expireAt: Date
}
