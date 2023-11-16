//
//  CMDiscussionListCell.swift
//  UISystem
//
//  Created by 쩡화니 on 11/16/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import DesignSystemFoundation

public struct CMDiscussionListCell: View {
  
  let title: String // 제목
  let likeCnt: Int // 좋아요수
  let commentCnt: Int // 댓글수
  let locationName: String // 동네
  let createdAt: Date // 글 작성 시간
  
  public init(title: String, likeCnt: Int, commentCnt: Int, locationName: String, createdAt: Date) {
    self.title = title
    self.likeCnt = likeCnt
    self.commentCnt = commentCnt
    self.locationName = locationName
    self.createdAt = createdAt
  }
  
  public var body: some View {
    VStack(spacing: 10) {
      Text(title)
        .font(.subB)
        .foregroundColor(Color(.black))
        .lineLimit(1)
        .multilineTextAlignment(.leading)
        .hLeading()
      HStack(spacing: 0) {
        부가정보들
        아이콘들
      }
    }
  }
  
  
  private var 부가정보들: some View {
    HStack(spacing: 5){
      Text(locationName) // 동네 이름
      Text("\(createdAt.timeAgoString()) 전") // 글작성시간
    }
    .font(.descriptionR)
    .foregroundColor(Color(.systemgray07))
  }
  
  private var 아이콘들: some View {
    HStack(spacing: 7) {
      if(likeCnt > 0){
        아이콘만들기(.엄지척, "\(likeCnt)")
          .foregroundColor(Color(.primary))
      }
      아이콘만들기(.말풍선, "\(commentCnt)")
        .foregroundColor(Color(.systemgray07))
    }
    .hTrailing()
  }
  
  private func 아이콘만들기(_ image: ImageAsset, _ text: String) -> some View {
    HStack(spacing: 5) {
      image.toImage()
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .frame(height: 16)
        
      Text(text)
        .font(.descriptionR)
    }
    
  }
}

#Preview {
  CMDiscussionListCell(title: "제목", likeCnt: 0, commentCnt: 2, locationName: "정릉 제 2동", createdAt: Date())
}
