//
//  Date+Extension.swift
//  UISystem
//
//  Created by 쩡화니 on 11/6/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation

extension Date {
  func timeAgoString() -> String {
    let now = Date()
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day, .month, .year], from: self, to: now)
    
    if let years = components.year, years > 0 {
      return "\(years)년"
    } else if let months = components.month, months > 0 {
      return "\(months)달"
    } else if let days = components.day, days >= 30 {
      let numMonths = days / 30
      return "\(numMonths)달"
    } else if let days = components.day, days > 0 {
      return "\(days)일"
    } else {
      return "방금"
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
