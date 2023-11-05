//
//  CommunityHomeView.swift
//  App
//
//  Created by JH Park on 2023/10/02.
//  Copyright © 2023 com.eum. All rights reserved.
//
import ComposableArchitecture
import SwiftUI
import DesignSystemFoundation
import UISystem

struct CommunityHomeView: View {
  typealias Core = CommunityHome
  typealias State = Core.State
  typealias Action = Core.Action
  
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    var searchText: String
    var showingSheet: Bool
    init(state: State) {
      self.searchText = state.searchText
      self.showingSheet = state.showingFullScreenOver
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
  
  var body: some View {
    VStack {
      ZStack {
        ScrollView {
          어떤소통을원하세요
            .hLeading()
            .padding(.top, 10)
            .padding(.horizontal, 20)
        }
        newPostButton
          .vBottom()
          .hTrailing()
          .padding(20)
      }
    }
    .toolbar{
      ToolbarItem(placement: .navigationBarTrailing){
        NavigationLink(destination: EmptyView()){
          ImageAsset.검색
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 20)
        }
        .foregroundColor(Color.black)
      }
    }
    .fullScreenCover(isPresented: viewStore.binding(get: \.showingSheet, send: Action.dismissFullScreenOver)){
      IfLetStore(newPostingStore){store in NewPostingView(store: store)}
    }
    .navigationBarTitle("소통", displayMode: .inline)
    .navigationBarHidden(false)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onAppear{
      viewStore.send(.onAppear)
    }
    .onDisappear{
      viewStore.send(.onDisappear)
    }
  }
}

extension CommunityHomeView {
  
  private var 어떤소통을원하세요: some View {
    VStack(alignment: .leading, spacing: 20){
      Text("어떤소통을 원하세요?")
        .font(.titleB)
        .hLeading()
      HStack(spacing: 5) {
        
      }
        .hLeading()
    }
  }
  
  private var newPostButton: some View {
    Button(action:{}){
      RoundedRectangle(cornerRadius: 12)
        .fill(Color(.buttonDefaultBackground))
        .frame(width: 116, height: 50)
        .overlay(
          HStack {
            ImageAsset.쓰기
              .resizable()
              .renderingMode(.template)
              .aspectRatio(contentMode: .fit)
              .frame(height: 20)
            
            Text("글쓰기")
          }
            .font(.headerB)
            .foregroundColor(Color(.buttonDefaultForeground))
        )
    }
  }
}

// MARK: - Store init
extension CommunityHomeView {
  private var newPostingStore: Store<NewPosting.State?, NewPosting.Action> {
    return store.scope(state: \.newPostingState, action: Action.newPostingAction)
  }
}

struct CommunityHomeView_Previews: PreviewProvider {
    static var previews: some View {
      let store = Store(initialState: CommunityHome.State()){
        CommunityHome()
      }
      NavigationView {
        CommunityHomeView(store: store)
      }
    }
}
