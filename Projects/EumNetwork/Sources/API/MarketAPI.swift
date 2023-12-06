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
  case updatePostStatus(_ postId: Int64, _ body: JSONConvertible)
  
  case createApply(_ postId: Int64, _ body: JSONConvertible)
  case readApplies(_ postId: Int64) //지원목록조회
  case deleteApply(_ postId: Int64, _ applyId: Int64) //지원취소
  case updateApply(_ postId: Int64, _ applyId: Int64)
  
  case createPostComment(_ postId: Int64, _ body: JSONConvertible) // 게시글 댓글 작성
  case deletePostComment(_ postId: Int64, _ commentId: Int64) // 게시글 댓글 삭제
  
  case readMyApplies
  case readMyPosts
  case readMyScraps
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
        case .readApplies(let postId), .createApply(let postId, _):
          return "/\(postId)/apply"
        case .deleteApply(let postId, let applyId), .updateApply(let postId, let applyId):
          return "/\(postId)/apply/\(applyId)"
        case .createPostComment(let postId, _):
          return "/\(postId)/comment"
        case .deletePostComment(let postId, let commentId):
          return "/\(postId)/comment/\(commentId)"
        case .updatePostStatus(let postId, _):
          return "/\(postId)/status"
        case .readMyPosts:
          return "/user-activity/postlist"
        case .readMyScraps:
          return "/user-activity/scrap"
        case .readMyApplies:
          return "/user-activity/apply"
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
        case .deletePostComment:
          return .delete
        case .createPostComment:
          return .post
        case .readMyPosts, .readMyScraps, .readMyApplies:
          return .get
        case .updatePostStatus:
          return .put
        }
    }
    
    public var sampleData: Data {
      .init()
    }
    
    public var task: Task {
        switch self {
        case .readPosts(let params):
          return .requestParameters(parameters: params.toParams(), encoding: URLEncoding.default)
        case .createPost(let request):
          return .requestParameters(parameters: request.toJSON(), encoding: JSONEncoding.default)
        case .readPost:
          return .requestPlain
        case .updatePost(_, let request):
          return .requestParameters(parameters: request.toJSON(), encoding: JSONEncoding.default)
        case .deletePost:
          return .requestPlain
        case .createApply(_, let request):
          return .requestParameters(parameters: request.toJSON(), encoding: JSONEncoding.default)
        case .deleteApply(_, _):
          return .requestPlain
        case .updateApply(_, _):
          return .requestPlain
        case .readApplies:
          return .requestPlain
        case .createPostComment(_, let request):
          return .requestParameters(parameters: request.toJSON(), encoding: JSONEncoding.default)
        case .deletePostComment:
          return .requestPlain
        case .readMyPosts, .readMyScraps, .readMyApplies:
          return .requestPlain
        case .updatePostStatus(_, let request):
          return .requestParameters(parameters: request.toJSON(), encoding: JSONEncoding.default)
        }
    }
  
  public var headers: [String : String]? {
    nil
  }
}
