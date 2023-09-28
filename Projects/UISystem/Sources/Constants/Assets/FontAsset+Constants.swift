//
//  FontAsset.swift
//  UISystem
//
//  Created by JH Park on 2023/09/25.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//

import DesignSystemFoundation

public extension FontAsset {
  static var titleB = FontAsset(.bold, size: 40, leading: .lineHeight(64))
  static var headerB = FontAsset(.bold, size: 40, leading: .lineHeight(64))
  static var largeTitleB = FontAsset(.bold, size: 40, leading: .lineHeight(64))
  static var subB = FontAsset(.bold, size: 40, leading: .lineHeight(64))
  static var captionB = FontAsset(.bold, size: 40, leading: .large)
  
  static var titleR = FontAsset(.regular, size: 40, leading: .lineHeight(64))
  static var headerR = FontAsset(.regular, size: 40, leading: .lineHeight(64))
  static var largeTitleR = FontAsset(.regular, size: 40, leading: .lineHeight(64))
  static var subR = FontAsset(.regular, size: 40, leading: .lineHeight(64))
  static var captionR = FontAsset(.regular, size: 40, leading: .lineHeight(64))
}
