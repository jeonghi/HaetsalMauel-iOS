//
//  ImageAsset+Constants.swift
//  UISystem
//
//  Created by JH Park on 2023/09/25.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//

import DesignSystemFoundation
import SwiftUI

public extension ImageAsset {
  static let koreanLogo = ImageAsset("EumLogo", in: .module, format: .image)
  static let character = ImageAsset("MyCharacter", in: .module, format: .image)
  static let userBadge = ImageAsset("UserBadge", in: .module, format: .image)
  static let kakaoLogo = ImageAsset("kakaoLogo", in: .module, format: .image)
  static let localLogo = ImageAsset("localLogo", in: .module, format: .image)
  static let appleLogo = ImageAsset("appleLogo", in: .module, format: .image)
  static let biLogo = ImageAsset("BILogo", in: .module, format: .image)
  static let rightArrow = ImageAsset("RightArrow", in: .module, format: .image)
  static let check = ImageAsset("Check", in: .module, format: .image)
  static let onboardingLogo = ImageAsset("OnboardingLogo", in: .module, format: .image)
  static let setting = ImageAsset("setting", in: .module, format: .image)
  static let 홈 = ImageAsset("home", in: .module, format: .image)
  static let 햇터 = ImageAsset("translation", in: .module, format: .image)
  static let 채팅 = ImageAsset("chat", in: .module, format: .image)
  static let 소통 = ImageAsset("community", in: .module, format: .image)
  static let 우리마을 = ImageAsset("town", in: .module, format: .image)
  static let 홈fill = ImageAsset("home.fill", in: .module, format: .image)
  static let 햇터fill = ImageAsset("translation.fill", in: .module, format: .image)
  static let 채팅fill = ImageAsset("chat.fill", in: .module, format: .image)
  static let 소통fill = ImageAsset("community.fill", in: .module, format: .image)
  static let 우리마을fill = ImageAsset("town.fill", in: .module, format: .image)
  static let chevronRight = ImageAsset("chevron.right", in: .module, format: .image)
  static let babySun = Self.init("babysun", in: .module, format: .image)
  static let sun = Self.init("sun", in: .module, format: .image)
  static let cloud = Self.init("cloud", in: .module, format: .image)
  static let levelGuide = Self.init("LevelGuide", in: .module, format: .image)
  static let questionmarkCircleFill = Image(systemName: "questionmark.circle.fill")
  static let 햇살아이콘 = Self.init("sunIcon", in: .module, format: .image)
  static let 검색 = Image(systemName: "magnifyingglass")
  static let 쓰기 = Image(systemName: "pencil")
}
