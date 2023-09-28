//
//  IconLabel.swift
//  UISystem
//
//  Created by JH Park on 2023/09/28.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import DesignSystemFoundation

struct IconLabel: View {
  
  let leftIcon: Icon?
  let text: String
  let rightIcon: Icon?
  
  init(leftIcon: Icon? = nil, text: String, rightIcon: Icon? = nil) {
    self.leftIcon = leftIcon
    self.text = text
    self.rightIcon = rightIcon
  }
  
  var body: some View {
    HStack {
      leftIcon
      Text(text)
      rightIcon
    }
  }
}

struct IconLabel_Previews: PreviewProvider {
  static var previews: some View {
    IconLabel(leftIcon: .pencil ,text: "라벨", rightIcon: .filledStar)
  }
}
