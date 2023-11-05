//
//  TTLoginButton.swift
//  UISystem
//
//  Created by JH Park on 2023/10/11.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI

public struct TTLoginLabel: View {
  
  let provider: LoginProvider
  public init(
    _ provider: LoginProvider
  ){
    self.provider = provider
  }
  public var body: some View {
    makeLabel()
  }
}

extension TTLoginLabel {
  
  private func makeLabel() -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 10)
        .foregroundColor(backgroundColor)
      
      HStack(spacing: 10){
        iconLabel
          .foregroundColor(foregroundColor)
      }
    }
    .aspectRatio(345/52, contentMode: .fit)
    .frame(maxWidth: .infinity)
  }
  
  private var iconLabel: IconLabel {
    switch provider {
    case .apple:
      return .appleLoginLabel
    case .kakao:
      return .kakaoLoginLabel
    case .local:
      return .localLoginLabel
    }
  }
  
  private var backgroundColor: Color {
    switch provider {
    case .apple:
      return Color(.black)
    case .kakao:
      return Color(.yellow)
    case .local:
      return Color(.primary)
    }
  }
  
  private var foregroundColor: Color {
    switch provider {
    case .apple:
      return Color(.white)
    case .kakao:
      return Color(.black).opacity(0.85)
    case .local:
      return Color(.accent1)
    }
  }
}

public extension TTLoginLabel {
  enum LoginProvider {
    case local
    case kakao
    case apple
  }
}


struct TTLoginButton_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      
    }
    .padding(.horizontal, 10)
    .frame(maxWidth: .infinity)
  }
}
