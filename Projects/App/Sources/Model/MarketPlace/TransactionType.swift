//
//  TransactionType.swift
//  App
//
//  Created by 쩡화니 on 11/28/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation

enum TransactionType: String, CaseIterable {
  case 도움요청 = "도움 요청"
  case 도움제공 = "도움 제공"
}

extension TransactionType {
  func cvtToEntityType() -> MarketPostEntity.TransactionType {
    switch self {
    case .도움제공:
      return .provideHelp
    case .도움요청:
      return .requestHelp
    }
  }
}
