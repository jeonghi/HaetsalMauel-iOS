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
  
  
  public init(icon: ImageAsset, iconBackgroundColor: Color = Color(.white).opacity(0.5), text: String, textFont: Font = Font.subB, textColor: Color = Color.black) {
    self.iconImage = icon
    self.iconBackgroundColor = iconBackgroundColor
    self.text = text
    self.textFont = textFont
    self.textColor = textColor
  }
}

extension CategoryLabel: View {
  public var body: some View {
    ZStack {
      VStack(spacing: 10){
        ZStack {
          iconImage.toImage()
            .resizable()
            .aspectRatio(contentMode: .fit)
            .background(iconBackgroundColor)
            .clipShape(Circle())
            .frame(maxWidth: .infinity)
        }
        .frame(width: 74, height:52)
        .scaledToFit()
        .frame(maxWidth: .infinity)
        Text(text)
          .font(textFont)
          .foregroundColor(textColor)
          .frame(width: 74, height: 21)
          .scaledToFit()
          .frame(maxWidth: .infinity)
      }
      .padding(16)
    }
    .aspectRatio(1/1, contentMode: .fit)
    .frame(maxWidth: .infinity)
  }
}

#Preview {
  VStack {
    CategoryLabel(icon: .카테고리_교육, text: "교육")
  }
}
