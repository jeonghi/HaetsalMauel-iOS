//
//  ChatTextInputFiled.swift
//  App
//
//  Created by 쩡화니 on 11/30/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import UISystem
import DesignSystemFoundation

struct ChatTextInputField: View {
  @State var text: String = ""
  let senderAction: ((String) -> Void)?
  var body: some View {
    HStack(alignment: .bottom){
      
      TextField("", text: $text, prompt: Text("댓글을 입력해주세요").font(.subR).foregroundColor(Color(.systemgray07)), axis: .vertical)
        .disableAutocorrection(true)
        .font(.subR)
        .lineLimit(5)
        .foregroundColor(Color(.black))
        .textFieldStyle(.plain)
        .keyboardType(.default)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 10)
        .padding(.vertical, 12)
        .background(
          RoundedRectangle(cornerRadius: 10)
            .fill(Color(.systemgray02))
        )
      
      Button(action: {
        senderAction?(text)
        text = ""
      }){
        ImageAsset.보내기.toImage()
          .resizable()
          .renderingMode(.template)
          .scaledToFit()
          .frame(height: 24)
          .foregroundColor(Color(.systemgray07))
          .padding(.vertical, 7)
      }
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 8)
    .frame(maxWidth: .infinity)
    .background(
      Rectangle()
        .fill(Color(.white))
    )
    .hideKeyboardWhenTappedAround()
  }
}

#Preview {
  return ChatTextInputField(senderAction: {print($0)})
}
