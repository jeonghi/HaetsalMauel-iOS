//
//  DefaultLabel.swift
//  UISystem
//
//  Created by 쩡화니 on 11/6/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import DesignSystemFoundation

public struct DefaultLabel {
  let text: String
  let tintColor: Color
  let backgroundColor: Color
  let radius: CGFloat
  let textFont: Font
  
  public init(_ text: String, tintColor: Color = Color(.black), backgroundColor: Color = Color(.systemgray07), radius: CGFloat = 0, textFont: Font = Font.descriptionR) {
    self.text = text
    self.tintColor = tintColor
    self.backgroundColor = backgroundColor
    self.radius = radius
    self.textFont = textFont
  }
}

extension DefaultLabel: View {
  public var body: some View {
    ZStack {
      Rectangle()
        .fill(backgroundColor)
        .cornerRadius(radius, corners: .allCorners)
      Text(text)
        .font(textFont)
        .foregroundColor(tintColor)
    }
  }
}


#Preview{
  DefaultLabel("도움 요청")
    .frame(width: 55, height: 24)
}
