//
//  Message.swift
//  App
//
//  Created by 쩡화니 on 12/17/23.
//  Copyright © 2023 com.haetsal. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Message: Identifiable, Codable, Equatable {
    @DocumentID var id: String? // Firestore 문서 ID
    var text: String
    @ServerTimestamp var timestamp: Date?
    var userId: Int64
}
