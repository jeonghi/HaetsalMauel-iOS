//
//  TransferInputCore.swift
//  App
//
//  Created by JH Park on 2023/10/14.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture
import EumNetwork
import Combine

struct TransferInput: Reducer {
  
  struct State {
    var receiverName: String = ""
    var amount: String = ""
    var password: String = ""
    var isShowingPopup: Bool = false
    var isShowingFullSheet: Bool = false
    var allFilledInputField: Bool {
      !receiverName.isEmpty && !amount.isEmpty
    }
    var isDismiss: Bool = false
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    case onDismiss
    
    /// 텍스트필드
    case updateReceiverName(String)
    case updateAmount(String)
    case updatePassword(String)
    
    /// 팝업
    case showingPopup
    case dismissPopup
    case showingFullSheet
    case dismissFullSheet
    
    /// 버튼
    case tappedSendButton
    case tappedNextButton
    
    /// 네트워크
    
    case requestGetMyAccountInfo
    case requestGetMyAccountInfoResponse(Result<PayAccountEntity.Response?, HTTPError>)
    case requestGetOtherAccountInfo
    case requestGetOtherAccountInfoResponse(Result<PayAccountEntity.Response?, HTTPError>)
    case requestCreateTransaction
    case requestCreateTransactionResponse(Result<Box?, HTTPError>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
      case .onDismiss:
        state.isDismiss = true
        return .none
        
      case .updateAmount(let amount):
        state.amount = amount
        return .none
      case .updateReceiverName(let account):
        state.receiverName = account
        return .none
      case .updatePassword(let password):
        
        if state.password.count >= 4 { return .none }
        
        state.password = password
        
        if state.password.count == 4 {
          return .send(.requestCreateTransaction)
        }
        
        return .none
        
        /// 팝업
      case .showingPopup:
        state.isShowingPopup = true
        return .none
      case .dismissPopup:
        state.isShowingPopup = false
        return .none
      case .showingFullSheet:
        state.isShowingFullSheet = true
        state.password = ""
        return .none
      case .dismissFullSheet:
        state.isShowingFullSheet = false
        return .none
        
      case .tappedSendButton:
        return .concatenate([
          .send(.dismissPopup),
          .send(.showingFullSheet)
        ])
      case .tappedNextButton:
        return .concatenate([
          .send(.showingPopup)
        ])
        
        /// 네트워크
      case .requestGetMyAccountInfo:
        return .publisher {
          payService.getMyCardInfo()
            .receive(on: mainQueue)
            .map{Action.requestGetMyAccountInfoResponse(.success($0))}
            .catch{Just(Action.requestGetMyAccountInfoResponse(.failure($0)))}
        }
      case .requestGetMyAccountInfoResponse(.success(let res)):
        guard let res = res else {
          return .none
        }
        logger.log(.debug, res)
        return .none
      case .requestGetMyAccountInfoResponse(.failure(let error)):
        logger.log(.error, error)
        return .none
      case .requestGetOtherAccountInfo:
        let nickName = state.receiverName
        let request = PayAccountEntity.Request.GetAccount(nickName: nickName)
        return .publisher{
          payService.getOthersCardInfo(request)
            .receive(on: mainQueue)
            .map{Action.requestGetOtherAccountInfoResponse(.success($0))}
            .catch{Just(Action.requestGetOtherAccountInfoResponse(.failure($0)))}
        }
      case .requestGetOtherAccountInfoResponse(.success(let res)):
        return .none
      case .requestGetOtherAccountInfoResponse(.failure(let error)):
        logger.log(.error, error)
        return .none
      case .requestCreateTransaction:
        guard let amount = Int64(state.amount) else {
          return .none
        }
        let password = state.password; let nickName = state.receiverName
        let request = TransactionEntity.Request(amount: amount, password: password, nickname: nickName)
        return .publisher {
          payService.transferMoney(request)
            .receive(on: mainQueue)
            .map{Action.requestCreateTransactionResponse(.success($0))}
            .catch{Just(Action.requestCreateTransactionResponse(.failure($0)))}
        }
      case .requestCreateTransactionResponse(.success(let res)):
        hapticService.hapticNotification(type: .success)
        return .send(.onDismiss)
      case .requestCreateTransactionResponse(.failure(let error)):
        hapticService.hapticNotification(type: .error)
        logger.log(.error, error)
        return .send(.dismissFullSheet)
      }
    }
  }
  
  @Dependency(\.appService.payService) var payService
  @Dependency(\.appService.hapticService) var hapticService
  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.logger) var logger
}

