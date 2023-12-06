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
  case readRegions(ParamsConvertible)
  case readSubRegions(_ regionId: Int64)
}

extension RegionAPI: TargetType {
  
    public var baseURL: URL {
      return URL(string: "\(Constants.baseUrl)/regions")!
    }
    
    public var path: String {
        switch self {
        case .readRegions:
          return ""
        case .readSubRegions(let regionId):
          return "/\(regionId)/subregions"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .readRegions:
          return .get
        case .readSubRegions:
          return .get
        }
    }
    
    public var sampleData: Data {
      .init()
    }
    
    public var task: Task {
        switch self {
        case .readRegions(let params):
          return .requestParameters(parameters: params.toParams(), encoding: URLEncoding.queryString)
        case .readSubRegions:
          return .requestPlain
        }
    }
  
  public var headers: [String : String]? {
    nil
  }
}
