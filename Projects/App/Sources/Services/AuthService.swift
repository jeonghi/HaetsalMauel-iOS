//
//  AuthService.swift
//  App
//
//  Created by 쩡화니 on 11/20/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation

protocol AuthServiceType {
  var isLoggedIn: Bool { get }
}

final class AuthService: AuthServiceType {
  
  static var shared = AuthService()
  
  private init(){
    
  }
  
  var isLoggedIn: Bool {
    return true
  }
}
