//
//  View+Popup.swift
//  UISystem
//
//  Created by 쩡화니 on 11/14/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import SwiftUI
import PopupView
import DesignSystemFoundation

public extension View {
  func eumPopup(isShowing: Binding<Bool>, popupContent: @escaping () -> some View) -> some View {
    self.popup(isPresented: isShowing) {
      popupContent()
        .padding(.horizontal, 16)
    } customize: {
      $0
        .isOpaque(true)
        .position(.center)
        .animation(.default)
        .closeOnTapOutside(true)
        .backgroundColor(Color.black.opacity(0.5))
    }
  }
  
  func eumActionSheet(isShowing: Binding<Bool>, buttons: [EumActionSheetButton]) -> some View {
    var buttonVStackView: some View {
      VStack {
          ForEach(Array(buttons.enumerated()), id: \.element.title) { index, btn in
              Button(action: btn.action) {
                  Text(btn.title)
                      .font(btn.font)
                      .foregroundColor(btn.color)
                      .padding(16)
                      .frame(maxWidth: .infinity)
                      .background(
                        Color(.white)
                      )
              }
              if index < buttons.count - 1 {
                  Divider() // 마지막 버튼을 제외한 모든 버튼 뒤에 디바이더 추가
              }
          }
      }
      .padding(.vertical, 12)
      .background(
          RoundedRectangle(cornerRadius: 12)
              .fill(Color.white)
      )
    }
    
    return self.popup(isPresented: isShowing) {
      buttonVStackView
        .padding(.horizontal, 16)
        .padding(.bottom, 32)
    } customize: {
      $0
        .isOpaque(true)
        .position(.bottom)
        .animation(.default)
        .closeOnTapOutside(true)
        .backgroundColor(Color.black.opacity(0.5))
    }
  }
}

public struct EumActionSheetButton {
//    public let id: UUID
    let title: String
    let font: Font
    let color: Color
    let action: () -> Void

  public init(title: String, font: Font = Font.headerB, color: Color = Color(.black), action: @escaping () -> Void) {
//        self.id = UUID()
        self.title = title
        self.font = font
        self.color = color
        self.action = action
    }
}
