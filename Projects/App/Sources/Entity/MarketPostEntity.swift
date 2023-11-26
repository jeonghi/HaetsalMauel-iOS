//
//  MarketPostEntity.swift
//  App
//
//  Created by 쩡화니 on 11/27/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import EumNetwork

enum MarketPostEntity {
  
  struct Response: Codable {
    let category: String
    let commentCount: Int
    let createdDate: Date
    let location: String
    let marketType: MarketType
    let pay: Int64
    let postId: Int64
    let status: Status
    let title: String
    let volunteerTime: Int
  }
  
  enum MarketType: String, Codable {
    case all = "ALL"
    case provideHelp = "PROVIDE_HELP"
    case requestHelp = "REQUEST_HELP"
  }
  
  enum Status: String, Codable {
    case all = "ALL"
    case recruiting = "RECRUITING"
    case recruitmentCompleted = "RECRUITMENT_COMPLETED"
    case transactionCompleted = "TRANSACTION_COMPLETED"
  }
}
