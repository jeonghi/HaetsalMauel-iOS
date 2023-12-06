//
//  AppMain.swift
//  App
//
//  Created by JH Park on 2023/10/11.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

// MARK: - AppMain

@main
struct AppMain {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
}


// MARK: App

extension AppMain: App {

  var body: some Scene {
    WindowGroup {
      let store = Store(initialState: Root.State()){
        Root()
      }
      RootView(store: store)
    }
  }
}
