//
//  ChatRoom.swift
//  App
//
//  Created by 쩡화니 on 12/17/23.
//  Copyright © 2023 com.haetsal. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Chatroom: Identifiable, Codable, Equatable {
  
  static func == (lhs: Chatroom, rhs: Chatroom) -> Bool {
    lhs.id == rhs.id
  }
  
  @DocumentID var id: String? // Firestore 문서 ID
  var applyId: Int
  var group: Bool
  var latestMessage: Message
  var postId: Int
  var postTitle: String
  var users: [Int]
  var usersUnreadCountInfo: [Int64: Int] // 읽지 않은 메시지 관리
  var roomImageUrl: URL?
}
