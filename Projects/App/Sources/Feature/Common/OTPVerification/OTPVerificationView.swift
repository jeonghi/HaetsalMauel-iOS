//
//  OTPVerificationView.swift
//  App
//
//  Created by 쩡화니 on 11/12/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import UISystem

struct OTPVerificationView: View {
  
  var placeholder: String
  @Binding var OTPdata: String
  
  init(placeholder: String = "", _ data: Binding<String>) {
    self.placeholder = placeholder
    self._OTPdata = data
  }
  
  var body: some View {
    VStack(spacing: 0) {
      
      VStack(spacing: 60) {
        
        Text("\(placeholder)")
          .multilineTextAlignment(.leading)
          .font(.titleB)
          .hLeading()
          .padding()
        
        HStack(spacing: UIScreen.main.bounds.size.width/25){
          ForEach(0..<4, id: \.self){ index in
            OTPTextField(code: getCodeAtIndex(index: index))
          }
        }
      }
      .vTop()
      
      OTPCustomKeyboardView($OTPdata)
        .vBottom()
    }
  }
}
extension OTPVerificationView {
  func getCodeAtIndex(index: Int) -> String {
    if OTPdata.count > index {
      let start = OTPdata.startIndex
      let current = OTPdata.index(start, offsetBy: index)
      return String(OTPdata[current])
    }
    return ""
  }
}

#Preview {
  @State var data: String = "1"
  return OTPVerificationView(placeholder: "카드 보안을 위해 비밀번호를 설정해주세요.", $data)
}
