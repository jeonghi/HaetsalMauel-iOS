//
//  ChatInteractorProtocol.swift
//  App
//
//  Created by 쩡화니 on 11/12/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import Combine
import ExyteChat

protocol ChatInteractorProtocol {
    var messages: AnyPublisher<[MockMessage], Never> { get }
    var senders: [MockUser] { get }
    var otherSenders: [MockUser] { get }

    func send(draftMessage: ExyteChat.DraftMessage)

    func connect()
    func disconnect()

    func loadNextPage() -> Future<Bool, Never>
}
