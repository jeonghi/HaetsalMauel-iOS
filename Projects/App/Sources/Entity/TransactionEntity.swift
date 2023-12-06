//
//  TransactionEntity.swift
//  App
//
//  Created by 쩡화니 on 11/29/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import EumNetwork

enum TransactionEntity {
  
  struct Params: Codable, ParamsConvertible {
    let type: TransactionType?
  }
  
  struct Request: Codable, JSONConvertible  {
    let amount: Int64
    let password: String
    let nickname: String
  }
  
  struct Response: Codable, Hashable {
    let balance: Int64?
    let cardName: String?
    let histories: [History]
  }
  
  enum TransactionType: String, Codable, Hashable {
    case 입금 = "DEPOSIT"
    case 출금 = "WITHDRAW"
  }
  
  struct History: Codable, Hashable {
    let amount: Int64
    let createdTime: Date
    let myCurrentBalance: Int64
    let opponentInfo: OpponentInfo
    let transactionType: TransactionType
  }
  
  struct OpponentInfo: Codable, Hashable {
    let cardName: String
    let nickName: String
    let avatarPhotoUrl: String
  }
}
