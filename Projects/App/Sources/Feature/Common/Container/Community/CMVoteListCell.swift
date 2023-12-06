//
//  DiscussionListCell.swift
//  UISystem
//
//  Created by 쩡화니 on 11/5/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import UISystem
import DesignSystemFoundation

public struct CMVoteListCell {
  
  // MARK: Public
  let postStatus: PostStatus // 게시글 상태
  let title: String // 제목
  let locationName: String // 동네
  let createdAt: Date // 글 작성 시간
  
  public init(postStatus: PostStatus, title: String, locationName: String, createdAt: Date) {
    self.postStatus = postStatus
    self.title = title
    self.locationName = locationName
    self.createdAt = createdAt
  }
}

extension CMVoteListCell: View {
  public var body: some View {
    VStack(spacing: 10){
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

public extension CMVoteListCell {
  enum PostStatus: String, Equatable {
    case 투표중
    case 종료됨 = "종료됨"
  }
}

extension CMVoteListCell {
  
  
  private var 제목: some View {
    HStack(spacing: 10) {
      글_상태_라벨
      Text(title)
        .font(.subB)
        .foregroundColor(Color(.black))
        .multilineTextAlignment(.leading)
        .lineLimit(1)
    }
    .hLeading()
  }
  
  private var 부가정보: some View {
    HStack(spacing: 5){
        Text(locationName) // 동네 이름
        Text("\(createdAt.timeAgoString()) 전") // 글작성시간
    }
    .hLeading()
    .foregroundColor(Color(.systemgray07))
    .font(.descriptionR)
  }
  
  private var 글_상태_라벨: some View {
    DefaultLabel(postStatus.rawValue, tintColor: .white, backgroundColor: postStatus == PostStatus.종료됨 ? Color(.systemgray07) : Color(.primary), radius: 4, textFont: .descriptionR)
  }
}

#Preview {
  LazyVStack(spacing: 0){
    CMVoteListCell(postStatus: .투표중, title: "제목", locationName: "정릉 제2동", createdAt: Date())
    CMVoteListCell(postStatus: .종료됨, title: "제목", locationName: "정릉 제3동", createdAt: Date()-310000)
  }
}
