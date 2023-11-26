//
//  Date+Extension.swift
//  App
//
//  Created by 쩡화니 on 11/22/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation

extension Date {
  
  enum FormatType: String {
    case yyyyMMddE = "yyyy. MM. dd. (E)"
  }
  func toString(_ formatType: FormatType) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR") // 한국어 설정
    dateFormatter.dateFormat = formatType.rawValue // 원하는 형식 설정
    return dateFormatter.string(from: self)
  }
}
