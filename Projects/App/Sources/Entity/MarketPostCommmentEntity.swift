//
//  MarketPostCommmentEntity.swift
//  App
//
//  Created by 쩡화니 on 11/29/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import EumNetwork

enum MarketPostCommmentEntity {
  
  struct Request: Codable, JSONConvertible {
    let content: String
  }
  
  struct Response: Codable, Hashable {
    let commentContent: String
    let commentId: Int64
    let createdTime: Date
    let isCommentWriter: Bool
    let isPostWriter: Bool
    let postId: Int64
    let writerInfo: WriterInfo
  }
}
