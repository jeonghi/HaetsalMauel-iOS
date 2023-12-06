//
//  MPPostingCreateCore.swift
//  App
//
//  Created by 쩡화니 on 11/16/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture
import EumNetwork
import Combine

struct MPPostingCreate: Reducer {
  
  typealias Category = MPCategory
  
  struct State {
    
    var selectedCategory: Category? {
      marketCategorySelectionState.selectedCategory
    }
    
    var title: String {
      postTextFormState.title
    }
    
    var content: String {
      postTextFormState.content
    }
    
    var isDismiss: Bool = false
    var selectedTransactionType: TransactionType? = nil // 거래 유형
    var activityLocation: String = "" // 활동 장소
    var activityDate: Date = Date() // 활동날짜
    var selectedActivityTime: ActivityTime? = nil // 활동 시간대
    var estimatedTime: Int = 0 // 예상 소요 시간
    var maxPeople: Int = 0 // 최대 모집 인원
    
    /// button 활성화
    var isAllFormFilled: Bool {
      selectedTransactionType != nil
      &&
      selectedCategory != nil
      &&
      selectedActivityTime != nil
      &&
      estimatedTime > 0
      &&
      maxPeople > 0
      &&
      !title.isEmpty
      &&
      !content.isEmpty
    }
    
    /// Child
    var marketCategorySelectionState: MCSelection.State = .init()
    var postTextFormState: PostTextForm.State = .init()
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    case dismiss
    
    /// Form
    case updateLocation(String)
    case updateDate(Date)
    case updateTime(Int)
    case updateMaxPeople(Int)
    case selectTransactionType(TransactionType?)
    case selectActivityTime(ActivityTime?)
    
    /// 버튼
    case tappedCreatePostButton
    
    /// 네트워크
    case requestCreatePost
    case requestCreatePostResponse(Result<MarketPostEntity.Response?, HTTPError>)
    
    /// Child
    case marketCategorySelectionAction(MCSelection.Action)
    case postTextFormAction(PostTextForm.Action)
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
      case .dismiss:
        state.isDismiss = true
        return .none
        
        /// Form
      case .updateLocation(let loc):
        state.activityLocation = loc
        return .none
      case .updateDate(let date):
        state.activityDate = date
        return .none
      case .updateTime(let time):
        state.estimatedTime = time
        return .none
      case .updateMaxPeople(let maxPeople):
        state.maxPeople = maxPeople
        return .none
        
      case .selectTransactionType(let selected):
        state.selectedTransactionType = selected
        return .none
      case .selectActivityTime(let selected):
        state.selectedActivityTime = selected
        return .none
        
      case .tappedCreatePostButton:
        return .send(.requestCreatePost)
      
        /// 네트워크
      case .requestCreatePost:
        
        guard let cat = state.selectedCategory, let type = state.selectedTransactionType?.cvtToEntityType(), let slot = state.selectedActivityTime?.cvtToEntityTime() else {
          return .none
        }
        
        let request = MarketPostEntity.Request(
          category: cat,
          content: state.content,
          location: state.activityLocation,
          marketType: type,
          maxNumOfPeople: Int32(state.maxPeople),
          slot: slot,
          startTime: state.activityDate,
          title: state.title,
          volunteerTime: Int32(state.estimatedTime)
        
        )
        return .publisher {
          marketService.createPost(request)
            .receive(on: mainQueue)
            .map{Action.requestCreatePostResponse(.success($0))}
            .catch{Just(Action.requestCreatePostResponse(.failure($0)))}
        }
        
      case .requestCreatePostResponse(.success(let res)):
        guard let res = res else {
          return .none
        }
        return .none
      case .requestCreatePostResponse(.failure(let error)):
        logger.log(.error,  error)
        return .none
        
        /// Child
      case .marketCategorySelectionAction:
        return .none
      case .postTextFormAction:
        return .none
      }
    }
    
    Scope(state: \.marketCategorySelectionState, action: /Action.marketCategorySelectionAction){
      MCSelection()
    }
    
    Scope(state: \.postTextFormState, action: /Action.postTextFormAction){
      PostTextForm()
    }
  }
  
  @Dependency(\.appService.marketService) var marketService
  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.logger) var logger
}
