//
//  IconLabel.swift
//  UISystem
//
//  Created by JH Park on 2023/09/28.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import DesignSystemFoundation

public struct IconLabel: View {
  
  let leftIcon: Icon?
  let text: String
  let textFont: Font
  let rightIcon: Icon?
  
  public init(leftIcon: Icon? = nil, _ text: String, textFont: Font = Font.subR, rightIcon: Icon? = nil) {
    self.leftIcon = leftIcon
    self.text = text
    self.textFont = textFont
    self.rightIcon = rightIcon
  }
  
  public var body: some View {
    HStack {
      leftIcon
      Text(text)
      rightIcon
    }
    .font(textFont)
  }
}



struct IconLabel_Previews: PreviewProvider {
  static var previews: some View {
    IconLabel("1")
  }
}
