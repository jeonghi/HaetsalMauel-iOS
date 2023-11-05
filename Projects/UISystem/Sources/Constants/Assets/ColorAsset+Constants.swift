//
//  ColorAsset+Constants.swift
//  UISystem
//
//  Created by JH Park on 2023/09/25.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//

import DesignSystemFoundation

public extension ColorAsset {
  
  static let primary = ColorAsset(hex: "#FFA339")
  static let secondary = ColorAsset(hex: "#FF9F2F")
  static let white = ColorAsset(hex: "#FFFFFF")
  
  /// systemgray
  static let systemgray07 = ColorAsset(hex: "#8E8E93")
  static let systemgray05 = ColorAsset(hex: "#C7C7CC")
  
  /// grayscale
  static let grayF7 = ColorAsset(hex: "#F2F2F7")
  static let gray07 = ColorAsset(hex: "#8E8E93")
  static let gray06 = ColorAsset(hex: "#AEAEB2")
  static let gray38 = ColorAsset(hex: "#263238")
  static let grayA3 = ColorAsset(hex: "#7E93A3")
  static let grayF4 = ColorAsset(hex: "#E8EDF4")
  
  /// button
  static let buttonDefaultBackground = deepBlue
  static let buttonDefaultForeground = white
  static let buttonDisable = ColorAsset(hex: "#AEAEB2")
  static let buttonOtherBackground = grayF7
  static let buttonOtherForeground = systemgray07
  
  
  /// divider
  static let divider = grayF7
  
  /// accent
  static let accent1 = ColorAsset(hex: "#E8EDF4")
  static let accent2 = ColorAsset(hex: "#7E93A3")
  static let accent3 = ColorAsset(hex: "#042D53")
  
  /// etc
  static let yellow = ColorAsset(hex: "#FEE500")
  
  /// blue
  static let deepBlue = ColorAsset(hex: "#042D53")
  static let deepSkyBlue = ColorAsset(hex: "#8FD1FF")
  static let lightSkyBlue = ColorAsset(hex: "#BCE3FE")
}
