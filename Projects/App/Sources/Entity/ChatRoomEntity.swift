//
//  ChatEntity.swift
//  App
//
//  Created by 쩡화니 on 12/13/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import SwiftUI
import EumNetwork

enum ChatRoomEntity {
  
  struct Params: ParamsConvertible {
    let type: ChatRoomType
  }
  
  enum ChatRoomType: String, Codable {
    case mine
    case others
  }
  
  struct Response: Codable, Equatable {
    let chatRoomId: Int64
    let chatRoomKeyFB: String
    let isBlocked: Bool
    let isPostDeleted: Bool
    let isRemittanceButton: Bool
    let isWriter: Bool
    let myInfo: UserInfo
    let opponentInfo: UserInfo
    let postInfo: MarketPostEntity.Response
  }
  
  struct UserInfo: Codable, Equatable {
    
    let userId: Int64
    let address: String
    let avatarPhotoUrl: String
    let nickName: String
  }
}
