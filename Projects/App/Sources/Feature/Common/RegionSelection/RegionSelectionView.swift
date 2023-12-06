//
//  RegionSelectionView.swift
//  App
//
//  Created by 쩡화니 on 12/1/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UISystem
import DesignSystemFoundation

struct RegionSelectionView {
  
  typealias Core = RegionSelection
  typealias State = Core.State
  typealias Action = Core.Action
  private let store: StoreOf<Core>
  
  @ObservedObject private var viewStore: ViewStore<ViewState, Action>
  
  struct ViewState: Equatable {
    
    
    var listSI: [RegionEntity.Response]
    var listGU: [RegionEntity.Response]
    var listDONG: [RegionEntity.Response]
    
    var selectedSI: RegionEntity.Response?
    var selectedGU: RegionEntity.Response?
    var selectedDONG: RegionEntity.Response?
    
    init(state: State) {
      listSI = state.listSI
      listGU = state.listGU
      listDONG = state.listDONG
      selectedSI = state.selectedSI
      selectedGU = state.selectedGU
      selectedDONG = state.selectedDONG
    }
  }
  
  init(store: StoreOf<Core>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: ViewState.init)
  }
}

extension RegionSelectionView: View {
  var body: some View {
    HStack {
      Text(viewStore.selectedSI?.name ?? "선택안함")
        .foregroundColor(Color(.black))
        .font(.subR)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
          RoundedRectangle(cornerRadius: 12)
            .fill(Color(.white))
            .overlay(
              RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemgray07), lineWidth: 1)
            )
        )
        .overlay(
          Picker("", selection: viewStore.binding(get: \.selectedSI, send: Action.selectSI)){
            Text("선택안함").tag(RegionEntity.Response?.none)
            ForEach(viewStore.listSI, id: \.self){
              option in Text(option.name).tag(Optional(option))
            }
          }
            .font(.descriptionR)
            .pickerStyle(.menu)
            .tint(Color(.clear))
        )
      
      Text(viewStore.selectedGU?.name ?? "선택안함")
        .foregroundColor(Color(.black))
        .font(.subR)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
          RoundedRectangle(cornerRadius: 12)
            .fill(Color(.white))
            .overlay(
              RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemgray07), lineWidth: 1)
            )
        )
        .overlay(
          Picker("", selection: viewStore.binding(get: \.selectedGU, send: Action.selectGU)){
            Text("선택안함").tag(RegionEntity.Response?.none)
            ForEach(viewStore.listGU, id: \.self){
              option in Text(option.name).tag(Optional(option))
            }
          }
            .font(.descriptionR)
            .pickerStyle(.menu)
            .tint(Color(.clear))
        )
      Text(viewStore.selectedDONG?.name ?? "선택안함")
        .foregroundColor(Color(.black))
        .font(.subR)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
          RoundedRectangle(cornerRadius: 12)
            .fill(Color(.white))
            .overlay(
              RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemgray07), lineWidth: 1)
            )
        )
        .overlay(
          Picker("", selection: viewStore.binding(get: \.selectedDONG, send: Action.selectDONG)){
            Text("선택안함").tag(RegionEntity.Response?.none)
            ForEach(viewStore.listDONG, id: \.self){
              option in Text(option.name).tag(Optional(option))
            }
          }
            .font(.descriptionR)
            .pickerStyle(.menu)
            .tint(Color(.clear))
        )
    }
    .onAppear {
      viewStore.send(.onAppear)
    }
    .onDisappear {
      viewStore.send(.onDisappear)
    }
  }
}

#Preview {
  let store = Store(initialState: RegionSelection.State()){
    RegionSelection()
  }
  return RegionSelectionView(store: store)
}
