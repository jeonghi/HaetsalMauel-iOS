//
//  EumChatCore.swift
//  App
//
//  Created by 쩡화니 on 11/11/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture
import Combine
import ExyteChat
import ExyteMediaPicker

struct EumChat: Reducer {
  struct State: Equatable {
    
    var messages: [Message] = []
    var chatTitle: String = ""
    var chatStatus: String = ""
    var chatCover: URL? = nil
    
    // MARK: private
    private var subscriptions = Set<AnyCancellable>()
  }
  
  enum Action: Equatable {
    case onAppear
    case onDisappear
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
      }
    }
  }
}

extension DraftMessage {
    func makeMockImages() async -> [MockImage] {
        await medias
            .filter { $0.type == .image }
            .asyncMap { (media : Media) -> (Media, URL?, URL?) in
                (media, await media.getThumbnailURL(), await media.getURL())
            }
            .filter { (media: Media, thumb: URL?, full: URL?) -> Bool in
                thumb != nil && full != nil
            }
            .map { media, thumb, full in
                MockImage(id: media.id.uuidString, thumbnail: thumb!, full: full!)
            }
    }

    func makeMockVideos() async -> [MockVideo] {
        await medias
            .filter { $0.type == .video }
            .asyncMap { (media : Media) -> (Media, URL?, URL?) in
                (media, await media.getThumbnailURL(), await media.getURL())
            }
            .filter { (media: Media, thumb: URL?, full: URL?) -> Bool in
                thumb != nil && full != nil
            }
            .map { media, thumb, full in
                MockVideo(id: media.id.uuidString, thumbnail: thumb!, full: full!)
            }
    }

    func toMockMessage(user: MockUser, status: Message.Status = .read) async -> MockMessage {
        MockMessage(
            uid: id ?? UUID().uuidString,
            sender: user,
            createdAt: createdAt,
            status: user.isCurrentUser ? status : nil,
            text: text,
            images: await makeMockImages(),
            videos: await makeMockVideos(),
            recording: recording,
            replyMessage: replyMessage
        )
    }
}

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}
