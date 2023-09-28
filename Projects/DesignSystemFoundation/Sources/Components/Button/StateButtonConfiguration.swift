//
//  StateButtonConfiguration.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/25.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//

import Foundation
import SwiftUI

public struct StateButtonConfigure {
  
  let fontAsset: FontAsset
  let foregroundColor: Color
  let backgroundColor: Color
  var shadow: ShadowAsset?
  
  public init(
    fontConfig: FontAsset,
    foreground: Color,
    background: Color,
    shadow: ShadowAsset? = nil
  ){
    fontAsset = fontConfig
    foregroundColor = foreground
    backgroundColor = background
    self.shadow = shadow
  }
}
