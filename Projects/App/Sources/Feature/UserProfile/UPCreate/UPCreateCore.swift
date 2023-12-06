//
//  NewProfileCore.swift
//  App
//
//  Created by 쩡화니 on 11/13/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import ComposableArchitecture
import EumNetwork
import Combine

struct UPCreate: Reducer {
  
  typealias Category = CharacterCategory
  
  struct State {
    var nickName: String = ""// 닉네임
    var selectedCategory: Category? {
      CCSelectionState.selectedCategory
    }
    var CCSelectionState: CCSelection.State = .init()
    var regionSelectionState: RegionSelection.State = .init()
    
    var isAllInfoFilled: Bool {
      CCSelectionState.isSelectedAnyOne && regionSelectionState.allRegionIsSelected && !nickName.isEmpty
    }
  }
  
  enum Action {
    /// Life cycle
    case onAppear
    case onDisappear
    
    case updateNickName(String)
    case tappedNextButton
    
    case CCSelectionAction(CCSelection.Action)
    case regionSelectionAction(RegionSelection.Action)
    
    /// Network
    case requestCreateProfile
    case requestCreateProfileResponse(Result<ProfileEntity.Response?, HTTPError>)
  }
  
  var body: some ReducerOf<Self> {
    
    Reduce<State, Action> { state, action in
      switch action {
        /// Life cycle
      case .onAppear:
        return .none
      case .onDisappear:
        return .none
        
      case .updateNickName(let updatedNickName):
        state.nickName = updatedNickName
        return .none
        
      case .tappedNextButton:
        return .send(.requestCreateProfile)
        
      case .CCSelectionAction(let act):
        return .none
      case .regionSelectionAction(let act):
        return .none
      case .requestCreateProfile:
        
        guard let cat = state.selectedCategory, let type = state.selectedCategory, let regionId = state.regionSelectionState.selectedDONG?.regionId else {
          logger.log(.warning, "카테고리 정보 없음")
          return .none
        }
        
        var avatarName: ProfileEntity.AvatarName {
          switch cat {
          case .중장년:
            return .middle
          case .청년:
            return .young
          case .노년:
            return .old
          case .청소년:
            return .youth
          }
        }
        
        let request = ProfileEntity.Request(avatarName: avatarName , introduction: "", nickname: state.nickName, regionId: regionId)
        return .publisher {
          profileService.createProfile(request)
            .receive(on: mainQueue)
            .map{Action.requestCreateProfileResponse(.success($0))}
            .catch{Just(Action.requestCreateProfileResponse(.failure($0)))}
        }
      case .requestCreateProfileResponse(.success(let res)):
        logger.log(.debug, res)
        return .none
      case .requestCreateProfileResponse(.failure(let error)):
        logger.log(.error, error)
        return .none
      }
    }
    
    Scope(state: \.CCSelectionState, action: /Action.CCSelectionAction){
      CCSelection()
    }
    
    Scope(state: \.regionSelectionState, action: /Action.regionSelectionAction){
      RegionSelection()
    }
  }
  
  @Dependency(\.appService.profileService) var profileService
  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.logger) var logger
}

