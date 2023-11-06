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
      RoundedRectangle(cornerRadius: 16)
        .fill(isEnabled ? Color(.buttonDefaultBackground) : Color(.buttonDisable))
        .aspectRatio(343/60, contentMode: .fit)
        .frame(maxWidth: .infinity)
      configuration.label
        .font(.titleB)
        .foregroundColor(isEnabled ? Color(.white) : Color(.white)) // 버튼의 텍스트 색상을 지정합니다.
    }
    .opacity(configuration.isPressed ? 0.5 : 1)  // Changes opacity when button is pressed
  }
}
