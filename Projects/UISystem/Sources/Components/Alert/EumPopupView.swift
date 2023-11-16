//
//  EumAlert.swift
//  UISystem
//
//  Created by 쩡화니 on 11/14/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import DesignSystemFoundation

public struct EumPopupView {
  let title: String?
  let subtitle: String?
  let type: PopupType
  let firstButtonName: String?
  let secondButtonName: String?
  var firstButtonAction: (() -> Void)?
  var secondButtonAction: (() -> Void)?
  
  public enum PopupType {
    case oneLineOneButton
    case oneLineTwoButton
    case twoLineTwoButton
    case twoLineOneButton
  }
  
  public init(title: String? = nil, subtitle: String? = nil, type: PopupType, firstButtonName: String? = nil, secondButtonName: String? = nil, firstButtonAction: (() -> Void)? = nil, secondButtonAction: (() -> Void)? = nil) {
    self.title = title
    self.subtitle = subtitle
    self.type = type
    self.firstButtonName = firstButtonName
    self.secondButtonName = secondButtonName
    self.firstButtonAction = firstButtonAction
    self.secondButtonAction = secondButtonAction
  }
}

extension EumPopupView: View {
  public var body: some View {
    VStack(spacing: 20) {
      VStack(spacing: 10){
        if let title = self.title {
          Text(title)
            .foregroundColor(Color(.black))
            .font(.headerB)
        }
        if let subtitle = self.subtitle {
          Text(subtitle)
            .foregroundColor(Color(.systemgray07))
            .font(.subR)
            .multilineTextAlignment(.center)
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 12)
      
      VStack(spacing: 5) {
        if let firstButtonName = self.firstButtonName {
          Button(action: {firstButtonAction?()}){
            Text(firstButtonName)
          }
          .buttonStyle(PrimaryButtonStyle())
        }
        
        if let secondButtonName = self.secondButtonName {
          Button(action: {secondButtonAction?()}){
            Text(secondButtonName)
          }
          .buttonStyle(SecondaryButtonStyle())
        }
      }
      .padding(.horizontal, 8)
    }
    .padding(.vertical, 12)
    .background(
      RoundedRectangle(cornerRadius: 12, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
        .fill(Color(.white))
    )
  }
}

#Preview {
  return VStack{ 
    EumPopupView(title: "댓글 수정", subtitle: "sub", type: .twoLineTwoButton, firstButtonName: "확인", secondButtonName: "취소", firstButtonAction: {print("위")}, secondButtonAction: {print("아래")})
    EumPopupView(title: "댓글 수정", subtitle: "sub", type: .twoLineTwoButton, firstButtonName: "확인", secondButtonName: "취소", firstButtonAction: {print("위")}, secondButtonAction: {print("아래")})
  }
}
