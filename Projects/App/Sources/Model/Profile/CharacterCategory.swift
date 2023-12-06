//
//  CharacterCategory.swift
//  App
//
//  Created by 쩡화니 on 11/20/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import UISystem
import DesignSystemFoundation

enum CharacterCategory: String, CaseIterable {
  case 청소년
  case 청년
  case 중장년
  case 노년
  func cvtAssetImage() -> ImageAsset {
    switch self {
    case .청소년:
      return .청소년
    case .청년:
      return .청년
    case .중장년:
      return .중장년
    case .노년:
      return .노인
    }
  }
}
