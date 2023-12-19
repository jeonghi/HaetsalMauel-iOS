//
//  ChatService.swift
//  App
//
//  Created by 쩡화니 on 12/17/23.
//  Copyright © 2023 com.haetsal. All rights reserved.
//

import EumNetwork
import Combine

protocol ChatServiceType {
  func getChatRoomList(_ params: ChatRoomEntity.Params?) -> AnyPublisher<[ChatRoomEntity.Response]?, HTTPError>
}

final class ChatService: ChatServiceType {
  
  static var shared = ChatService()
  let network = Network<ChatAPI>()
  
  private init(){}
  
  func getChatRoomList(_ params: ChatRoomEntity.Params? = nil) -> AnyPublisher<[ChatRoomEntity.Response]?,HTTPError> {
    return network.request(.readChatList(params ?? Box()), responseType: [ChatRoomEntity.Response].self)
  }
}

