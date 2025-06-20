//
//  PrimaryButtonStyle.swift
//  UISystem
//
//  Created by JH Park on 2023/10/14.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import DesignSystemFoundation
import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) var isEnabled
  
  public init(){}
  
  // 버튼 스타일을 정의하는 메서드
  public func makeBody(configuration: Self.Configuration) -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 12)
        .fill(isEnabled ? Color(.buttonDefaultBackground) : Color(.buttonDisable))
        .frame(height: 60)
      configuration.label
        .font(.headerB)
        .foregroundColor(isEnabled ? Color(.white) : Color(.white)) // 버튼의 텍스트 색상을 지정합니다.
    }
    .frame(maxWidth: .infinity)
    .opacity(configuration.isPressed ? 0.5 : 1)  // Changes opacity when button is pressed
  }
}

public struct SecondaryButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) var isEnabled
  
  public init(){}
  
  // 버튼 스타일을 정의하는 메서드
  public func makeBody(configuration: Self.Configuration) -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 12)
        .fill(isEnabled ? Color(.systemgray02) : Color(.systemgray02))
        .frame(height: 60)
      configuration.label
        .font(.headerB)
        .foregroundColor(isEnabled ? Color(.systemgray07) : Color(.systemgray07)) // 버튼의 텍스트 색상을 지정합니다.
    }
    .frame(maxWidth: .infinity)
    .opacity(configuration.isPressed ? 0.5 : 1)  // Changes opacity when button is pressed
  }
}

