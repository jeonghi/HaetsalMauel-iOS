//
//  MarketAPI.swift
//  EumNetwork
//
//  Created by 쩡화니 on 11/27/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import Moya
import Combine

public enum MarketAPI {
  case readPosts(ParamsConvertible)
  case createPost(JSONConvertible)
  case readPost(Int64)
  case updatePost(Int64, JSONConvertible)
  case deletePost(Int64)
}

extension MarketAPI: TargetType {
  
    public var baseURL: URL {
        return URL(string: "\(Constants.baseUrl)/post/market")!
    }
    
    public var path: String {
        switch self {
        case .readPosts, .createPost:
          return ""
        case .readPost(let postId), .deletePost(let postId), .updatePost(let postId, _):
          return "/\(postId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .readPost, .readPosts:
          return .get
        case .createPost:
          return .post
        case .updatePost:
          return .put
        case .deletePost:
          return .delete
        }
    }
    
    public var sampleData: Data {
      .init()
    }
    
    public var task: Task {
        switch self {
        case .readPosts(let params):
          return .requestParameters(parameters: params.toParams(), encoding: JSONEncoding.default)
        case .createPost(let request):
          return .requestJSONEncodable(request)
        case .readPost:
          return .requestPlain
        case .updatePost(_, let request):
          return .requestJSONEncodable(request)
        case .deletePost:
          return .requestPlain
        }
    }
  
  public var headers: [String : String]? {
    nil
  }
}
