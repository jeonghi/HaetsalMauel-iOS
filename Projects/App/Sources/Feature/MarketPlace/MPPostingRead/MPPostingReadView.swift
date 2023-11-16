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
    var showingActionSheet: Bool
    var showingPopup: Bool
    init(state: State) {
      showingPopup = state.showingPopup
      showingActionSheet = state.showingActionSheet
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

extension MPPostingReadView: View {
  var body: some View {
    VStack(spacing: 0) {
      ScrollView {
        포스트_내용
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
      .background(
          Color(.white)
      )
    }
    .setCustomNavBackButton()
    .eumPopup(
      isShowing: viewStore.binding(get: \.showingPopup, send: Action.dismissPopup)
    ){
      EumPopupView(
        title: "채팅방에서 나가겠습니까?",
        subtitle: "채팅방을 나가면 채팅 목록 및 대화 내용이 삭제되고 복구할 수 없어요.",
        type: .twoLineTwoButton,
        firstButtonName: "네, 나갈래요",
        secondButtonName: "취소",
        firstButtonAction: {
          viewStore.send(.dismissPopup)
          dismiss()
        },
        secondButtonAction: {
          viewStore.send(.dismissPopup)
        }
      )
    }
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
  }
}

extension MPPostingReadView {
  
  private var 분할: some View {
    Rectangle()
      .fill(Color(.systemgray02))
      .frame(height: 5)
  }
  
  private var 포스트_내용: some View {
    ExchangePostHeader(
      avatar: URL(string: "https://kr.object.ncloudstorage.com/k-eum/characterAsset/sun_middle%402x.png"),
      userName: "최소융",
      locationName: "정릉제2동",
      createdAt: Date(),
      postStatus: .모집중,
      postType: .도움제공,
      title: "제목",
      content: "본문 내용 본문 내용본문 내용본문 내용본문 내용본문 내용본문 내용본문 내용본문 내용본문 내용본문 내용본문 내용본문 내용본문 내용본문 내용본문 내용본문 내용본문 내용본문 내용",
      pointAmount: 300,
      meetingPlace: "활동 장소"
    )
  }
  
  private var 댓글_섹션: some View {
    VStack(spacing: 0) {
      Text("댓글")
        .font(.subB)
        .hLeading()
        .foregroundColor(Color(.black))
      댓글_없을경우
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
    LazyVStack {
      
    }
  }
  
  private var 이웃_섹션: some View {
    VStack(spacing: 20) {
      Text("참여 중인 이웃 1/30")
        .font(.subB)
        .hLeading()
        .foregroundColor(Color(.black))
      Button(action: {}){
        Text("참여 관리")
      }
      .buttonStyle(PrimaryButtonStyle())
    }
  }

  private func 내비게이션_상단_바_액션시트_리스트_얻기() -> [EumActionSheetButton] {
    let 내_게시글_버튼: [EumActionSheetButton] = [
      .init(title: "수정하기", action: {
        viewStore.send(.dismissActionSheet)
      }),
      .init(title: "삭제하기", action: {
        viewStore.send(.dismissActionSheet)
      }),
      .init(title: "모집완료", action: {
        viewStore.send(.dismissActionSheet)
      })
    ]
    
    let 남의_게시글_버튼: [EumActionSheetButton] = [
      .init(title: "관심 게시글로 등록", action: {
        viewStore.send(.dismissActionSheet)
      }),
      .init(title: "이 게시글 신고하기", action: {
        viewStore.send(.dismissActionSheet)
      })
    ]
    
    return 내_게시글_버튼
  }
  
  private func 댓글_상단_액션시트_리스트_얻기() -> [EumActionSheetButton] {
    
    let 내_게시글_버튼: [EumActionSheetButton] = [
      .init(title: "수정하기", action: {
        viewStore.send(.dismissActionSheet)
      }),
      .init(title: "삭제하기", action: {
        viewStore.send(.dismissActionSheet)
      })
    ]
    
    return 내_게시글_버튼
  }
}

#Preview {
  let store = Store(initialState: MPPostingRead.State()){
    MPPostingRead()
  }
  return NavigationView {
    MPPostingReadView(store: store)
  }
}
