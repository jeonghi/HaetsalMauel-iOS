//
//  MPPostringReadCore.swift
//  App
//
//  Created by 쩡화니 on 11/16/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture
import EumNetwork
import Combine

struct MPPostingRead: Reducer {
  
  struct State {
    var selectedRoute: Route? = nil
    var postId: Int64 = 0
    var isDismiss: Bool = false
    var commentInput: String = ""
    var showingActionSheet: Bool = false
    var showingPopup: Bool = false
    var marketPost: MarketPostEntity.Response? = nil
    var marketPostReadHeaderViewModel: MPPostContentHeader.ViewModel? {
      guard let post = marketPost, let writerInfo = post.writerInfo else {
        return nil
      }
      
      var status: MPPostContentHeader.PostStatus {
        switch post.status {
        case .recruiting:
          return .모집중
        default:
          return .모집완료
        }
      }
      
      var type: MPPostContentHeader.PostType {
        switch post.marketType {
        case .provideHelp:
          return .도움제공
        default:
          return .도움요청
        }
      }
      
      return .init(
        avatar: URL(string: writerInfo.avatarPhotoUrl ?? ""),
        userName: writerInfo.nickName, locationName: writerInfo.address, createdAt: post.createdDate, postStatus: status, postType: type, title: post.title, content: post.content ?? "", pointAmount: post.volunteerTime, meetingPlace: post.location)
    }
    
    /// Child
    var MPApplicationListState: MPApplicationList.State? = nil
  }
  
  enum Route {
    case readApply
    case createApply
  }
  
  enum PostingType {
    case Mine
    case Others
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    
    case updateCommentInput(String)
    case setRoute(Route?)
    case tappedReadApplyList(Int64)
    
    /// Action Sheet
    case showingActionSheet(Bool)
    case dismissActionSheet
    
    /// Popup
    case showingPopup(Bool)
    case dismissPopup
    
    /// Child
    case MPApplicationListAction(MPApplicationList.Action)
    
    /// Network
    case requestGetPostInfo
    case requestGetPostInfoResponse(Result<MarketPostEntity.Response?, HTTPError>)
    case requestDeleteComment(commentId: Int64) // 댓글 삭제하기
    case requestDeleteCommentResponse(Result<Box?, HTTPError>)
    case requestCreateComment(String) // 댓글 생성하기
    case requestCreateCommentResponse(Result<Box?, HTTPError>)
    case requestDeletePost // 글 지우기
    case requestDeletePostResponse(Result<Box?, HTTPError>)
    case requestDeleteApply(postId: Int64) // 신청 취소하기
    case requestDeleteApplyResponse(Result<Box?, HTTPError>)
    case requestUpdatePostStatus(status: MarketPostEntity.Status)
    case requestUpdatePostStatusResponse(Result<Box?, HTTPError>)
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        state.isDismiss = false
        return .send(.requestGetPostInfo)
      case .onDisappear:
        return .none
        
      case .setRoute(let selectedRoute):
        state.selectedRoute = selectedRoute
        return .none
      case .updateCommentInput(let updatedComment):
        state.commentInput = updatedComment
        return .none
      case .tappedReadApplyList(let postId):
        state.MPApplicationListState = .init(postId: postId)
        return .send(.setRoute(.readApply))
        
        /// Action Sheet
      case .showingActionSheet(let showing):
        state.showingActionSheet = showing
        return .none
      case .dismissActionSheet:
        state.showingActionSheet = false
        return .none
        
        /// Popup
      case .showingPopup(let showing):
        state.showingPopup = showing
        return .none
      case .dismissPopup:
        state.showingPopup = false
        return .none
        
        /// Child
      case .MPApplicationListAction:
        return .none
        
        /// 네트워크
      case .requestGetPostInfo:
        let postId = state.postId
        return .publisher {
          marketService.readPost(postId)
            .receive(on: mainQueue)
            .map{Action.requestGetPostInfoResponse(.success($0))}
            .catch{Just(Action.requestGetPostInfoResponse(.failure($0)))}
        }
      case .requestGetPostInfoResponse(.success(let res)):
        guard let res = res else {
          logger.log(.warning, res)
          return .none
        }
        state.marketPost = res
        logger.log(.debug, res)
        return .none
      case .requestGetPostInfoResponse(.failure(let error)):
        logger.log(.error, error)
        return .none
      case .requestDeleteComment(let commentId):
        let postId = state.postId
        return .publisher{
          marketService.deleteComment(postId, commentId)
            .receive(on: mainQueue)
            .map{Action.requestDeleteCommentResponse(.success($0))}
            .catch{Just(Action.requestDeleteCommentResponse(.failure($0)))}
        }
      case .requestDeleteCommentResponse(.success(let res)):
        logger.log(.debug, res)
        return .send(.onAppear)
      case .requestDeleteCommentResponse(.failure(let error)):
        logger.log(.error, error)
        return .none
      case .requestCreateComment(let comment):
        let postId = state.postId
        let request = MarketPostCommmentEntity.Request(content: comment)
        return .publisher{
          marketService.createComment(postId, request)
            .receive(on: mainQueue)
            .map{Action.requestCreateCommentResponse(.success($0))}
            .catch{Just(Action.requestCreateCommentResponse(.failure($0)))}
        }
      case .requestCreateCommentResponse(.success(_)):
        return .send(.onAppear)
      case .requestCreateCommentResponse(.failure(let error)):
        logger.log(.error, error)
        return .none
      case .requestDeletePost:
        let postId = state.postId
        return .publisher{
          marketService.deletePost(postId)
            .receive(on: mainQueue)
            .map{Action.requestDeletePostResponse(.success($0))}
            .catch{Just(Action.requestDeletePostResponse(.failure($0)))}
        }
      case .requestDeletePostResponse(.success(let res)):
        state.isDismiss = true
        return .none
      case .requestDeletePostResponse(.failure(let error)):
        logger.log(.error, error)
        return .none
        
      case .requestDeleteApply(let postId):
        return .none
      case .requestDeleteApplyResponse:
        return .none
        
      case .requestUpdatePostStatus(let status):
        let postId = state.postId
        let request = MarketPostEntity.UpdateStatusRequest(status: status)
        let publisher = Effect.publisher {
          marketService.updatePostStatus(postId, request)
            .receive(on: mainQueue)
            .map{Action.requestUpdatePostStatusResponse(.success($0))}
            .catch{Just(Action.requestUpdatePostStatusResponse(.failure($0)))}
        }
        return .merge(
          publisher
        )
        
      case .requestUpdatePostStatusResponse(.success(let res)):
        guard let res = res else {
          return .none
        }
        logger.log(.debug, res)
        return .send(.onAppear)
      case .requestUpdatePostStatusResponse(.failure(let error)):
        logger.log(.error, error)
        state.isDismiss = true
        return .none
      }
    }
    .ifLet(\.MPApplicationListState, action: /Action.MPApplicationListAction){
      MPApplicationList()
    }
  }
  
  @Dependency(\.appService.marketService) var marketService
  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.logger) var logger
}
