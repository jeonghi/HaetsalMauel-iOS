//
//  RegionService.swift
//  App
//
//  Created by 쩡화니 on 11/27/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import EumNetwork
import Combine

protocol RegionServiceType {
  func readRegions(_ params: RegionEntity.Params) -> AnyPublisher<[RegionEntity.Response]?, HTTPError>
  func readSubRegions(_ regionId: Int64) -> AnyPublisher<[RegionEntity.Response]?, HTTPError>
}

final class RegionService: RegionServiceType {
  
  static var shared = RegionService()
  let network = Network<RegionAPI>()
  
  private init(){}
  
  func readRegions(_ params: RegionEntity.Params) -> AnyPublisher<[RegionEntity.Response]?, HTTPError> {
    return network.request(.readRegions(params), responseType: [RegionEntity.Response].self)
  }
  
  func readSubRegions(_ regionId: Int64) -> AnyPublisher<[RegionEntity.Response]?, HTTPError> {
    return network.request(.readSubRegions(regionId), responseType: [RegionEntity.Response].self)
  }
}
