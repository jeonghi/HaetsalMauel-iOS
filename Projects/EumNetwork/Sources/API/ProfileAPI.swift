//
//  ProfileAPI.swift
//  EumNetwork
//
//  Created by 쩡화니 on 11/26/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import Moya
import Combine

public enum ProfileAPI {
  case createProfile(JSONConvertible)
  case updateProfile(JSONConvertible)
  case readProfile
}

extension ProfileAPI: TargetType {
  
    public var baseURL: URL {
      return URL(string: "\(Constants.baseUrl)/profile")!
    }
    
    public var path: String {
        switch self {
        default:
          return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .createProfile:
          return .post
        case .readProfile:
          return .get
        case .updateProfile:
          return .put
        }
    }
    
    public var sampleData: Data {
      .init()
    }
    
    public var task: Task {
        switch self {
        case .createProfile(let request):
          return .requestJSONEncodable(request)
        case .readProfile:
          return .requestPlain
        case .updateProfile(let request):
          return .requestJSONEncodable(request)
        }
    }
  
  public var headers: [String : String]? {
    nil
  }
}
