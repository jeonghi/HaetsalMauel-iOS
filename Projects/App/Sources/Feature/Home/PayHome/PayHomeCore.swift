//
//  PayHomeCore.swift
//  App
//
//  Created by JH Park on 2023/11/01.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture
import EumNetwork
import Combine

struct PayHome: Reducer {
  struct State {
    
    /// 카드 컴포넌트 변수
    var payCardName: String = ""
    var payBalance: Int64 = 0
    
    ///
    var transactionList: [TransactionEntity.History] = []
    var isLoadingTransaction: Bool = false
    var isLoadingPage: Bool = false
    
    /// 탭
    var selectedTab: Tab? = nil
    
    /// Full sheet
    var showingSetPasswordSheet: Bool = false
    
    /// Popup
    var showingPopup: Bool = false
    
    /// 하위뷰
    var setPasswordState: SetPassword.State? = nil
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    
    /// Password
    case showingSetPasswordSheet(Bool)
    case dismissSetPasswordSheet
    
    /// Popup
    case showingPopup
    case dismissPopup
    
    case setPasswordAction(SetPassword.Action)
    
    /// Custom
    case tappedRemittanceButton
    case updatePayCardName(String)
    
    /// Child
    case selectTab(Tab?)
    
    /// 네트워크
    case requestGetTransactions
    case requestGetTransactionsResposne(Result<TransactionEntity.Response?, HTTPError>)
    
    case requestGetAccountInfo
    case requestGetAccountInfoResponse(Result<PayAccountEntity.Response?, HTTPError>)
  }
  
  enum Tab: String, CaseIterable, Equatable {
    case 보냄 = "보낸 내역만"
    case 받음 = "받은 내역만"
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .merge(
          .send(.requestGetTransactions),
          .send(.requestGetAccountInfo)
        )
      case .onDisappear:
        return .none
        
        /// Custom
      case .tappedRemittanceButton:
        state.setPasswordState = .init()
        return .send(.showingSetPasswordSheet(true))
      case .updatePayCardName(let updated):
        state.payCardName = updated
        return .none
        
        /// Password
      case .showingSetPasswordSheet(let showing):
        state.showingSetPasswordSheet = showing
        return .none
      case .dismissSetPasswordSheet:
        state.showingSetPasswordSheet = false
        return .none
        
        /// Popup
      case .showingPopup:
        state.showingPopup = true
        return .none
      case .dismissPopup:
        state.showingPopup = false
        return .none
        
      case .setPasswordAction(.passwordSetDone):
        return .merge(
            .send(.dismissSetPasswordSheet),
            .send(.showingPopup)
          )
      case .setPasswordAction:
        return .none
        
        /// Child
      case .selectTab(let selectedTab):
        state.selectedTab = selectedTab
        return .send(.requestGetTransactions)
        
        /// 네트워크
      case .requestGetTransactions:
        state.isLoadingTransaction = true
        var type: TransactionEntity.TransactionType? {
          switch state.selectedTab {
          case .보냄:
            return .출금
          case .받음:
            return .입금
          default:
            return nil
          }
        }
        let params = TransactionEntity.Params(type: type)
        return .publisher {
          payService.getTransactionList(params)
            .receive(on: mainQueue)
            .map{Action.requestGetTransactionsResposne(.success($0))}
            .catch{Just(Action.requestGetTransactionsResposne(.failure($0)))}
        }
      case .requestGetTransactionsResposne(.success(let res)):
        guard let res = res else {
          logger.log(.warning, "트랜젝션 결과 없음")
          return .none
        }
        state.transactionList = res.histories
        state.isLoadingTransaction = false
        return .none
      case .requestGetTransactionsResposne(.failure(let error)):
        logger.log(.error, error)
//        state.isLoadingTransaction = false
        return .none
        
      case .requestGetAccountInfo:
        state.isLoadingPage = true
        return .publisher {
          payService.getMyCardInfo()
            .receive(on: mainQueue)
            .map{Action.requestGetAccountInfoResponse(.success($0))}
            .catch{Just(Action.requestGetTransactionsResposne(.failure($0)))}
        }
      case .requestGetAccountInfoResponse(.success(let res)):
        guard let res = res else {
          return .none
        }
        state.payBalance = res.balance
        state.isLoadingPage = false
        return .none
      case .requestGetAccountInfoResponse(.failure(let error)):
        return .none
      }
    }
    .ifLet(\.setPasswordState, action: /Action.setPasswordAction){
      SetPassword()
    }
  }
  
  @Dependency(\.appService.payService) var payService
  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.logger) var logger
}
