//
//  View+IconStyle.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/29.
//  Copyright © 2023 com.eum. All rights reserved.
//

import Foundation
import SwiftUI

extension View where Self == Icon {
  public func iconStyle(_ style: IconStyle) -> some View {
    var view = self
    if let tint = style.tintColor {
      view = view.environment(\.iconTint, tint) as! Icon
    }
    if let size = style.iconSize {
      view = view.environment(\.iconSize, size) as! Icon
    }
    view = view.environment(\.renderingMode, .template) as! Icon // assuming you want to use template mode when styling
    if let opacity = style.opacity {
      view = view.opacity(opacity) as! Icon
    }
    return view
  }
}
