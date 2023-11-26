//
//  MPPostingCreateView.swift
//  App
//
//  Created by 쩡화니 on 11/16/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem
import DesignSystemFoundation

struct MPPostingCreateView {
  
  @Environment(\.dismiss) private var dismiss
  
  typealias Core = MPPostingCreate
  typealias State = Core.State
  typealias Action = Core.Action
  
  typealias TransactionType = Core.TransactionType
  typealias ActivityTime = Core.ActivityTime
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var isAllFormFilled: Bool
    var selectedTransactionType: TransactionType?
    var selectedActivityTime: ActivityTime?
    var activityLocation: String
    var activityDate: Date
    var estimatedTime: Int
    var maxPeople: Int
    init(state: State) {
      isAllFormFilled = state.isAllFormFilled
      selectedTransactionType = state.selectedTransactionType
      selectedActivityTime = state.selectedActivityTime
      activityLocation = state.activityLocation
      activityDate = state.activityDate
      estimatedTime = state.estimatedTime
      maxPeople = state.maxPeople
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

extension MPPostingCreateView: View {
  var body: some View {
    VStack {
      Color.white.frame(height: 1)
      ScrollView(showsIndicators: false){
        타이틀
          .padding(.horizontal, 23.5)
          .padding(.top, 40)
          .padding(.bottom, 16)
        비추기종류
          .padding(.horizontal, 23.5)
        분할
        입력폼
          .padding(.horizontal, 23.5)
        분할
        VStack(spacing: 10) {
          글내용
          버튼들
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 54)
      }
    }
    .setCustomNavCloseButton()
    .setCustomNavBarTitle("글쓰기")
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
  }
}

extension MPPostingCreateView {
  
  private var 타이틀: some View {
    Text("이웃과 햇살을 나눠요")
      .hLeading()
      .font(.headerB)
      .foregroundColor(Color(.black))
  }
  
  private var 분할: some View {
    Rectangle()
      .fill(Color(.systemgray02))
      .frame(height: 5)
      .padding(.top, 45)
      .padding(.bottom, 20)
  }
  
  private var 입력폼: some View {
    VStack(spacing: 30) {
      거래유형
      활동장소
      활동날짜
      활동시간대
      예상소요시간
      최대모집인원
    }
  }
  
  private var 글내용: some View {
    PostTextFormView(store: postTextFormStore)
      .frame(height: 236)
  }
  
  private var 비추기종류: some View {
    containerBox("비추기 종류"){
      MCSelectionView(store: MCSelectionStore)
    }
  }
  
  private var 거래유형: some View {
    containerBox("거래 유형"){
      ScrollingTab(selection: viewStore.binding(get: \.selectedTransactionType, send: Action.selectTransactionType), tabs: TransactionType.allCases, inactiveTintColor: Color(.systemgray06), inactiveTabStrokeColor: Color(.systemgray06), inactiveTabBackgroundColor: Color(.white) ,radius: 12, horizontalPadding: 16, verticalPaddingg: 10)
    }
  }
  
  private var 활동장소: some View {
    containerBox("활동 장소"){
      EumTextField(text: viewStore.binding(get: \.activityLocation, send: Action.updateLocation), mode: .normal, placeholder: "활동 상세 주소를 입력해주세요")
    }
  }
  
  private var 활동날짜: some View {
    containerBox("활동 날짜"){
      Text("\(viewStore.activityDate.toString(.yyyyMMddE))")
        .foregroundColor(Color(.primary))
        .font(.subR)
        .padding(.horizontal, 16)
          .padding(.vertical, 12)
          .background(
            RoundedRectangle(cornerRadius: 12)
              .fill(Color(.primaryLight))
              .overlay(
                RoundedRectangle(cornerRadius: 12)
                  .stroke(Color(.primary), lineWidth: 1)
              )
          )
        .overlay(
          DatePicker("",
                     selection: viewStore.binding(get: \.activityDate, send: Action.updateDate),
                     displayedComponents: .date
          )
          .blendMode(.destinationOver)
          .labelsHidden()
          .font(.subR)
          .background(Color.clear)
          .tint(Color(.primary))
          .pickerStyle(.inline)
        )
    }
  }
  
  private var 활동시간대: some View {
    containerBox("활동 시간대"){
      ScrollingTab(selection: viewStore.binding(get: \.selectedActivityTime, send: Action.selectActivityTime), tabs: ActivityTime.allCases, inactiveTintColor: Color(.systemgray06), inactiveTabStrokeColor: Color(.systemgray06), inactiveTabBackgroundColor: Color(.white), radius: 12, horizontalPadding: 16, verticalPaddingg: 10)
    }
  }
  
  private var 예상소요시간: some View {
    
    var isFilledTime: Bool {
      viewStore.estimatedTime > 0
    }
    
    return containerBox("예상 소요 시간"){
      Text("\(viewStore.estimatedTime) 분")
        .foregroundColor(isFilledTime ? Color(.primary) : Color(.systemgray06))
          .font(.subR)
          .padding(.horizontal, 16)
          .padding(.vertical, 12)
          .background(
            RoundedRectangle(cornerRadius: 12)
              .fill(isFilledTime ? Color(.primaryLight) : Color(.white))
              .overlay(
                RoundedRectangle(cornerRadius: 12)
                  .stroke(isFilledTime ? Color(.primary) : Color(.systemgray06), lineWidth: 1)
              )
          )
          .overlay(
            Picker("", selection: viewStore.binding(get: \.estimatedTime, send: Action.updateTime)){
              ForEach(Array(stride(from: 0, through: 240, by: 30)), id: \.self) { i in
                Text("\(i) 분")
                  .foregroundColor(Color.black)
                  .tag(i)
              }
            }
            .font(.descriptionR)
            .pickerStyle(.menu)
            .tint(Color(.clear))
          )
    }
  }
  
  private var 최대모집인원: some View {
    
    var isFilledPeople: Bool {
      viewStore.maxPeople > 0
    }
    
    return containerBox("최대 모집 인원"){
        Text("\(viewStore.maxPeople) 명")
        .foregroundColor(isFilledPeople ? Color(.primary) : Color(.systemgray06))
          .font(.subR)
          .padding(.horizontal, 16)
          .padding(.vertical, 12)
          .background(
            RoundedRectangle(cornerRadius: 12)
              .fill(isFilledPeople ? Color(.primaryLight) : Color(.white))
              .overlay(
                RoundedRectangle(cornerRadius: 12)
                  .stroke(isFilledPeople ? Color(.primary) : Color(.systemgray06), lineWidth: 1)
              )
          )
          .overlay(
            Picker("", selection: viewStore.binding(get: \.maxPeople, send: Action.updateMaxPeople)){
              ForEach(Array(stride(from: 0, through: 50, by: 1)), id: \.self) { i in
                Text("\(i)")
                  .foregroundColor(Color.black)
                  .tag(i)
              }
            }
//            .blendMode(.destinationOver)
            .font(.descriptionR)
            .pickerStyle(.menu)
            .tint(Color(.clear))
          )
    }
  }
  
  private var 버튼들: some View {
    HStack {
      Button(action:{dismiss()}){
        Text("작성취소")
      }
      .buttonStyle(SecondaryButtonStyle())
      Button(action:{dismiss()}){
        Text("작성완료")
      }
      .buttonStyle(PrimaryButtonStyle())
      .disabled(!viewStore.isAllFormFilled)
    }
  }
  
  private func containerBox<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
    VStack(spacing: 20) {
      Text(title)
        .font(.subB)
        .hLeading().foregroundColor(Color(.black))
      content()
        .hLeading()
    }
    .frame(maxHeight: .infinity)
  }
}

// MARK: Store init
extension MPPostingCreateView {
  private var MCSelectionStore: StoreOf<MCSelection> {
    return store.scope(state: \.marketCategorySelectionState, action: Action.marketCategorySelectionAction)
  }
  private var postTextFormStore: StoreOf<PostTextForm> {
    return store.scope(state: \.postTextFormState, action: Action.postTextFormAction)
  }
}

#Preview {
  let store = Store(initialState: MPPostingCreate.State()){
    MPPostingCreate()
  }
  return NavigationView{MPPostingCreateView(store: store)}
}
