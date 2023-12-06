//
//  PayAPI.swift
//  EumNetwork
//
//  Created by 쩡화니 on 11/29/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import Moya
import Combine

public enum PayAPI {
  
  case readMyAccount // 내 계좌 정보 조회
  case readAccount(_ body: JSONConvertible) // 계좌 정보 조회
  
  case updateCardName(_ body: JSONConvertible) // 카드 이름 업데이트
  
  case updatePassword(_ body: JSONConvertible) // 비밀번호 업데이트
  case createPassword(_ body: JSONConvertible) // 비밀번호 생성
  
  case readTransactions(_ params: ParamsConvertible) // 거래 내역 조회
  case createTransaction(_ body: JSONConvertible) // 송금하기
}

extension PayAPI: TargetType {
  
  public var baseURL: URL {
    return URL(string: "\(Constants.baseUrl)/bank-account")!
  }
  
  public var path: String {
    switch self {
    case .readMyAccount, .updateCardName:
      return ""
    case .readAccount:
      return "/other"
    case .createPassword, .updatePassword:
      return "/password"
    case .readTransactions:
      return "/pay"
    case .createTransaction:
      return "/remittance"
    
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .readTransactions, .readMyAccount:
      return .get
    case .updatePassword, .updateCardName:
      return .put
    case .createTransaction, .createPassword, .readAccount:
      return .post
    }
  }
  
  public var sampleData: Data {
    .init()
  }
  
  public var task: Task {
      switch self {
      case .readMyAccount:
        return .requestPlain
      case .readTransactions(let params):
        return .requestParameters(parameters: params.toParams(), encoding: URLEncoding.queryString)
      case .readAccount(let body), .updateCardName(let body), .createTransaction(let body), .updatePassword(let body), .createPassword(let body):
        return .requestParameters(parameters: body.toJSON(), encoding: JSONEncoding.default)
      }
  }
  
  public var headers: [String : String]? {
    nil
  }
}
