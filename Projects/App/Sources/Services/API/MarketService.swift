//
//  MarketService.swift
//  App
//
//  Created by 쩡화니 on 11/27/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import EumNetwork
import Combine

protocol MarketServiceType {
  /// 포스트
  func createPost(_ request: JSONConvertible) -> AnyPublisher<MarketPostEntity.Response?, HTTPError>
  func readPosts(_ params: MarketPostEntity.Filter) -> AnyPublisher<[MarketPostEntity.Response]?, HTTPError>
  func readPost(_ postId: Int64) -> AnyPublisher<MarketPostEntity.Response?, HTTPError>
  func deletePost(_ postId: Int64) -> AnyPublisher<Box?, HTTPError>
  func updatePostStatus(_ postId: Int64, _ body: MarketPostEntity.UpdateStatusRequest) -> AnyPublisher<Box?, HTTPError>
  /// 신청 관련
  func createApply(_ postId: Int64, _ body: MarketPostApplicationEntity.Request) -> AnyPublisher<Box?, HTTPError>
  func readApplies(_ postId: Int64) -> AnyPublisher<[MarketPostApplicationEntity.Response]?, HTTPError>
  /// 댓글 관련
  func createComment(_ postId: Int64, _ body: MarketPostCommmentEntity.Request) -> AnyPublisher<Box?, HTTPError>
  func deleteComment(_ postId: Int64, _ commentId: Int64) -> AnyPublisher<Box?, HTTPError>
  /// 지원목록
  func readMyApplyList() -> AnyPublisher<[MarketPostEntity.Response]?, HTTPError>
  func readMyPostList() -> AnyPublisher<[MarketPostEntity.Response]?, HTTPError>
  func readMyScrapList() -> AnyPublisher<[MarketPostEntity.Response]?, HTTPError>
}

final class MarketService: MarketServiceType {
  
  static var shared = MarketService()
  let network = Network<MarketAPI>()
  
  private init(){}
  
  /// 포스트
  func createPost(_ request: EumNetwork.JSONConvertible) -> AnyPublisher<MarketPostEntity.Response?, EumNetwork.HTTPError> {
    return network.request(.createPost(request), responseType: MarketPostEntity.Response.self)
  }
  
  func readPosts(_ params: MarketPostEntity.Filter) -> AnyPublisher<[MarketPostEntity.Response]?, EumNetwork.HTTPError> {
    return network.request(.readPosts(params), responseType: [MarketPostEntity.Response].self)
  }
  
  func readPost(_ postId: Int64) -> AnyPublisher<MarketPostEntity.Response?, HTTPError> {
    return network.request(.readPost(postId), responseType: MarketPostEntity.Response.self)
  }
  func deletePost(_ postId: Int64) -> AnyPublisher<Box?, HTTPError> {
    return network.request(.deletePost(postId), responseType: Box.self)
  }
  func updatePostStatus(_ postId: Int64, _ body: MarketPostEntity.UpdateStatusRequest) -> AnyPublisher<Box?, HTTPError> {
    return network.request(.updatePostStatus(postId, body), responseType: Box.self)
  }
  /// 신청 관련
  func createApply(_ postId: Int64, _ body: MarketPostApplicationEntity.Request) -> AnyPublisher<Box?, HTTPError> {
    return network.request(.createApply(postId, body), responseType: Box.self)
  }
  
  func readApplies(_ postId: Int64) -> AnyPublisher<[MarketPostApplicationEntity.Response]?, HTTPError> {
    return network.request(.readApplies(postId), responseType: [MarketPostApplicationEntity.Response].self)
  }
  
  /// 댓글 관련
  func createComment(_ postId: Int64, _ body: MarketPostCommmentEntity.Request) -> AnyPublisher<Box?, HTTPError> {
    return network.request(.createPostComment(postId, body), responseType: Box.self)
  }
  
  func deleteComment(_ postId: Int64, _ commentId: Int64) -> AnyPublisher<Box?, HTTPError> {
    return network.request(.deletePostComment(postId, commentId), responseType: Box.self)
  }
  
  func readMyPostList() -> AnyPublisher<[MarketPostEntity.Response]?, HTTPError> {
    return network.request(.readMyPosts, responseType: [MarketPostEntity.Response].self)
  }
  func readMyApplyList() -> AnyPublisher<[MarketPostEntity.Response]?, HTTPError> {
    return network.request(.readMyApplies, responseType: [MarketPostEntity.Response].self)
  }
  func readMyScrapList() -> AnyPublisher<[MarketPostEntity.Response]?, HTTPError> {
    return network.request(.readMyScraps, responseType: [MarketPostEntity.Response].self)
  }
}
