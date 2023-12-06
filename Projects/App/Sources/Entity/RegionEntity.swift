//
//  RegionEntity.swift
//  App
//
//  Created by 쩡화니 on 11/27/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import EumNetwork

enum RegionEntity {
  
  struct Params: Codable, ParamsConvertible {
    let type: RegionType?
  }
  
  struct Request: Codable, JSONConvertible {

  }
  
  struct Response: Codable, Hashable {
    let name: String
    let regionId: Int64
    let parentId: Int64
    let regionType: RegionType
  }
}

enum RegionType: String, Codable {
  case 동 = "DONG"
  case 구 = "GU"
  case 시 = "SI"
}
