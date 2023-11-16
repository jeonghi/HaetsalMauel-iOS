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
  static let 구름아이콘 = Self.init("cloudIcon", in: .module, format: .image)
  static let 쓰기 = Image(systemName: "pencil")
}

// MARK: 카테고리
public extension ImageAsset {
  static let 카테고리_교육 = ImageAsset("카테고리_교육", in: .module, format: .image)
  static let 카테고리_기타 = ImageAsset("카테고리_기타", in: .module, format: .image)
  static let 카테고리_돌봄 = ImageAsset("카테고리_돌봄", in: .module, format: .image)
  static let 카테고리_수리 = ImageAsset("카테고리_수리", in: .module, format: .image)
  static let 카테고리_심부름 = ImageAsset("카테고리_심부름", in: .module, format: .image)
  static let 카테고리_이동 = ImageAsset("카테고리_이동", in: .module, format: .image)
  static let 카테고리_청소 = ImageAsset("카테고리_청소", in: .module, format: .image)
}

// MARK: 우리마을
public extension ImageAsset {
  static let 우리마을_공고 = ImageAsset("우리마을_공고", in: .module, format: .image)
  static let 우리마을_동네소식 = ImageAsset("우리마을_동네소식", in: .module, format: .image)
  static let 우리마을_자치회관 = ImageAsset("우리마을_자치회관", in: .module, format: .image)
}

// MARK: 소통
public extension ImageAsset {
  static let 소통_의견 = ImageAsset("소통_의견", in: .module, format: .image)
  static let 소통_투표 = ImageAsset("소통_투표", in: .module, format: .image)
}

// MARK: 이웃캐릭터
public extension ImageAsset {
  static let 노인 = ImageAsset("노인", in: .module, format: .image)
  static let 중장년 = ImageAsset("중장년", in: .module, format: .image)
  static let 청년 = ImageAsset("청년", in: .module, format: .image)
  static let 청소년 = ImageAsset("청소년", in: .module, format: .image)
}

// MARK: 내비게이션
public extension ImageAsset {
  static let 닫기 = ImageAsset("close", in: .module, format: .image)
  static let 지우기 = ImageAsset("arrow_back", in: .module, format: .image)
  static let 뒤로가기 = ImageAsset("chevron_back", in: .module, format: .image)
}

// MARK: 내비게이션_기타
public extension ImageAsset {
  static let 검색 = ImageAsset("검색", in: .module, format: .image)
  static let 기타_작은 = ImageAsset("기타_작은", in: .module, format: .image)
  static let 기타_큰 = ImageAsset("기타_큰", in: .module, format: .image)
  static let 햄버거 = ImageAsset("햄버거", in: .module, format: .image)
}

// MARK: 기타
public extension ImageAsset {
  static let 눈_번뜩 = ImageAsset("눈_번뜩", in: .module, format: .image)
  static let 목록 = ImageAsset("목록", in: .module, format: .image)
  static let 물음표 = ImageAsset("물음표", in: .module, format: .image)
  static let 별 = ImageAsset("별", in: .module, format: .image)
  static let 보내기 = ImageAsset("보내기", in: .module, format: .image)
  static let 불꽃 = ImageAsset("불꽃", in: .module, format: .image)
  static let 빈_하트 = ImageAsset("빈_하트", in: .module, format: .image)
  static let 설정 = ImageAsset("설정", in: .module, format: .image)
  static let 쓰레기통 = ImageAsset("쓰레기통", in: .module, format: .image)
  static let 엄지척 = ImageAsset("엄지척", in: .module, format: .image)
  static let 위치 = ImageAsset("위치", in: .module, format: .image)
  static let 말풍선 = ImageAsset("채팅", in: .module, format: .image)
  static let 펜_밑줄 = ImageAsset("펜_밑줄", in: .module, format: .image)
  static let 펜 = ImageAsset("펜", in: .module, format: .image)
}
