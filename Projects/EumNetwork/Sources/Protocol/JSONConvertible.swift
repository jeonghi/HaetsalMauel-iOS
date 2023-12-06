//
//  JSONConvertible.swift
//  EumNetwork
//
//  Created by 쩡화니 on 11/27/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation

public protocol JSONConvertible: Encodable {
  func toJSON() -> [String: Any]
}

public extension JSONConvertible where Self: Codable {
  func toJSON() -> [String: Any] {
    do {
      let encoder = JSONEncoder()
      
      // 사용자 정의 날짜 형식 설정
      encoder.dateEncodingStrategy = .custom { (date, encoder) in
        let dateFormatter = DateFormatter()
              dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "ko_KR") // 한국 지역 설정
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 9 * 3600) // 한국 시간대 (KST)
        
        let dateStr = dateFormatter.string(from: date)
        var container = encoder.singleValueContainer()
        try container.encode(dateStr)
      }
      
      let data = try encoder.encode(self)
      let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
      guard let params = jsonObject as? [String: Any] else { return [:] }
      return params
    } catch {
      print("Error converting object to parameters: \(error)")
      return [:]
    }
  }
}
