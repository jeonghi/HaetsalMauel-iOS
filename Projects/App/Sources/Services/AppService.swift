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
  var profileService: ProfileService { get }
  var marketService: MarketService { get }
  var regionService: RegionService { get }
  var payService: PayService { get }
  var hapticService: HapticService { get }
  var signInService: SignInService { get }
  var chatService: ChatService { get }
}

final class AppService: AppServiceType {
  
  // MARK: Public
  public static let shared = AppService()
  
  // MARK: Private
  var authService: AuthService
  var profileService: ProfileService
  var marketService: MarketService
  var regionService: RegionService
  var payService: PayService
  var hapticService: HapticService
  var signInService: SignInService
  var chatService: ChatService
  
  private init(){
    authService = AuthService.shared
    profileService = ProfileService.shared
    marketService = MarketService.shared
    regionService = RegionService.shared
    payService = PayService.shared
    hapticService = HapticService.shared
    signInService = SignInService.shared
    chatService = ChatService.shared
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
