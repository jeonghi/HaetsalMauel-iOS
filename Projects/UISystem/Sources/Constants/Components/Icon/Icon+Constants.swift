//
//  Icon+Constants.swift
//  UISystem
//
//  Created by JH Park on 2023/09/28.
//  Copyright © 2023 com.eum. All rights reserved.
//
import DesignSystemFoundation
import SwiftUI

public extension Icon {
  static let pencil = Icon(image: Image(systemName: "pencil.line"), tintColor: Color(.primary))
  static let filledStar = Icon(image: Image(systemName: "star.fill"), tintColor: Color(.primary))
  static let xmark = Icon(image: Image(systemName: "xmark"), tintColor: Color.black)
  static let kakao = Icon(image: ImageAsset.kakaoLogo.toImage(), tintColor: Color(.gray38))
  static let local = Icon(image: ImageAsset.localLogo.toImage(), tintColor: Color(.accent1))
  static let apple = Icon(image: ImageAsset.appleLogo.toImage(), tintColor: Color(.white))
  static let rightArrow = Icon(image: ImageAsset.rightArrow.toImage(), tintColor: Color(.accent2))
  static let check = Icon(image: ImageAsset.check.toImage(), tintColor: Color(.primary))
}
