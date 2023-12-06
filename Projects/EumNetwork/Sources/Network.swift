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
  
  private static func makeProvider() -> MoyaProvider<T> {
    var plugins: [PluginType] = [MoyaHeaderTokenPlugin.shared]
#if(DEBUG)
    plugins.append(MoyaLoggerPlugin.shared)
#endif
    return MoyaProvider<T>(plugins: plugins)
  }
  
}
  
public extension Network {
  func request<R>(_ target: T, responseType: R.Type) -> AnyPublisher<R?, HTTPError> where R: Codable {
    return provider.requestPublisher(target)
      .tryMap { response -> R? in
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let dateFormatter = DateFormatter()
              dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "ko_KR") // 한국 지역 설정
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // 날짜 문자열이 특정 시간대를 포함하는 경우 조정
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        ///
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
