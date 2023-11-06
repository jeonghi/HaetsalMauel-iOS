//
//  DiscussionListCell.swift
//  UISystem
//
//  Created by 쩡화니 on 11/5/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI

public struct DiscussionListCell {
  
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

extension DiscussionListCell: View {
  public var body: some View {
    VStack(spacing: 10){
      상태정보표시
      제목
      부가정보
    }
    .padding(16)
    .aspectRatio(375/113, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
    .frame(maxWidth: .infinity)
    .background(
      Rectangle()
        .foregroundColor(Color(.white))
    )
  }
}

public extension DiscussionListCell {
  enum PostStatus: String, Equatable {
    case 투표중
    case 투표완료 = "투표 완료"
  }
}

extension DiscussionListCell {
  private var 상태정보표시: some View {
    글_상태_라벨
    .hLeading()
  }
  
  private var 제목: some View {
    Text(title)
      .font(.subB)
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
    DefaultLabel(postStatus.rawValue, tintColor: .white, backgroundColor: postStatus == PostStatus.투표완료 ? .gray : .orange, radius: 4, textFont: .descriptionR)
      .frame(width: 55, height: 24)
  }
}

#Preview {
  LazyVStack(spacing: 0){
    DiscussionListCell(postStatus: .투표중, title: "제목", locationName: "정릉 제2동", createdAt: Date())
    DiscussionListCell(postStatus: .투표완료, title: "제목", locationName: "정릉 제3동", createdAt: Date()-310000)
  }
}
