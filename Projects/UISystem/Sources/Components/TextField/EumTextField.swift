//
//  SignUpTextField.swift
//  UISystem
//
//  Created by 쩡화니 on 11/6/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import DesignSystemFoundation

public struct EumTextField: View {
  public enum Mode {
    case normal
    case email
    case password
    case confirmPassword
    case number
  }
  
  @Binding public var text: String
  public var mode: Mode
  @State public var validationText: String?
  public var isSecure: Bool?
  public var showPasswordAction: (() -> Void)?
  public var placeholder: String?
  public var validationHandler: ((String) -> Bool)?
  
  public init(text: Binding<String>, mode: Mode, validationText: String? = nil, isSecure: Bool? = nil, showPasswordAction: (() -> Void)? = nil, placeholder: String? = nil, validationHandler: ((String) -> Bool)? = nil) {
    self._text = text
    self.mode = mode
    self._validationText = State(initialValue: validationText)
    self.isSecure = isSecure
    self.showPasswordAction = showPasswordAction
    self.placeholder = placeholder
    self.validationHandler = validationHandler
  }
  
  public var body: some View {
    VStack {
      if mode == .email {
        TextField(placeholder ?? "", text: $text, onCommit: {
          if mode == .email {
            // 이메일 유효성 검사를 수행
            if let handler = validationHandler, !handler(text) {
              validationText = "잘못된 이메일 형식입니다"
            } else {
              validationText = nil
            }
          }
        })
        .textStyle(.init(font: .subR, color: .black))
        .font(.subR)
        .keyboardType(mode == Mode.number ? .numberPad : .default)
      } else {
        HStack {
          if isSecure ?? false {
            SecureField(placeholder ?? "", text: $text)
              .keyboardType(mode == Mode.number ? .numberPad : .default)
          } else {
            TextField(placeholder ?? "", text: $text)
              .keyboardType(mode == Mode.number ? .numberPad : .default)
          }
          
          if mode == .password {
            Button(action: {
              showPasswordAction?()
            }, label: {
              Image(systemName: "eye")
                .foregroundColor(.secondary)
            })
          }
        }
        .textStyle(.init(font: .subR, color: .black))
        .font(.subR)
      }
      
      if let validationText = validationText {
        Text(validationText)
          .font(.subR)
          .foregroundColor(.red)
          .hLeading()
          .padding(.leading, 5)
      }
    }
    .padding()
    .frame(maxWidth: .infinity)
    .background(
      RoundedRectangle(cornerRadius: 6)
        .stroke((validationText != nil) ? Color.red : Color(.systemgray03), lineWidth: 1)
        .background(
          RoundedRectangle(cornerRadius: 6)
            .fill(Color(.systemgray02))
        )
    )
  }
}
