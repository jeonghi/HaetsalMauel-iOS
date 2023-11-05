//
//  CommunityHomeCore.swift
//  App
//
//  Created by JH Park on 2023/10/02.
//  Copyright © 2023 com.eum. All rights reserved.
//
import ComposableArchitecture

struct CommunityHome: Reducer {
  
  typealias Category = CommunityCategory
  
  struct State {
    var searchText: String = "" // 커뮤니티 검색창 텍스트
    var currCategory: Category? = nil
    var showingFullScreenOver: Bool = false
    var newPostingState: NewPosting.State?
  }
  
  enum Route {
    case categorySelection
    case search
  }
  
  enum Action {
    case onAppear
    case onDisappear
    case setSearchText(String)
    
    case newPostingButtonTapped // 새 글쓰기 버튼 탭
    
    case showingFullScreenOver // 글쓰기 창 팝업
    case dismissFullScreenOver // 창 닫기
    
    case newPostingAction(NewPosting.Action) // 새로 글쓰기 포스트 화면 액션
    
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        guard let currCategory = state.currCategory else {
          // 현재 선택 카테고리가 없다면?
          // TODO: 선택창 팝업 띄우기
          return .none
        }
        return .none
      case .onDisappear:
        return .none
      case .setSearchText(let newText):
        state.searchText = newText
        return .none
      case .newPostingButtonTapped:
        state.newPostingState = .init() // 상태 초기화
        return .send(.showingFullScreenOver)
      case .showingFullScreenOver:
        state.showingFullScreenOver = true
        return .none
      case .dismissFullScreenOver:
        state.showingFullScreenOver = false
        state.newPostingState = nil // 화면 상태 없애기
        return .none
      case .newPostingAction:
        return .none
      }
    }
    .ifLet(\.newPostingState, action: /Action.newPostingAction){
      NewPosting()
    }
  }
}
