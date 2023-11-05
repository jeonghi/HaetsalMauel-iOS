//
//  EnvironmentKey+Icon.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/28.
//  Copyright © 2023 com.eum. All rights reserved.
//

import Foundation
import SwiftUI

// 환경 키 만들기
private struct IconTintKey: EnvironmentKey {
  static let defaultValue: Color = Color.white
}

private struct IconSizeKey: EnvironmentKey {
  static let defaultValue: IconSize = .init(width: 24, height: 24)
}

private struct IconRenderingMode: EnvironmentKey {
  static let defaultValue: Image.TemplateRenderingMode = .template
}

extension EnvironmentValues {
  public var iconTint: Color {
    get { self[IconTintKey.self] }
    set { self[IconTintKey.self] = newValue }
  }
  
  public var iconSize: IconSize {
    get { self[IconSizeKey.self] }
    set { self[IconSizeKey.self] = newValue }
  }
  
  public var renderingMode: Image.TemplateRenderingMode {
    get { self[IconRenderingMode.self] }
    set { self[IconRenderingMode.self] = newValue }
  }
}
