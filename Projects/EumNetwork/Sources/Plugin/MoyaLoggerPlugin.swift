//
//  LoggerPlugin.swift
//  EumNetwork
//
//  Created by 쩡화니 on 11/26/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Moya

final class MoyaLoggerPlugin: PluginType {
  
  static let shared = MoyaLoggerPlugin()
  
  private init(){}
  
  // 🔥 Request 가 전송되기 전.
  func willSend(_ request: RequestType, target: TargetType) {
    guard let httpRequest = request.request else {
      print("--> 유효하지 않은 요청")
      return
    }
    let url = httpRequest.description
    let method = httpRequest.httpMethod ?? "unknown method"
    var log = "----------------------------------------------------\n[\(method)] \(url)\n----------------------------------------------------\n"
    log.append("API: \(target)\n")
    if let headers = httpRequest.allHTTPHeaderFields, !headers.isEmpty {
      log.append("header: \(headers)\n")
    }
    if let body = httpRequest.httpBody, let bodyString = String(bytes: body, encoding: String.Encoding.utf8) {
      log.append("\(bodyString)\n")
    }
    log.append("------------------- END \(method) --------------------------")
    print(log)
  }
  
  // 🔥 Response 를 받은 후.
  func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
    switch result {
    case let .success(response):
      onSuceed(response, target: target, isFromError: false)
    case let .failure(error):
      onFail(error, target: target)
    }
  }
  
  func onSuceed(_ response: Response, target: TargetType, isFromError: Bool) {
    let request = response.request
    let url = request?.url?.absoluteString ?? "nil"
    let statusCode = response.statusCode
    
    var log = "------------------- 네트워크 통신 성공(isFromError: \(isFromError)) -------------------"
    log.append("\n[\(statusCode)] \(url)\n----------------------------------------------------\n")
    log.append("API: \(target)\n")
    response.response?.allHeaderFields.forEach {
      log.append("\($0): \($1)\n")
    }
    if let reString = String(bytes: response.data, encoding: String.Encoding.utf8) {
      log.append("\(reString)\n")
    }
    log.append("------------------- END HTTP (\(response.data.count)-byte body) -------------------")
    print(log)
  }
  
  func onFail(_ error: MoyaError, target: TargetType) {
    if let response = error.response {
      onSuceed(response, target: target, isFromError: true)
      return
    }
    var log = "네트워크 오류"
    log.append("<-- \(error.errorCode) \(target)\n")
    log.append("\(error.failureReason ?? error.errorDescription ?? "unknown error")\n")
    log.append("<-- END HTTP")
    print(log)
  }
}
