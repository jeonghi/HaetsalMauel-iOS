//
//  DataStorageManager.swift
//  App
//
//  Created by 쩡화니 on 12/6/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import FirebaseFirestore
import ComposableArchitecture

protocol DataStorageManagerType {
  func getChatRooms(withKeys chatRoomKeysFB: [String]) async
}

class DataStorageManager: ObservableObject {
  
  static var shared = DataStorageManager()
  
}

extension DependencyValues {
    var dataStorage: DataStorageManager {
        get { self[DataStorageManager.self] }
        set { self[DataStorageManager.self] = newValue }
    }
}

extension DataStorageManager {
  static let live = DataStorageManager.shared
}

extension DataStorageManager: DependencyKey {
    static let liveValue = DataStorageManager.live
}
