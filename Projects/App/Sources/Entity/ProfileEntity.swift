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
  
  enum AvatarName: String, Codable, JSONConvertible {
      case middle = "MIDDLE"
      case old = "OLD"
      case organization = "ORGANIZATION"
      case young = "YOUNG"
      case youth = "YOUTH"
  }
  
  struct Request: Codable, JSONConvertible {
    
    let avatarName: AvatarName
    let introduction: String
    let nickname: String
    let regionId: Int64
  }
  
  struct Response: Codable, Hashable {
    let address: String
    let avatarPhotoURL: String
    let characterName: String
    let introduction: String?
    let levelName: String
    let nextStandard: Int64
    let nickname: String
    let profileId: Int64
    let totalSunrisePay: Int64
    let userId: Int64
  }
}
