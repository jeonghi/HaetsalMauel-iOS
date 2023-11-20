//
//  AppService.swift
//  App
//
//  Created by 쩡화니 on 11/20/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//
import Foundation
import ComposableArchitecture

protocol AppServiceType {
  var authService: AuthService { get }
}

final class AppService: AppServiceType {
  
  // MARK: Public
  public static let shared = AppService()
  
  // MARK: Private
  var authService: AuthService
  private init(){
    authService = AuthService.shared
  }
}
extension DependencyValues {
    var appService: AppService {
        get { self[AppService.self] }
        set { self[AppService.self] = newValue }
    }
}

extension AppService {
  static let live = AppService.shared
}

extension AppService: DependencyKey {
    static let liveValue = AppService.live
}
