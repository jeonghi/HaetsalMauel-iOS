//
//  CommunityCategory.swift
//  App
//
//  Created by JH Park on 2023/10/02.
//  Copyright © 2023 com.eum. All rights reserved.
//
import UISystem
import DesignSystemFoundation

enum MarketCategory: String, CaseIterable {
  case 이동
  case 심부름
  case 교육
  case 청소
  case 돌봄
  case 수리
  case 기타
}

extension MarketCategory {
  func cvtAssetImage() -> ImageAsset {
    switch self {
    case .이동:
      return .카테고리_이동
    case .심부름:
      return .카테고리_심부름
    case .교육:
      return .카테고리_교육
    case .청소:
      return .카테고리_청소
    case .돌봄:
      return .카테고리_돌봄
    case .수리:
      return .카테고리_수리
    case .기타:
      return .카테고리_기타
    }
  }
}
