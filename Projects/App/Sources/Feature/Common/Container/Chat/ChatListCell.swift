//
//  ChatListCell.swift
//  UISystem
//
//  Created by 쩡화니 on 11/6/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import SwiftUI
import DesignSystemFoundation
import UISystem

public struct ChatListCell {
  let profileUrl: URL?
  let userName: String
  let description: String
  let createdAt: Date
  let unread: Int
  
  public init(profileUrl: URL?, userName: String, description: String, createdAt: Date, unread: Int) {
    self.profileUrl = profileUrl
    self.userName = userName
    self.description = description
    self.createdAt = createdAt
    self.unread = unread
  }
}

extension ChatListCell: View {
  public var body: some View {
    HStack(alignment: .top, spacing: 10){
      Circle()
        .fill(Color(.systemgray02))
        .frame(width: 32, height: 32)
      
      VStack(alignment: .leading, spacing: 5){
        Text(userName)
          .lineLimit(1)
          .font(.subB)
        
        Text(description)
          .lineLimit(1)
          .font(.subR)
      }
      .foregroundColor(Color.black)
      .hLeading()
      
      VStack(alignment: .trailing, spacing: 5){
        Text(createdAt.formattedTimeWithAmPm())
          .font(.descriptionR)
          .foregroundColor(Color(.systemgray07))
        
        Text(unread >= 999 ? "999+" : "\(unread)")
            .font(.descriptionB)
            .foregroundColor(Color.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(
              Color(.primary)
                .cornerRadius(999, corners: .allCorners)
            )
            .opacity(unread > 0 ? 1.0: 0.0)
      }
    }
    .padding(16)
    .frame(maxWidth: .infinity)
    .background(
      Color.white
    )
  }
}

#Preview {
  VStack(spacing: 5){
    ChatListCell(profileUrl: URL(string: ""), userName: "닉네임", description: "채팅 내용", createdAt: Date(), unread: 3)
    ChatListCell(profileUrl: URL(string: ""), userName: "닉네임", description: "채팅 내용", createdAt: Date(), unread: 100)
    ChatListCell(profileUrl: URL(string: ""), userName: "닉네임", description: "채팅 내용채팅 내용채팅 내용채팅 내용채팅 내용채팅 내용", createdAt: Date(), unread: 0)
    ChatListCell(profileUrl: URL(string: ""), userName: "닉네임", description: "채팅 내용채팅 내용채팅 내용채팅 내용채팅 내용채팅 내용", createdAt: Date(), unread: 0)
  }
}
