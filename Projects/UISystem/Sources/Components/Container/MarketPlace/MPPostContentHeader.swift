//
//  EumChatHeader.swift
//  UISystem
//
//  Created by 쩡화니 on 11/12/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import SwiftUI
import DesignSystemFoundation
import Kingfisher

public struct MPPostContentHeader {
  private let avatar: URL? // 캐릭터 이미지 url
  
  private let userName: String // 유저이름
  private var locationName: String // 동네
  private var createdAt: Date // 글 작성 날짜
  
  private let postStatus: PostStatus
  private let postType: PostType
  
  private let title: String // 제목
  private let content: String // 본문 콘텐츠
  
  private let pointAmount: Int64 // 햇살 포인트
  private let meetingPlace: String // 활동 장소
  
  public init(avatar: URL?, userName: String, locationName: String, createdAt: Date, postStatus: PostStatus, postType: PostType, title: String, content: String, pointAmount: Int64, meetingPlace: String) {
    self.avatar = avatar
    self.userName = userName
    self.locationName = locationName
    self.createdAt = createdAt
    self.postStatus = postStatus
    self.postType = postType
    self.title = title
    self.content = content
    self.pointAmount = pointAmount
    self.meetingPlace = meetingPlace
  }
}

extension MPPostContentHeader: View {
  public var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      VStack(spacing: 10){
        header
        tags
      }
      contents
      footer
    }
    .padding(16)
    .frame(width: .infinity, alignment: .topLeading)
    .background(.white)
  }
}


public extension MPPostContentHeader {
  
  enum PostType: String, Equatable {
    case 도움요청 = "도움 요청"
    case 도움제공 = "도움 제공"
  }
  
  enum PostStatus: String, Equatable {
    case 모집중 = "모집중"
    case 모집완료 = "모집 완료"
  }
  
  private var header: some View {
    HStack(alignment: .center, spacing: 10) {
      KFImage(avatar)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .background(Color.gray.opacity(0.02))
        .clipShape(Circle())
        .frame(height: 32)
      VStack(alignment: .leading, spacing: 2) {
        Text(userName)
          .foregroundColor(Color(.black))
          .font(.subB)
          .hLeading()
        HStack(alignment: .center, spacing: 8) {
          Text(locationName)
          Text(createdAt.timeAgoString())
        }
        .foregroundColor(Color(.systemgray07))
        .font(.descriptionR)
        .hLeading()
      }
    }
    .padding(0)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var tags: some View {
    HStack(alignment: .center, spacing: 4) {
      글_종류_라벨
      글_상태_라벨
    }
    .padding(0)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var contents: some View {
    VStack(alignment: .leading, spacing:5){
      Text(title)
        .foregroundColor(Color(.black))
        .font(.headerB)
      Text(content)
        .foregroundColor(Color(.black))
        .font(.subR)
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
        .renderingMode(.template)
        .resizable()
        .scaledToFit()
        .foregroundColor(Color(.systemgray07))
        .frame(height: 22)
      Text("\(meetingPlace)")
        .font(.descriptionR)
    }
  }
}

#Preview {
  MPPostContentHeader(
    avatar: URL(string: "https://kr.object.ncloudstorage.com/k-eum/characterAsset/sun_middle%402x.png"),
    userName: "최소융",
    locationName: "정릉제2동",
    createdAt: Date(),
    postStatus: .모집중,
    postType: .도움제공,
    title: "제목",
    content: "본문 내용",
    pointAmount: 300,
    meetingPlace: "활동 장소"
  )
}
