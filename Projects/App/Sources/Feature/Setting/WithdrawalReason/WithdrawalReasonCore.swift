//
//  WithdrawalReasonCore.swift
//  App
//
//  Created by 쩡화니 on 11/13/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import ComposableArchitecture
import Combine
import EumNetwork

struct WithdrawalReason: Reducer {
  struct State {
    var reasonList: [WithdrawalEntity.ReasonCategory] = [
    ]
    var isAnythingSelected: Bool {
      selectedReason != nil
    }
    var selectedReason: Int64? = nil
    var withdrawalDetailReasonState: WithdrawalDetailReason.State = .init()
    var isLoading: Bool = false
  }
  enum Action {
    case onAppear
    case isLoading(Bool)
    case selectReason(Int64?)
    case withdrawalDetailReasonAction(WithdrawalDetailReason.Action)
    
    case requestGetReasonList
    case requestGetReasonListResponse(Result<[WithdrawalEntity.ReasonCategory]?, HTTPError>)
  }
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        state.selectedReason = nil
        state.isLoading = true
        return .send(.requestGetReasonList)
      case .isLoading(let isLoading):
        state.isLoading = isLoading
        return .none
        
      case .selectReason(let selectedReason):
        state.selectedReason = selectedReason
        state.withdrawalDetailReasonState = .init(reasonId: selectedReason)
        return .none
      
      case .withdrawalDetailReasonAction(let act):
        return .none
        
      case .requestGetReasonList:
        
        var publisher = Effect.publisher { authService.getWithdrawalReasonList()
            .receive(on: mainQueue)
            .map{Action.requestGetReasonListResponse(.success($0))}
            .catch{Just(Action.requestGetReasonListResponse(.failure($0)))}
        }
        
        return .merge(
          publisher
        )
        
      case .requestGetReasonListResponse(.success(let res)):
        guard let res = res else {
          return .none
        }
        state.reasonList = res
        return .send(.isLoading(false))
        
      case .requestGetReasonListResponse(.failure(let error)):
        return .none
        
      }
    }
    Scope(state: \.withdrawalDetailReasonState, action: /Action.withdrawalDetailReasonAction){
      WithdrawalDetailReason()
    }
  }
  
  @Dependency(\.appService.authService) var authService
  @Dependency(\.mainQueue) var mainQueue
}
