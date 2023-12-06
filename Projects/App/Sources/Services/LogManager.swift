//
//  LogManager.swift
//  App
//
//  Created by 쩡화니 on 11/27/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture

protocol Logger {
  func log(_ level: LogLevel, _ message: Any, file: String, line: Int, function: String)
}

enum LogLevel: String {
  case debug
  case info
  case warning
  case error
}

struct LogManager {
  
  static let shared = LogManager()
  private let logger: Logger
  
  private init() {
    self.logger = ConsoleLogger()
  }
  
  func log(_ level: LogLevel, _ message: Any, file: String = #file, line: Int = #line, function: String = #function) {
    #if(DEBUG)
    logger.log(level, message, file: file, line: line, function: function)
    #endif
  }
}

extension LogManager {
  
  struct ConsoleLogger: Logger {
    func log(_ level: LogLevel, _ message: Any, file: String, line: Int, function: String) {
      
      let fileName = (file as NSString).lastPathComponent
      var logMessage = "[\(level.rawValue.uppercased())] [\(fileName):\(line) - \(function)] "
      
      switch level {
      case .debug:
        logMessage += "[🚀] \(message)" // 흰색과 이모지
      case .info:
        logMessage += "[✅] \(message)" // 녹색과 이모지
      case .warning:
        logMessage += "[⚠️] \(message)" // 노란색과 이모지
      case .error:
        logMessage += "[❌] \(message)" // 빨간색과 이모지
      }
      print(logMessage)
    }
  }
}

extension DependencyValues {
  var logger: LogManager {
    get { self[LogManager.self] }
    set { self[LogManager.self] = newValue }
  }
}

extension LogManager {
  static let live = LogManager.shared
}

extension LogManager: DependencyKey {
  static let liveValue = LogManager.live
}
