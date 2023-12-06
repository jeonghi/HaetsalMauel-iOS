//
//  ProfileService.swift
//  App
//
//  Created by 쩡화니 on 11/27/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import EumNetwork
import Combine

protocol ProfileServiceType {
  func createProfile(_ request: ProfileEntity.Request) -> AnyPublisher<ProfileEntity.Response?, HTTPError>
  func readProfile() -> AnyPublisher<ProfileEntity.Response?, HTTPError>
  func updateProfile(_ request: ProfileEntity.Request) -> AnyPublisher<ProfileEntity.Response?, HTTPError>
}

final class ProfileService: ProfileServiceType {
  
  static var shared = ProfileService()
  let network = Network<ProfileAPI>()
  
  private init(){}
  
  func createProfile(_ request: ProfileEntity.Request) -> AnyPublisher<ProfileEntity.Response?, EumNetwork.HTTPError> {
    return network.request(.createProfile(request), responseType: ProfileEntity.Response.self)
  }
  
  func readProfile() -> AnyPublisher<ProfileEntity.Response?, EumNetwork.HTTPError> {
    return network.request(.readProfile, responseType: ProfileEntity.Response.self)
  }
  
  func updateProfile(_ request: ProfileEntity.Request) -> AnyPublisher<ProfileEntity.Response?, EumNetwork.HTTPError> {
    return network.request(.updateProfile(request), responseType: ProfileEntity.Response.self)
  }
  
}

