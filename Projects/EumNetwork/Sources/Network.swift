//
//  Network.swift
//  EumNetwork
//
//  Created by 쩡화니 on 11/26/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//
import Foundation
import Combine
import Moya
import CombineMoya

public struct Network<T: TargetType> {
  
  public let provider: MoyaProvider<T>
  
  public init() {
    self.provider = Network<T>.makeProvider()
  }
  
  static func makeProvider() -> MoyaProvider<T> {
    var plugins: [PluginType] = []
    #if(DEBUG)
    plugins.append(MoyaLoggerPlugin.shared)
    #endif
    return MoyaProvider<T>(plugins: plugins)
  }
  
  public func request<R>(_ target: T, responseType: R.Type) -> AnyPublisher<R?, HTTPError> where R: Codable {
    return provider.requestPublisher(target)
      .tryMap { response -> R? in
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let apiResponse = try response.map(APIResponse<R>.self, using: decoder)
        return apiResponse.data
      }
      .mapError { error in
        print(error)
        if let moyaError = error as? MoyaError {
          return HTTPError(moyaError)
        } else {
          return HTTPError.unknown
        }
      }
      .eraseToAnyPublisher()
  }
}
