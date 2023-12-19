//
//  ChatAPI.swift
//  EumNetwork
//
//  Created by 쩡화니 on 12/13/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import Moya
import Combine

public enum ChatAPI {
  case readChatList(_ params: ParamsConvertible)
}

extension ChatAPI: TargetType {
  
  public var baseURL: URL {
    return URL(string: "\(Constants.baseUrl)")!
  }
  
  public var path: String {
    switch self {
    case .readChatList:
      return "/chat"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .readChatList:
      return .get
    }
  }
  
  public var sampleData: Data {
    .init()
  }
  
  public var task: Task {
    switch self {
    case .readChatList(let params):
      return .requestParameters(parameters: params.toParams(), encoding: URLEncoding.default)
    }
  }
  
  public var headers: [String : String]? {
    nil
  }
}
