//
//  FontAsset.swift
//  UISystem
//
//  Created by JH Park on 2023/09/25.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//

import DesignSystemFoundation

public extension FontAsset {
  
//  // MARK: Bold
//  static var descriptionB = FontAsset(.bold, size: 12, leading: .lineHeight(16))
//  static var subB = FontAsset(.bold, size: 16, leading: .lineHeight(18))
//  static var headerB = FontAsset(.bold, size: 20, leading: .lineHeight(20))
//  static var titleB = FontAsset(.bold, size: 24, leading: .lineHeight(21))
//  static var largeTitleB = FontAsset(.bold, size: 30, leading: .lineHeight(22))
//
//  // MARK: Regular
//  static var descriptionR = FontAsset(.regular, size: 12, leading: .lineHeight(16))
//  static var subR = FontAsset(.regular, size: 16, leading: .lineHeight(18))
//  static var headerR = FontAsset(.regular, size: 20, leading: .lineHeight(20))
//  static var titleR = FontAsset(.regular, size: 24, leading: .lineHeight(21))
//  static var largeTitleR = FontAsset(.regular, size: 30, leading: .lineHeight(22))
}

public extension Font {
  static var descriptionB = UISystemFontFamily.Pretendard.bold.swiftUIFont(size: 12)
  static var subB = UISystemFontFamily.Pretendard.bold.swiftUIFont(size: 16)
  static var headerB = UISystemFontFamily.Pretendard.bold.swiftUIFont(size: 20)
  static var titleB = UISystemFontFamily.Pretendard.bold.swiftUIFont(size: 24)
  static var largeTitleB = UISystemFontFamily.Pretendard.bold.swiftUIFont(size: 30)
  static let descriptionR = UISystemFontFamily.Pretendard.regular.swiftUIFont(size: 12)
  static var subR = UISystemFontFamily.Pretendard.regular.swiftUIFont(size: 16)
  static var headerR = UISystemFontFamily.Pretendard.regular.swiftUIFont(size: 20)
  static var titleR = UISystemFontFamily.Pretendard.regular.swiftUIFont(size: 24)
  static var largeTitleR = UISystemFontFamily.Pretendard.regular.swiftUIFont(size: 30)
}

#if(DEBUG)
import SwiftUI
struct FontAsset_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Text("하하")
        .font(Font.largeTitleB)
      Text("하하")
        .font(Font.largeTitleR)
    }
  }
}
#endif
