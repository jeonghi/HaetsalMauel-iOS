//
//  RegionAPI.swift
//  EumNetwork
//
//  Created by 쩡화니 on 11/26/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import Moya
import Combine

public enum RegionAPI {
  case readRegion(ParamsConvertible)
}

extension RegionAPI: TargetType {
  
    public var baseURL: URL {
      return URL(string: "\(Constants.baseUrl)/region")!
    }
    
    public var path: String {
        switch self {
        case .readRegion:
          return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .readRegion:
          return .get
        }
    }
    
    public var sampleData: Data {
      .init()
    }
    
    public var task: Task {
        switch self {
        case .readRegion(let params):
          return .requestParameters(parameters: params.toParams(), encoding: JSONEncoding.default)
        }
    }
  
  public var headers: [String : String]? {
    nil
  }
}
