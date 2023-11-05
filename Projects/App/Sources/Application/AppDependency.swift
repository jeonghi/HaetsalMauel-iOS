//
//  AppDependency.swift
//  App
//
//  Created by JH Park on 2023/10/11.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import LinkNavigator
import SwiftUI

// MARK: - AppDependency

struct AppDependency: DependencyType {
  let eventObserver: EventObserver<EventState> = .init(state: .init(currentTabID: .tab2))
  let userManager: UserManager
}

// MARK: - EventState

struct EventState: Equatable {
  var currentTabID: TapID
  
  enum TapID: Equatable {
    case tab1
    case tab2
    case tab3
  }
}
