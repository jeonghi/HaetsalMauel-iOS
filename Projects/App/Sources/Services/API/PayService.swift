//
//  PayService.swift
//  App
//
//  Created by 쩡화니 on 11/29/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import EumNetwork
import Combine

protocol PayServiceType {
  func transferMoney(_ body: TransactionEntity.Request) -> AnyPublisher<Box?, HTTPError>
  func createCardPassword(_ body: PayAccountEntity.Request.CreatePassword) -> AnyPublisher<PayAccountEntity.Response?, HTTPError>
  func updateCardPassword(_ body: PayAccountEntity.Request.UpdatePassword) -> AnyPublisher<Box?, HTTPError>
  func getTransactionList(_ params: TransactionEntity.Params) -> AnyPublisher<TransactionEntity.Response?, HTTPError>
  func getMyCardInfo() -> AnyPublisher<PayAccountEntity.Response?, HTTPError>
  func getOthersCardInfo(_ params: PayAccountEntity.Request.GetAccount) -> AnyPublisher<PayAccountEntity.Response?, HTTPError>
}

final class PayService: PayServiceType {
  func transferMoney(_ body: TransactionEntity.Request) -> AnyPublisher<Box?, HTTPError> {
    return network.request(.createTransaction(body), responseType: Box.self)
  }
  func createCardPassword(_ body: PayAccountEntity.Request.CreatePassword) -> AnyPublisher<PayAccountEntity.Response?, EumNetwork.HTTPError> {
    return network.request(.createPassword(body), responseType: PayAccountEntity.Response.self)
  }
  
  func updateCardPassword(_ body: PayAccountEntity.Request.UpdatePassword) -> AnyPublisher<Box?, EumNetwork.HTTPError> {
    return network.request(.updatePassword(body), responseType: Box.self)
  }
  
  func getTransactionList(_ params: TransactionEntity.Params) -> AnyPublisher<TransactionEntity.Response?, HTTPError> {
    return network.request(.readTransactions(params), responseType: TransactionEntity.Response.self)
  }
  
  func getMyCardInfo() -> AnyPublisher<PayAccountEntity.Response?, HTTPError> {
    return network.request(.readMyAccount, responseType: PayAccountEntity.Response.self)
  }
  
  func getOthersCardInfo(_ body: PayAccountEntity.Request.GetAccount) -> AnyPublisher<PayAccountEntity.Response?, HTTPError> {
    return network.request(.readAccount(body), responseType: PayAccountEntity.Response.self)
  }
  
  static var shared = PayService()
  let network = Network<PayAPI>()

  private init(){}
}
