//
//  PayAccountEntity.swift
//  App
//
//  Created by 쩡화니 on 12/2/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import EumNetwork

enum PayAccountEntity {
  enum Request {
    
    struct GetAccount: Codable, JSONConvertible {
      let nickName: String
    }
    
    struct UpdatePassword: Codable, JSONConvertible {
      let currentPassword: String
      let newPassword: String
    }
    
    struct CreatePassword: Codable, JSONConvertible {
      let password: String
    }
  }
  
  struct Response: Codable, Hashable {
    let balance: Int64
    let cardName: String
  }
}
