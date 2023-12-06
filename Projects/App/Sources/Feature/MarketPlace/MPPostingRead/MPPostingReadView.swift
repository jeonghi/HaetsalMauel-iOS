//
//  MPPostringReadView.swift
//  App
//
//  Created by 쩡화니 on 11/16/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import SwiftUI
import ExyteChat
import ComposableArchitecture
import UISystem
import DesignSystemFoundation

struct MPPostingReadView {
  
  @Environment(\.dismiss) private var dismiss
  
  typealias Core = MPPostingRead
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var selectedRoute: Core.Route?
    var postId: Int64
    var isDismiss: Bool
    var commentTextInput: String
    var showingActionSheet: Bool
    var showingPopup: Bool
    var marketPostReadHeaderViewModel: MPPostContentHeader.ViewModel?
    var marketPost: MarketPostEntity.Response? = nil
    init(state: State) {
      selectedRoute = state.selectedRoute
      postId = state.postId
      isDismiss = state.isDismiss
      commentTextInput = state.commentInput
      showingPopup = state.showingPopup
      showingActionSheet = state.showingActionSheet
      marketPostReadHeaderViewModel = state.marketPostReadHeaderViewModel
      marketPost = state.marketPost
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

extension MPPostingReadView: View {
  var body: some View {
    
    if(viewStore.isDismiss){
      dismiss()
    }
    
    return VStack(spacing: 0) {
      
      NavigationLink(
        destination: IfLetStore(MPApplicationListStore){ store in
          MPApplicationListView(store: store)
        },
        tag: Core.Route.readApply,
        selection: viewStore.binding(get: \.selectedRoute, send: Action.setRoute)
      ){
        EmptyView()
      }
      
      Color.white.frame(height: 1)
      if let viewModel = viewStore.marketPostReadHeaderViewModel {
        ScrollView {
          MPPostContentHeader(viewModel)
          분할
            .padding(.vertical, 15)
          댓글_섹션
            .padding(.horizontal)
          분할
            .padding(.vertical, 15)
          이웃_섹션
            .padding(.horizontal)
            .padding(.bottom, 33)
        }
        .refreshable {
          viewStore.send(.requestGetPostInfo)
        }
        .frame(maxHeight: .infinity)
        .background(
          Color(.white)
        )
      }
      
      ChatTextInputField(senderAction: {viewStore.send(.requestCreateComment($0))})
    }
    .hideKeyboardWhenTappedAround()
    .setCustomNavBackButton()
    .eumActionSheet(
      isShowing: viewStore.binding(get: \.showingActionSheet, send: Action.showingActionSheet),
      buttons: 내비게이션_상단_바_액션시트_리스트_얻기()
    )
    .toolbar {
      ToolbarItemGroup(placement: .navigationBarTrailing){
        Button(action: {viewStore.send(.showingActionSheet(true))}){
          ImageAsset.기타_큰.toImage()
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 24)
        }
      }
    }
    .background(
      Color(.white)
    )
    .foregroundColor(Color(.black))
    .onAppear {
      viewStore.send(.onAppear)
    }
    .onDisappear {
      viewStore.send(.onDisappear)
    }
  }
}

extension MPPostingReadView {
  
  private var 분할: some View {
    Rectangle()
      .fill(Color(.systemgray02))
      .frame(height: 5)
  }
  
  private var 댓글_섹션: some View {
    VStack(spacing: 20) {
      Text("댓글 \(viewStore.marketPost?.commentCount ?? 0)")
        .font(.subB)
        .hLeading()
        .foregroundColor(Color(.black))
      if( viewStore.marketPost?.commentResponses?.isEmpty ?? true){
        댓글_없을경우
      } else {
        댓글_있을경우
      }
    }
  }
  
  private var 댓글_없을경우: some View {
    Text("아직 댓글이 없어요\n첫 댓글을 남겨주세요!")
      .multilineTextAlignment(.center)
      .font(.subR)
      .hCenter()
      .foregroundColor(Color(.systemgray06))
      .padding(.vertical, 40)
  }
  
  private var 댓글_있을경우: some View {
    LazyVStack(spacing: 20) {
      if let commentList = viewStore.marketPost?.commentResponses {
        ForEach(commentList, id:\.self){
          MPPostCommentListCell(comment: $0, deleteAction: {viewStore.send(.requestDeleteComment(commentId: $0))})
        }
      }
    }
    .id(UUID())
  }
  
  private var 이웃_섹션: some View {
    VStack(spacing: 20) {
      if let post = viewStore.marketPost, let curr = post.currentApplicant, let total = post.maxNumOfPeople {
        Text("참여 중인 이웃 \(curr)/\(total)")
          .font(.subB)
          .hLeading()
          .foregroundColor(Color(.black))
        참여관련버튼()
      }
    }
  }
  
  private func 내비게이션_상단_바_액션시트_리스트_얻기() -> [EumActionSheetButton] {
    var 내_게시글_버튼: [EumActionSheetButton] = [
      .init(title: "삭제하기", action: {
        viewStore.send(.dismissActionSheet)
        viewStore.send(.requestDeletePost)
      })
    ]
    
    if let status = viewStore.marketPost?.status, status == .recruiting {
      내_게시글_버튼.insert(.init(title: "수정하기", action: {
        viewStore.send(.dismissActionSheet)
      }), at: 0)
      내_게시글_버튼.append(.init(title: "모집완료", action: {
        viewStore.send(.requestUpdatePostStatus(status: .recruitmentCompleted))
        viewStore.send(.dismissActionSheet)
      }))
    }
    
    var 남의_게시글_버튼: [EumActionSheetButton] = [
      .init(title: "이 게시글 신고하기", action: {
        viewStore.send(.dismissActionSheet)
      })
    ]

    if let isScrap = viewStore.marketPost?.isScrap {
      if isScrap {
        남의_게시글_버튼.insert(.init(title: "관심 게시글에서 제외", action: {}), at: 0)
      }else {
        남의_게시글_버튼.insert(.init(title: "관심 게시글로 등록", action: {}), at: 0)
      }
    }
    
    
    return (viewStore.marketPost?.isWriter ?? false) ? 내_게시글_버튼 : 남의_게시글_버튼
  }
  
  private func 참여관련버튼() -> some View {
    VStack {
      if let post = viewStore.marketPost {
        switch post.status {
        case .recruitmentCompleted, .transactionCompleted:
          Button(action: {}){
            Text("모집 완료")
          }
          .buttonStyle(PrimaryButtonStyle())
          .disabled(true)
        case .recruiting:
          if post.isWriter ?? false {
            Button(action: {viewStore.send(.tappedReadApplyList(post.postId))}){
              Text("참여 관리")
            }
            .disabled(false)
            .buttonStyle(PrimaryButtonStyle())
          } else {
            if post.isApplicant ?? false {
              Button(action: {}){
                Text("신청 완료")
              }
              .buttonStyle(SecondaryButtonStyle())
              .disabled(false)
            } else {
              NavigationLink(destination: MPApplyCreateView(store: .init(initialState: MPApplyCreate.State(postId: post.postId)){MPApplyCreate()})){
                Text("참여 신청")
              }
              .buttonStyle(PrimaryButtonStyle())
              .disabled(false)
            }
          }
        }
      }
    }
  }
}

extension MPPostingReadView {
  private var MPApplicationListStore: Store<MPApplicationList.State?, MPApplicationList.Action> {
    return store.scope(state: \.MPApplicationListState, action: Action.MPApplicationListAction)
  }
}

#Preview {
  let store = Store(initialState: MPPostingRead.State(postId: 4)){
    MPPostingRead()
  }
  return NavigationView {
    MPPostingReadView(store: store)
  }
}
