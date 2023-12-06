//
//  MarketPostApplicationEntity.swift
//  App
//
//  Created by 쩡화니 on 11/29/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import EumNetwork

enum MarketPostApplicationEntity {
  struct Request: JSONConvertible, Codable {
    let introduction: String
  }
  
  struct Response: Codable, Equatable, Hashable {
    var applicantAddress: String
    var applicantId: Int64
    var applicantNickName: String
    var applyId: Int64
    var createdTime: Date
    var introduction: String
    var isAccepted: Bool
    var postId: Int64
    var avatarPhotoUrl: String
  }
}
