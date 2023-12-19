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
import UISystem

public struct MPPostListCell {
  
  // MARK: Public
  let post: MarketPostEntity.Response
}

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
    Text(post.title)
      .font(.subB)
      .hLeading()
      .foregroundColor(Color(.black))
  }
  
  private var 부가정보: some View {
    HStack(spacing: 0) {
      
      HStack(spacing: 5){
        Text(post.location) // 동네 이름
        Text("\(post.createdDate.timeAgoString())") // 글작성시간
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
    var labelText: String {
      switch post.marketType {
      case .provideHelp:
        return "도움제공"
      default:
        return "도움요청"
      }
    }
    
    return DefaultLabel(labelText, tintColor: Color(.systemgray07), backgroundColor: Color(.systemgray02), radius: 4, textFont: .descriptionR)
  }
  
  // 모집중, 모집완료
  private var 글_상태_라벨: some View {
    
    var labelText: String {
      switch post.status {
      case .recruiting:
        return "모집중"
      default:
        return "모집완료"
      }
    }
    
    return DefaultLabel(labelText, tintColor: Color(.white), backgroundColor: post.status != .recruiting ? Color(.systemgray07) : Color(.primary), radius: 4, textFont: .descriptionR)
  }
  
  private var 햇살포인트: some View {
    HStack(spacing: 2) {
      ImageAsset.햇살아이콘.toImage()
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .frame(height: 21.9)
        .foregroundColor(Color(.primary))
      Text("\(post.pay)")
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
      Text("\(post.commentCount)")
    }
  }
}

#Preview {
  LazyVStack(spacing: 0) {

  }
}
