//
//  KeyChain.swift
//  EumAuth
//
//  Created by 쩡화니 on 11/27/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import KeychainAccess

class Properties {
  
  static let keychain = Keychain(service: "kr.k-eum.auth")
  
  public static func saveCodable<T: Codable>(key: String, data: T?) {
      if let encoded = try? JSONEncoder().encode(data) {
          try? keychain.set(encoded, key: key)
      }
  }

  public static func loadCodable<T: Codable>(key: String) -> T? {
      if let data = try? keychain.getData(key) {
          return try? JSONDecoder().decode(T.self, from: data)
      }
      return nil
  }

  public static func delete(_ key: String) {
      try? keychain.remove(key)
  }

  static func save(key: String, string: String?) {
      if let value = string {
          try? keychain.set(value, key: key)
      }
  }

  static func load(key: String) -> String? {
      try? keychain.get(key)
  }
}
