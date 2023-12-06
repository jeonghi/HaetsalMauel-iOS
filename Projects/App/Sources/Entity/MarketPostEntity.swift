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
  
  struct Request: JSONConvertible, Codable {
    let category: MPCategory
    let content: String
    let location: String
    let marketType: TransactionType
    let maxNumOfPeople: Int32
    let slot: Slot
    let startTime: Date
    let title: String
    let volunteerTime: Int32
  }
  
  struct UpdateStatusRequest: JSONConvertible, Codable {
    let status: Status
  }
  
  struct Response: Codable, Hashable {
    
//    
//    static func == (lhs: MarketPostEntity.Response, rhs: MarketPostEntity.Response) -> Bool {
//      lhs.postId == rhs.postId
//    }
    
    let isWriter: Bool?
    let isScrap: Bool?
    let isApplicant: Bool?
    let postId: Int64 //
    let category: MPCategory //
    let commentCount: Int
    let content: String?
    let commentResponses: [MarketPostCommmentEntity.Response]?
    let createdDate: Date //
    let location: String //
    let marketType: TransactionType //
    let pay: Int64 //
    let status: Status //
    let title: String //
    let currentApplicant: Int?
    let maxNumOfPeople: Int?
    let volunteerTime: Int //
    let writerInfo: WriterInfo?
  }
  
  struct Filter: ParamsConvertible, Codable, Equatable {
    let search: String?
    let category: MPCategory?
    let type: TransactionType?
    let status: Status?
    
    init(search: String? = nil, category: MPCategory? = nil, type: TransactionType? = nil, status: Status? = nil) {
      self.search = search
      self.category = category
      self.type = type
      self.status = status
    }
  }
  
  enum TransactionType: String, Codable, Equatable {
    case provideHelp = "PROVIDE_HELP"
    case requestHelp = "REQUEST_HELP"
  }
  
  enum Slot: String, Codable, Equatable {
    case all = "ALL"
    case am = "AM"
    case pm = "PM"
  }
  
  enum Status: String, Codable, Equatable {
    case recruiting = "RECRUITING"
    case recruitmentCompleted = "RECRUITMENT_COMPLETED"
    case transactionCompleted = "TRANSACTION_COMPLETED"
  }
}

struct WriterInfo: Codable, Equatable, Hashable {
  let address: String
  let avatarPhotoUrl: String
  let nickName: String
  let userId: Int64
}
