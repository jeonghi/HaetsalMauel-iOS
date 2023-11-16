//
//  PayPasswordKeyPadView.swift
//  App
//
//  Created by 쩡화니 on 11/9/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import DesignSystemFoundation
import UISystem

struct PayPasswordKeyPadView: View {
  
  @State var accountNumber: String = ""
  @State var amount: Int64 = 0
  
    var body: some View {
      VStack(spacing: 20) {
        VStack(spacing: 10) {
          Text("햇살 보내기")
            .font(.headerB)
            .foregroundColor(Color(.black))
          Text("이웃에게 햇살을 보내요")
            .font(.subR)
            .foregroundColor(Color(.systemgray07))
        }
        
        VStack {
          TextField("계좌번호", text: $accountNumber)
          TextField("갯수", text: $accountNumber)
        }
        
        VStack(spacing: 5) {
          Button(action: {}){
            Text("다음")
          }
          .buttonStyle(PrimaryButtonStyle())
          
          Button(action: {}){
            Text("취소")
          }
          .buttonStyle(SecondaryButtonStyle())
        }
        
      }
      .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 12)
          .fill(Color.white)
      )
    }
}

#Preview {
    PayPasswordKeyPadView()
}
