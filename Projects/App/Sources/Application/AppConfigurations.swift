//
//  AppConfigurations.swift
//  Eum
//
//  Created by JH Park on 2023/09/13.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation

final class AppConfiguration {
  
  static let shared = AppConfiguration()
  
  private init() {}
  
  lazy var apiKey: String = {
    guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
      fatalError("ApiKey must not be empty in plist")
    }
    return apiKey
  }()
  lazy var apiBaseURL: String = {
    guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
      fatalError("ApiBaseURL must not be empty in plist")
    }
    return apiBaseURL
  }()
}
