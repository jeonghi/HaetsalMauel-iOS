//
//  MPPartyApplicationListCore.swift
//  App
//
//  Created by 쩡화니 on 11/21/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture
import UISystem
import SwiftUI
import Combine
import EumNetwork

struct MPApplicationList: Reducer {
  
  struct State {
    @BindingState var postId: Int64
    var isLoading: Bool = false
    var isSelectedAnyPeople: Bool = false
    var isShowingPopup: Bool = false
    var popupType: PopupType = .참여수락여부확인
    var applyCellModels: [MPPostApplyListCell.ViewModel] = []
    var isAnyChecked: Bool {
      applyCellModels.count > 0
    }
    var applicantList: [MarketPostApplicationEntity.Response] = []
  }
  
  enum Action {
    /// Life Cycle
    case onAppear
    case onDisappear
    case onLoad
    
    /// View Defined
    case setPopupType(PopupType)
    case showPopup
    case dismissPopup
    case isLoading(Bool)
    
    case tappedButton(ButtonType)
    
    enum ButtonType {
      case Accept
      case AcceptCancel
      case AcceptConfirm
      case GoChatRoom
    }
    
    case check(UUID)
    
    /// Network
    case requestGetApplicantList
    case requestGetApplicantListResponse(Result<[MarketPostApplicationEntity.Response]?, HTTPError>)
  }
  
  enum PopupType {
    case 참여수락여부확인
    case 정상확인
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        logger.log(.debug, "뷰가 나타남")
        return .merge(
          .send(.isLoading(true)),
          .send(.requestGetApplicantList)
        )
      case .onDisappear:
        logger.log(.debug, "뷰가 사라짐")
        return .none
      case .onLoad:
        return .none
        
        /// View Defined
      case .setPopupType(let type):
        state.popupType = type
        return .none
      case .showPopup:
        state.isShowingPopup = true
        return .none
      case .dismissPopup:
        state.isShowingPopup = false
        return .none
      case .isLoading(let isLoading):
        logger.log(.debug, "로딩 상태 변경: \(isLoading)")
        state.isLoading = isLoading
        return .none
        
      case .tappedButton(let type):
        switch type {
        case .Accept:
          return .concatenate([
            .send(.setPopupType(.참여수락여부확인)),
            .send(.showPopup)
          ])
        case .AcceptCancel:
          return .send(.dismissPopup)
        case .AcceptConfirm:
          return .send(.setPopupType(.정상확인))
        case .GoChatRoom:
          return .send(.dismissPopup)
        }
        
      case .check(let id):
        state.applyCellModels = state.applyCellModels.map {
          var model = $0
          if $0.id == id {
            model.isChecked.toggle()
          }
          return model
        }
        return .none
        
      case .requestGetApplicantList:
        logger.log(.info, "지원리스트 요청")
        let postId = state.postId
        let apiRequest = Effect.publisher {
          marketService.readApplies(postId)
            .receive(on: mainQueue)
            .map{Action.requestGetApplicantListResponse(.success($0))}
            .catch{Just(Action.requestGetApplicantListResponse(.failure($0)))}
        }
        
        return .merge(
          apiRequest
        )
      case .requestGetApplicantListResponse(.success(let res)):
        guard let res = res else {
          logger.log(.debug, "res가 없음")
          return .none
        }
        logger.log(.debug, res)
        state.applicantList = res.filter{$0.isAccepted == false}
        state.applyCellModels = state.applicantList.map{.init($0)}
        return .send(.isLoading(false))
      case .requestGetApplicantListResponse(.failure(let error)):
        logger.log(.error, "무슨 에러남")
        return .none
      }
    }
  }
  
  @Dependency(\.appService.marketService) var marketService
  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.logger) var logger
}
