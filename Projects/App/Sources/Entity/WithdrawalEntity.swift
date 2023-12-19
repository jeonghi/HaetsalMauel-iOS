//
//  WithdrawalEntity.swift
//  App
//
//  Created by 쩡화니 on 12/13/23.
//  Copyright © 2023 com.haetsal. All rights reserved.
//

import Foundation
import EumNetwork

enum WithdrawalEntity {
  struct Request: Codable, JSONConvertible{
    let categoryId: Int64
    let reason: String
  }
  
  struct ReasonCategory: Codable, Hashable{
    let categoryId: Int64
    let content: String
  }
}
