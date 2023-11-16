//
//  CommunityHomeCore.swift
//  App
//
//  Created by JH Park on 2023/10/02.
//  Copyright © 2023 com.eum. All rights reserved.
//
import ComposableArchitecture

struct CMHome: Reducer {
  
  typealias Category = CMCategory
  
  struct State {
    
    var showingFullScreenOver: Bool = false
    var hotPostList: [CommunityPostDescription] = []
    
    /// Child
    var newPostingState: NewPosting.State? = .init()
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    
    /// 카테고리 선택
    case tappedCategory(Category)
    
    /// 핫 게시글
    case tappedSeeMoreHotPost // 더보기
    case tappedPostCell // 핫게
    
    /// 글쓰기
    case tappedNewPostingButtonTapped // 새 글쓰기 버튼 탭
    case showingFullScreenOver // 글쓰기 창 팝업
    case dismissFullScreenOver // 창 닫기
    
    /// Child
    case newPostingAction(NewPosting.Action) // 새로 글쓰기 포스트 화면 액션
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
        
        /// 카테고리 선택
      case .tappedCategory(_):
        return .none
        
        /// 핫게시글
      case .tappedSeeMoreHotPost:
        return .none
      case .tappedPostCell:
        return .none
        
        /// 글쓰기
      case .tappedNewPostingButtonTapped:
        state.newPostingState = .init() // 상태 초기화
        return .send(.showingFullScreenOver)
      case .showingFullScreenOver:
        state.showingFullScreenOver = true
        return .none
      case .dismissFullScreenOver:
        state.showingFullScreenOver = false
        state.newPostingState = nil // 화면 상태 없애기
        return .none
        
        /// Child
      case .newPostingAction:
        return .none
      }
    }
    .ifLet(\.newPostingState, action: /Action.newPostingAction){
      NewPosting()
    }
  }
}
