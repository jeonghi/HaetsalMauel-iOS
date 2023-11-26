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
  case readPosts(_ params: ParamsConvertible)
  case createPost(_ body: JSONConvertible)
  case readPost(_ postId: Int64)
  case updatePost(_ postId: Int64, _ body: JSONConvertible)
  case deletePost(Int64)
  case createApply(_ postId: Int64)
  case readApplies(_ postId: Int64, _ applyId: Int64) //지원목록조회
  case deleteApply(_ postId: Int64, _ applyId: Int64) //지원취소
  case updateApply(_ postId: Int64, _ applyId: Int64)
}

extension MarketAPI: TargetType {
  
    public var baseURL: URL {
        return URL(string: "\(Constants.baseUrl)/market/post")!
    }
    
    public var path: String {
        switch self {
        case .readPosts, .createPost:
          return ""
        case .readPost(let postId), .deletePost(let postId), .updatePost(let postId, _):
          return "/\(postId)"
        case .createApply(let postId):
          return "/\(postId)/apply/"
        case .readApplies(let postId, let applyId), .deleteApply(let postId, let applyId), .updateApply(let postId, let applyId):
          return "/\(postId)/apply/\(applyId)"
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
        case .createApply:
          return .post
        case .readApplies:
          return .get
        case .deleteApply:
          return .delete
        case .updateApply:
          return .patch
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
        case .createApply(_):
          return .requestPlain
        case .deleteApply(_, _):
          return .requestPlain
        case .updateApply(_, _):
          return .requestPlain
        case .readApplies(_, _):
          return .requestPlain
        }
    }
  
  public var headers: [String : String]? {
    nil
  }
}
