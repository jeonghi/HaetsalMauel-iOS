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
    case yyyyMMdd = "yyyy.MM.dd"
    case MMdd = "MM/dd"
    case hhmm = "hh:mm"
  }
  func toString(_ formatType: FormatType) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR") // 한국어 설정
    dateFormatter.dateFormat = formatType.rawValue // 원하는 형식 설정
    return dateFormatter.string(from: self)
  }
}


extension Date {
  func timeAgoString() -> String {
    
    let now = Date()
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: self, to: now)
    
    if !calendar.isDateInToday(self){
      return self.toString(.MMdd)
    }
    
    if let days = components.day, days > 0 {
      return self.toString(.MMdd)
    } else if let hours = components.hour, hours > 0 {
      return self.toString(.hhmm)
    } else if let minutes = components.minute, minutes > 1 {
      return "\(minutes)분 전"
    } else {
      return "방금 전"
    }
  }
}

extension Date {
  func formattedTimeWithAmPm() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "a h:mm"
    return dateFormatter.string(from: self)
  }
}
