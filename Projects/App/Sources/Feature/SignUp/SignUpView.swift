//
//  SignUpView.swift
//  App
//
//  Created by JH Park on 2023/10/30.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import SwiftUI
import UISystem

struct SignUpView {
  
}

extension SignUpView: View {
  var body: some View {
    return VStack(spacing: 0) {
      
      guideComment
        .hLeading()
        .padding(.horizontal, 16)
        .padding(.top, 30)
      
      Spacer()
      
      textFieldVStack
      
      Spacer()
      
      nextButton
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
  }
}

extension SignUpView {
  
  private var guideComment: some View {
    Text("가입 정보를 입력해주세요.")
  }
  
  private var textFieldVStack: some View {
    VStack(spacing: 0){
      // 이메일
      
      // 비밀번호
      
      // 비밀번호 확인
      
      // 휴대폰 번호
    }
  }
  
  private var nextButton: some View {
    NavigationLink(destination: Text("프로필")){
      Button(action: {}){
        Text("다음")
      }
      .buttonStyle(PrimaryButtonStyle())
    }
  }
  
  private func containerBox<Content: View>(_ title: String, @ViewBuilder _ content: () -> Content) -> some View {
    VStack(alignment: .leading, spacing: 20){
      Text(title)
      content()
    }
  }
}

struct SignUpView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SignUpView()
    }
  }
}
