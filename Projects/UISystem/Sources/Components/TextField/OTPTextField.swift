//
//  CustomTF.swift
//  UISystem
//
//  Created by 쩡화니 on 11/12/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import DesignSystemFoundation

public struct OTPTextField: View {
  var textboxColor = Color(.systemgray07)
  var code: String
  var isFilled: Bool {
    return (code.isEmpty) ? false : true
  }
  
  public init(code: String) {
    self.code = code
  }
  
  public var body: some View {
    ZStack {
      if isFilled {
        ImageAsset.햇살아이콘.toImage()
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .foregroundColor(Color(.primary))
      }
      else {
        ImageAsset.구름아이콘.toImage()
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .foregroundColor(Color(.systemgray05))
      }
    }
    .frame(width: 40, height: 40)
  }
}

#Preview {
  HStack {
    OTPTextField(code: "1")
    OTPTextField(code: "")
    OTPTextField(code: "")
    OTPTextField(code: "")
  }
}
