//
//  CommunityCategory.swift
//  App
//
//  Created by 쩡화니 on 11/15/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import UISystem
import DesignSystemFoundation

enum CMCategory: String, CaseIterable {
  case 투표
  case 의견
  func cvtAssetImage() -> ImageAsset {
    switch self {
    case .투표:
      return .소통_투표
    case .의견:
      return .소통_의견
    }
  }
}
