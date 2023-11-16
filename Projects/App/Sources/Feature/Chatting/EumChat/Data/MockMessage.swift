//
//  MockMessage.swift
//  App
//
//  Created by 쩡화니 on 11/12/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ExyteChat

struct MockMessage {
    let uid: String // 사용자 uid
    let sender: MockUser // 보내는 사용자
    let createdAt: Date
    var status: Message.Status? // 메시지 상태

    let text: String
    let images: [MockImage] // 이미지
    let videos: [MockVideo] // 비디오
    let recording: Recording? // 영상
    let replyMessage: ReplyMessage? // 응답 메시지
}

extension MockMessage {
    func toChatMessage() -> ExyteChat.Message {
        ExyteChat.Message(
            id: uid,
            user: sender.toChatUser(),
            status: status,
            createdAt: createdAt,
            text: text,
            attachments: images.map { $0.toChatAttachment() } + videos.map { $0.toChatAttachment() },
            recording: recording,
            replyMessage: replyMessage
        )
    }
}
