//
//  UserManager.swift
//  App
//
//  Created by JH Park on 2023/10/11.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//
import Foundation

final class UserManager: ObservableObject {
  @Published private(set) var isLogin = false
}

extension UserManager {
  func onChange(isLogin: Bool) {
    self.isLogin = isLogin
  }
}
