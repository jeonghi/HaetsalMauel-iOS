//
//  CommunityPostDescription.swift
//  App
//
//  Created by 쩡화니 on 11/15/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation

struct CommunityPostDescription: Identifiable, Equatable {
  var id: String
  var title: String
  var locationName: String
  var createdAt: Date
  var good: Int
  var comment: Int
}
