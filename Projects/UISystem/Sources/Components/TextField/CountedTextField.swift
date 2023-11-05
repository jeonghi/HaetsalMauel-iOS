//
//  CountedTextField.swift
//  UISystem
//
//  Created by JH Park on 2023/09/30.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI

public struct CountedTextField: View {
  @Binding var text: String
  
  let placeHolder: String
  let maxLength: Int
  
  public init(text: Binding<String>, placeHolder: String = "", maxLength: Int = 255) {
    self._text = text
    self.placeHolder = placeHolder
    self.maxLength = maxLength
  }
  
  public var body: some View {
    VStack(spacing: 5) {
      TextField(placeHolder, text: $text)
        .onChange(of: text) { newValue in
          if text.count > maxLength {
            text = String(text.prefix(maxLength))
          }
          else {
            text = text
          }
        }
        .padding()
        .background(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color.gray, lineWidth: 1)
        )
      HStack{
        Spacer()
        Text("\(text.count)/\(maxLength)")
          .font(.footnote)
          .foregroundColor(.gray)
      }
    }
  }
}

struct CountedTextField_Previews: PreviewProvider {
  @State static var sampleText = "aa"
  
  static var previews: some View {
    CountedTextField(text: $sampleText, placeHolder: "입력해주세요.")
      .padding()
  }
}
