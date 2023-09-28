//
//  StateButtonStyle.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/24.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//

import Foundation
import SwiftUI

public struct StateButtonStyle {
  
  let buttonSize: ButtonSize
  
  public init(buttonSize: ButtonSize) {
    self.buttonSize = buttonSize
  }
}

public extension StateButtonStyle {
  func style(_ config: StateButtonConfigure, for state: ButtonState) -> StateButtonStyle {
    return self
  }
}

extension StateButtonStyle: ButtonStyle {
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
  }
}
