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
  
  
  static let rightArrow = Icon(image: ImageAsset.rightArrow.toImage(), tintColor: Color(.accent2))
  static let check = Icon(image: ImageAsset.check.toImage(), tintColor: Color(.primary))
  
  // MARK: 로그인 아이콘
  static let kakao = Icon(image: ImageAsset.kakaoLogo.toImage(), tintColor: Color(.gray38))
  static let local = Icon(image: ImageAsset.localLogo.toImage(), tintColor: Color(.accent1))
  static let apple = Icon(image: ImageAsset.appleLogo.toImage(), tintColor: Color(.white))
  
  // MARK: 카테고리
  static let 카테고리_교육 = Icon(image: ImageAsset.카테고리_교육.toImage())
  static let 카테고리_기타 = Icon(image: ImageAsset.카테고리_기타.toImage())
  static let 카테고리_돌봄 = Icon(image: ImageAsset.카테고리_돌봄.toImage())
  static let 카테고리_수리 = Icon(image: ImageAsset.카테고리_수리.toImage())
  static let 카테고리_심부름 = Icon(image: ImageAsset.카테고리_심부름.toImage())
  static let 카테고리_이동 = Icon(image: ImageAsset.카테고리_이동.toImage())
  static let 카테고리_청소 = Icon(image: ImageAsset.카테고리_청소.toImage())
  
  // MARK: 우리마을
  static let 우리마을_공고 = Icon(image: ImageAsset.우리마을_공고.toImage())
  static let 우리마을_동네소식 = Icon(image: ImageAsset.우리마을_동네소식.toImage())
  static let 우리마을_자치회관 = Icon(image: ImageAsset.우리마을_자치회관.toImage())
  
  // MARK: 소통
  static let 소통_의견 = Icon(image: ImageAsset.소통_의견.toImage())
  static let 소통_투표 = Icon(image: ImageAsset.소통_투표.toImage())
}
