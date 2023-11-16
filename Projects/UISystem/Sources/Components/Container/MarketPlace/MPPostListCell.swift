//
//  CommunityListCell.swift
//  UISystem
//
//  Created by 쩡화니 on 11/5/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import DesignSystemFoundation
import Foundation

public struct MPPostListCell {
  
  // MARK: Public
  let postType: PostType // 게시글 타입
  let postStatus: PostStatus // 게시글 상태
  let pointAmount: Int64
  let title: String // 제목
  let commentCnt: Int // 댓글수
  let locationName: String // 동네
  let createdAt: Date // 글 작성 시간
  
  public init(postType: PostType, postStatus: PostStatus, pointAmount: Int64, title: String, commentCnt: Int, locationName: String, createdAt: Date) {
    self.postType = postType
    self.postStatus = postStatus
    self.pointAmount = pointAmount
    self.title = title
    self.commentCnt = commentCnt
    self.locationName = locationName
    self.createdAt = createdAt
  }
}

public extension MPPostListCell {
  enum PostType: String, Equatable {
    case 도움요청 = "도움 요청"
    case 도움제공 = "도움 제공"
  }
  
  enum PostStatus: String, Equatable {
    case 모집중 = "모집중"
    case 모집완료 = "모집 완료"
  }
}

/// 도움요청 vs 도움받기
/// 모집중 vs 모집완료

extension MPPostListCell: View {
  public var body: some View {
    VStack(spacing: 10){
      상태정보표시
      제목
      부가정보
    }
    .frame(maxWidth: .infinity)
    .background(
      Rectangle()
        .foregroundColor(Color(.white))
    )
  }
}

private extension MPPostListCell {
  private var 상태정보표시: some View {
    HStack(spacing: 10) {
      HStack(spacing: 5) {
        글_종류_라벨
        글_상태_라벨
      }
      
      // 햇살 포인트
      햇살포인트
    }
    .hLeading()
  }
  
  private var 제목: some View {
    Text(title)
      .font(.subB)
      .hLeading()
      .foregroundColor(Color(.black))
  }
  
  private var 부가정보: some View {
    HStack(spacing: 0) {
      
      HStack(spacing: 5){
        Text(locationName) // 동네 이름
        Text("\(createdAt.timeAgoString()) 전") // 글작성시간
      }
      .hLeading()
      
      // 댓글수
      댓글수
      
    }
    .foregroundColor(Color(.systemgray07))
    .font(.descriptionR)
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
    HStack(spacing: 2) {
      ImageAsset.햇살아이콘.toImage()
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .frame(height: 21.9)
        .foregroundColor(Color(.primary))
      Text("\(pointAmount)")
        .font(.descriptionR)
        .foregroundColor(Color(.black))
    }
  }
  
  private var 댓글수: some View {
    HStack(spacing: 2){
      ImageAsset.말풍선.toImage()
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .frame(height: 16)
        .foregroundColor(Color(.systemgray07))
      Text("\(commentCnt)")
    }
  }
}

#Preview {
  LazyVStack(spacing: 0) {
    MPPostListCell(postType: .도움요청, postStatus: .모집완료, pointAmount: 300, title: "제목", commentCnt: 0, locationName: "정릉제2동", createdAt: Date())
  }
}
