//
//  RegionService.swift
//  App
//
//  Created by 쩡화니 on 11/27/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import EumNetwork

protocol RegionServiceType {
}

final class RegionService: RegionServiceType {
  
  static var shared = RegionService()
  let network = Network<RegionAPI>()
  
  private init(){}
}
