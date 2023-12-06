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
  case firebaseLogin(JSONConvertible)
  case logout(JSONConvertible)
  case reissue
  case verify
}

extension AuthAPI: TargetType {
  
  public var baseURL: URL {
    return URL(string: "\(Constants.baseUrl)")!
  }
  
  public var path: String {
    switch self {
    case .localLogin:
      return "/auth/signin/local"
    case .kakaoLogin:
      return "/auth/signin/kakao"
    case .firebaseLogin:
      return "/auth/signin/firebase"
    case .logout:
      return "/logout"
    case .reissue:
      return "/auth/reissue"
    case .verify:
      return "/token"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .firebaseLogin, .kakaoLogin, .localLogin, .reissue, .logout:
      return .post
    case .verify:
      return .get
    }
  }
  
  public var sampleData: Data {
    .init()
  }
  
  public var task: Task {
    switch self {
    case .firebaseLogin(let request), .kakaoLogin(let request), .localLogin(let request):
      return .requestJSONEncodable(request)
    case .logout(let request):
      return .requestJSONEncodable(request)
    case .reissue:
      return .requestPlain
    case .verify:
      return .requestPlain
    }
  }
  
  public var headers: [String : String]? {
    nil
  }
}
