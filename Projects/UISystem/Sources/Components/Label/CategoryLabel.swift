//
//  CategoryLabel.swift
//  UISystem
//
//  Created by 쩡화니 on 11/6/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import DesignSystemFoundation
import SwiftUI

public struct CategoryLabel {
  
  let iconImage: ImageAsset
  var iconBackgroundColor: Color
  var text: String
  var textFont: Font
  var textColor: Color
  
  
  public init(icon: ImageAsset, iconBackgroundColor: Color = Color(.white).opacity(0.5), text: String, textFont: Font = Font.subR, textColor: Color = Color.black) {
    self.iconImage = icon
    self.iconBackgroundColor = iconBackgroundColor
    self.text = text
    self.textFont = textFont
    self.textColor = textColor
  }
}

extension CategoryLabel: View {
  public var body: some View {
    VStack(spacing: 10){
      ZStack {
        iconImage.toImage()
          .resizable()
          .aspectRatio(contentMode: .fit)
          .background(iconBackgroundColor)
          .clipShape(Circle())
          .frame(maxHeight: .infinity)
      }
      .frame(width: 74, height:52)
      Text(text)
        .font(textFont)
        .foregroundColor(textColor)
        .frame(width: 74, height: 21)
    }
  }
}

#Preview {
  VStack {
    CategoryLabel(icon: .카테고리_교육, text: "교육")
  }
}
