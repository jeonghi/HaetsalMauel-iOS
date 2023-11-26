//
//  CategoryButton.swift
//  UISystem
//
//  Created by 쩡화니 on 11/15/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import DesignSystemFoundation

// MARK: Properties
public struct CategoryButton {
  let iconImage: ImageAsset
  let text: String
  var isSelected: Bool = false
  
  public init(_ iconImage: ImageAsset, _ text: String, _ isSelected: Bool) {
    self.iconImage = iconImage
    self.text = text
    self.isSelected = isSelected
  }
}

// MARK: Layout
extension CategoryButton: View {
  public var body: some View {
    
      RoundedRectangle(cornerRadius: 10)
        .fill(isSelected ? Color(.primaryLight) : Color(.systemgray02))
        .background(
          RoundedRectangle(cornerRadius: 10)
            .stroke(isSelected ? Color(.primary) : Color(.systemgray02), lineWidth: 3)
        )
        .aspectRatio(1/1, contentMode: .fit)
        .overlay(
          label
        )
  }
}

// MARK: Component init
extension CategoryButton {
  private var label: some View {
    CategoryLabel(
      icon: iconImage,
      iconBackgroundColor: isSelected ? Color(.white).opacity(0.5) : Color(.white).opacity(0.5),
      text: text,
      textColor: isSelected ? Color(.primary) : Color(.black)
    )
  }
}

#Preview {
  VStack {
    CategoryButton(.카테고리_기타, "기타", true)
    CategoryButton(.카테고리_기타, "기타", false)
  }
}
