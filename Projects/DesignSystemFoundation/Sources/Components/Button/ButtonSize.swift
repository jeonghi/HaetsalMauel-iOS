//
//  ButtonSize.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/25.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//

import Foundation
import SwiftUI

// 버튼 사이즈 정보를 담고 있는 객체
public struct ButtonSize {
  var iconStyle: IconStyle
  var fontSize: CGFloat
  var minWidth: CGFloat?
  var minHeight: CGFloat?
  var insets: EdgeInsets?
  public init(iconStyle: IconStyle, fontSize: CGFloat, minWidth: CGFloat? = nil, minHeight: CGFloat? = nil, insets: EdgeInsets? = nil) {
    self.iconStyle = iconStyle
    self.fontSize = fontSize
    self.minWidth = minWidth
    self.minHeight = minHeight
    self.insets = insets
  }
}
