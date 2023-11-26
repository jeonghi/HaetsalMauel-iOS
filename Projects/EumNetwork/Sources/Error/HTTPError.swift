//
//  HTTPError.swift
//  EumNetwork
//
//  Created by 쩡화니 on 11/26/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import Moya

public enum HTTPError: Error {
  case networkError
  case serverError(String)
  case decodingError
  case invalidToken
  case notFound
  case unknown
  
  init(_ moyaError: MoyaError) {
      if moyaError.isInvalidTokenError {
          self = .invalidToken
      } else if moyaError.isNotFoundError {
          self = .notFound
      } else if let serverMessage = moyaError.serverErrorMessage {
          self = .serverError(serverMessage)
      } else {
          self = .networkError
      }
  }
}
