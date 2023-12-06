//
//  MarketPlaceHomeCore.swift
//  App
//
//  Created by 쩡화니 on 11/9/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture
import EumNetwork
import Combine

struct MPHome: Reducer {
  
  struct GetPostListID: Hashable {}
  
  struct State {
    
    var postList: [MarketPostEntity.Response] = []
    var isShowingFullSheet: Bool = false
    var selectedCat: MPCategory? {
      marketPlaceCategorySelectionState.selectedCat
    }
    
    var selectedRoute: Route? = nil
    var fullSheetType: FullSheetType? = nil
    
    var selectedTab: Tab? = nil
    var showOnlyProceeding: Bool = false
    
    /// Child
    var marketPlaceCategorySelectionState: MarketPlaceCategorySelection.State = .init()
    var MPPostingCreateState: MPPostingCreate.State = .init()
    var MPPostingReadState: MPPostingRead.State = .init()
    
  }
  
  enum Route {
    case readPost
  }
  
  enum FullSheetType {
    case 카테고리선택
    case 글쓰기
  }
  
  enum Tab: String, CaseIterable {
    case 줄래요 = "도움 줄래요"
    case 받을래요 = "도움 받을래요"
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    case onReload
    
    /// Custom
    case tappedReadPost(Int64)
    case tappedCreatePostButton
    case setRoute(Route?)
    
    /// Full sheet
    case updateFullSheetType(FullSheetType?)
    case isShowingFullSheet
    case dismissFullSheet
    
    case 카테고리선택하기
    case 글쓰기
    case tappedShowOnlyProceedingButton
    case selectTab(Tab?)
    
    /// 네트워크 처리
    case requestGetPostList
    case requestGetPostListResponse(Result<[MarketPostEntity.Response]?, HTTPError>)
    
    /// Child
    case marketPlaceCategorySelectionAction(MarketPlaceCategorySelection.Action)
    case MPPostingReadAction(MPPostingRead.Action)
    case MPPostingCreateAction(MPPostingCreate.Action)
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
//        guard let _ = state.selectedCat else {
//          return .send(.카테고리선택하기)
//        }
        return .send(.requestGetPostList)
      case .onDisappear:
        return .none
      case .onReload:
        return .merge(.send(.requestGetPostList))
        
        /// Custom
      case .tappedReadPost(let postId):
        state.MPPostingReadState.postId = postId
        return .send(.setRoute(.readPost))
      case .tappedCreatePostButton:
        return .send(.글쓰기)
      case .setRoute(let selectedRoute):
        state.selectedRoute = selectedRoute
        return .none
        
      case .updateFullSheetType(let type):
        state.fullSheetType = type
        return .none
      case .isShowingFullSheet:
        state.isShowingFullSheet = true
        return .none
      case .dismissFullSheet:
        state.isShowingFullSheet = false
        return .send(.onReload)
        
      case .카테고리선택하기:
        return .merge(
          .send(.updateFullSheetType(.카테고리선택)),
          .send(.isShowingFullSheet)
        )
        
      case .글쓰기:
        return .merge(
          .send(.updateFullSheetType(.글쓰기)),
          .send(.isShowingFullSheet)
        )
        
      case .tappedShowOnlyProceedingButton:
        state.showOnlyProceeding.toggle()
//        hapticService.hapticSelection()
        return .send(.requestGetPostList)
        
      case .selectTab(let selectedTab):
        state.selectedTab = selectedTab
//        hapticService.hapticSelection()
        return .send(.requestGetPostList)
        
        /// 네트워크
      case .requestGetPostList:
        var type: MarketPostEntity.TransactionType? {
          switch state.selectedTab {
          case .줄래요:
            return .provideHelp
          case .받을래요:
            return .requestHelp
          default:
            return nil
          }
        }
        
        var status: MarketPostEntity.Status? {
          state.showOnlyProceeding ? .recruiting : nil
        }
        
        let filter = MarketPostEntity.Filter(
          category: state.selectedCat,
          type: type,
          status: status
        )
        
        return .publisher {
          marketService.readPosts(filter)
            .receive(on: mainQueue)
            .map{Action.requestGetPostListResponse(.success($0))}
            .catch{Just(Action.requestGetPostListResponse(.failure($0)))}
        }
//        return .none
      case .requestGetPostListResponse(.success(let res)):
        guard let res = res else {
          logger.log(.warning, res)
          return .none
        }
        logger.log(.debug, res)
        
        state.postList = res
        return .none
      case .requestGetPostListResponse(.failure(let error)):
        logger.log(.error, error)
        return .none
        
        /// Child
      case .marketPlaceCategorySelectionAction(.tappedSelectDoneButton):
        return .merge(
          .send(.dismissFullSheet),
          .send(.updateFullSheetType(nil))
        )
      case .marketPlaceCategorySelectionAction:
        return .none
      case .MPPostingCreateAction(.onAppear):
        state.MPPostingCreateState = .init()
        return .none
      case .MPPostingCreateAction(.requestCreatePostResponse(.success(_))):
        return .merge(
          .send(.requestGetPostList),
          .send(.dismissFullSheet)
        )
      case .MPPostingReadAction(let act):
        return .none
      case .MPPostingCreateAction(let act):
        return .none
      }
      
    }
    
    Scope(state: \.marketPlaceCategorySelectionState, action: /Action.marketPlaceCategorySelectionAction){
      MarketPlaceCategorySelection()
    }
    
    Scope(state: \.MPPostingCreateState, action: /Action.MPPostingCreateAction){
      MPPostingCreate()
    }
    
    Scope(state: \.MPPostingReadState, action: /Action.MPPostingReadAction){
      MPPostingRead()
    }
  }
  
  @Dependency(\.appService.marketService) var marketService
  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.appService.hapticService) var hapticService
  @Dependency(\.logger) var logger
}
