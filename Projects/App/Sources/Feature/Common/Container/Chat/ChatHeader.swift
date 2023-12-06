//
//  ChatHeader.swift
//  UISystem
//
//  Created by 쩡화니 on 11/12/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import SwiftUI
import DesignSystemFoundation
import UISystem

public struct ChatHeader {
  let postStatus: PostStatus
  let postType: PostType
  
  let title: String // 제목
  
  let pointAmount: Int64 // 햇살 포인트
  let meetingPlace: String // 활동 장소
  
  public init(postStatus: PostStatus, postType: PostType, title: String, pointAmount: Int64, meetingPlace: String) {
    self.postStatus = postStatus
    self.postType = postType
    self.title = title
    self.pointAmount = pointAmount
    self.meetingPlace = meetingPlace
  }
}


extension ChatHeader: View {
  public var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      tags
      contents
      footer
    }
    .padding(16)
    .frame(width: .infinity, alignment: .topLeading)
    .background(.white)
  }
}

public extension ChatHeader {
  private var tags: some View {
    HStack(alignment: .center, spacing: 4) {
      글_종류_라벨
      글_상태_라벨
    }
    .padding(0)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var contents: some View {
    VStack(alignment: .leading, spacing: 10){
      Text(title)
        .foregroundColor(Color(.black))
        .font(.headerB)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var footer: some View {
    HStack(alignment: .center, spacing: 10) {
      햇살포인트
      활동장소
    }
    .padding(0)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  // 도움 요청, 도움 제공
  private var 글_종류_라벨: some View {
    DefaultLabel(postType.rawValue, tintColor: Color(.systemgray07), backgroundColor: Color(.systemgray02), radius: 4, textFont: .descriptionR)
  }
  
  // 모집중, 모집완료
  private var 글_상태_라벨: some View {
    DefaultLabel(postStatus.rawValue, tintColor: Color(.white), backgroundColor: postStatus == PostStatus.모집완료 ? Color(.systemgray07) : Color(.primary), radius: 4, textFont: .descriptionR)
  }
  
  private var 햇살포인트: some View {
    HStack(alignment: .center, spacing: 2) {
      ImageAsset.햇살아이콘.toImage()
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .frame(height: 21.9)
        .foregroundColor(Color.orange)
      Text("\(pointAmount)")
        .font(.descriptionR)
    }
  }
  
  private var 활동장소: some View {
    HStack(alignment: .center, spacing: 2){
      ImageAsset.위치.toImage()
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .frame(height: 21.9)
        .foregroundColor(Color(.systemgray07))
      Text("\(meetingPlace)")
        .font(.descriptionR)
    }
  }
}

public extension ChatHeader {
  enum PostType: String, Equatable {
    case 도움요청 = "도움 요청"
    case 도움제공 = "도움 제공"
  }
  
  enum PostStatus: String, Equatable {
    case 모집중 = "모집중"
    case 모집완료 = "모집 완료"
  }
}

#Preview {
  ChatHeader(postStatus: .모집중, postType: .도움요청, title: "제목", pointAmount: 300, meetingPlace: "활동 장소")
}
