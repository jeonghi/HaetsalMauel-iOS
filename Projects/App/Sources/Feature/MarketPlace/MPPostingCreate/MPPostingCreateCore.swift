//
//  MPPostingCreateCore.swift
//  App
//
//  Created by 쩡화니 on 11/16/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct MPPostingCreate: Reducer {
  
  typealias Category = MarketCategory
  
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
  
  enum TransactionType: String, CaseIterable {
    case 햇살보내기 = "햇살 보내기"
    case 햇살받기 = "햇살 받기"
  }
  
  enum ActivityTime: String, CaseIterable {
    case 오전
    case 오후
    case 상관없음
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    
    /// Form
    case updateLocation(String)
    case updateDate(Date)
    case updateTime(Int)
    case updateMaxPeople(Int)
    case selectTransactionType(TransactionType?)
    case selectActivityTime(ActivityTime?)
    
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
        
        /// Custom
      case .marketCategorySelectionAction(let act):
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
}
