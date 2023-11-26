//
//  AuthAPI.swift
//  ProjectDescriptionHelpers
//
//  Created by JH Park on 2023/09/18.
//

import Foundation
import Moya
import Combine

public enum AuthAPI {
  case localLogin(JSONConvertible)
  case kakaoLogin(JSONConvertible)
  case appleLogin(JSONConvertible)
  case logout(JSONConvertible)
  case reissue
}

extension AuthAPI: TargetType {
  
  public var baseURL: URL {
    return URL(string: "\(Constants.baseUrl)/user")!
  }
  
  public var path: String {
    switch self {
    case .localLogin:
      return "/auth/signin"
    case .kakaoLogin:
      return "/auth/kakao"
    case .appleLogin:
      return "/auth/apple"
    case .logout:
      return "/logout"
    case .reissue:
      return "/reissue"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .appleLogin, .kakaoLogin, .localLogin, .reissue, .logout:
      return .post
    }
  }
  
  public var sampleData: Data {
    .init()
  }
  
  public var task: Task {
      switch self {
      case .appleLogin(let request), .kakaoLogin(let request), .localLogin(let request):
          return .requestJSONEncodable(request)
      case .logout(let request):
          return .requestJSONEncodable(request)
      case .reissue:
          return .requestPlain
      }
  }
  
  public var headers: [String : String]? {
    nil
  }
}
