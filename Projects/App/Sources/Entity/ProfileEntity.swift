//
//  ProfileEntity.swift
//  App
//
//  Created by 쩡화니 on 11/27/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import EumNetwork

enum ProfileEntity {
  
  struct Request: Codable, JSONConvertible {
    
    let accountPassword: String
    let avatarName: AvatarName
    let introduction: String
    let nickname: String
    let townShip: String
    
    enum AvatarName: String, Codable, JSONConvertible {
        case middle = "MIDDLE"
        case old = "OLD"
        case organization = "ORGANIZATION"
        case young = "YOUNG"
        case youth = "YOUTH"
    }
  }
  
  struct Response: Codable {
    
  }
}
