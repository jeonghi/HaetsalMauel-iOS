//
//  ActivityTime.swift
//  App
//
//  Created by 쩡화니 on 11/28/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation

enum ActivityTime: String, CaseIterable {
  case 오전
  case 오후
  case 상관없음
}

extension ActivityTime {
  func cvtToEntityTime() -> MarketPostEntity.Slot {
    switch self {
    case .오전:
      return .am
    case .오후:
      return .pm
    case .상관없음:
      return .all
    }
  }
}
