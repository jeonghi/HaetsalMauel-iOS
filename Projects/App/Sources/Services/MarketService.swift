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
  func createPost(_ request: JSONConvertible) -> AnyPublisher<MarketPostEntity.Response?, HTTPError>
  func readPosts(_ params: ParamsConvertible) -> AnyPublisher<[MarketPostEntity.Response]?, HTTPError>
}

final class MarketService: MarketServiceType {
  
  static var shared = MarketService()
  let network = Network<MarketAPI>()
  
  private init(){}
  
  func createPost(_ request: EumNetwork.JSONConvertible) -> AnyPublisher<MarketPostEntity.Response?, EumNetwork.HTTPError> {
    return network.request(.createPost(request), responseType: MarketPostEntity.Response.self)
  }
  
  func readPosts(_ params: EumNetwork.ParamsConvertible) -> AnyPublisher<[MarketPostEntity.Response]?, EumNetwork.HTTPError> {
    return network.request(.readPosts(params), responseType: [MarketPostEntity.Response].self)
  }
}
