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
  struct Request: Codable, ParamsConvertible {
    let si: Int64?
    let gu: Int64?
  }
}
