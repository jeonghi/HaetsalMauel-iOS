//
//  IconStyle.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/28.
//  Copyright © 2023 com.eum. All rights reserved.
//

import Foundation
import SwiftUI

public struct IconStyle {
  public var iconSize: IconSize? = nil
  public var tintColor: Color? = nil
  public var opacity: Double? = nil
  
  public init(iconSize: IconSize? = nil, tintColor: Color? = nil, opacity: Double? = nil) {
    self.iconSize = iconSize
    self.tintColor = tintColor
    self.opacity = opacity
  }
}
