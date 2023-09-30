//
//  TextStyle.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/29.
//  Copyright © 2023 com.eum. All rights reserved.
//

import Foundation
import SwiftUI

public struct TextStyle {
  public var font: Font
  public var color: Color
  public var opacity: CGFloat?
  
  public init(font: Font, color: Color, opacity: CGFloat? = 1.0) {
    self.font = font
    self.color = color
    self.opacity = opacity
  }
}
