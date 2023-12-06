//
//  RegionSelectionCore.swift
//  App
//
//  Created by 쩡화니 on 12/1/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import ComposableArchitecture
import Combine
import EumNetwork

struct RegionSelection: Reducer {
  
  struct State {
    
    var allRegionIsSelected: Bool {
      guard let _ = selectedSI, let _ = selectedGU, let _ = selectedDONG else {
        return false
      }
      return true
    }
    
    var regionList: [RegionEntity.Response] = []
    
    var listSI: [RegionEntity.Response] {
      regionList.filter({$0.regionType == .시})
    }
    
    var listGU: [RegionEntity.Response] {
      guard let SI = selectedSI else {
        return []
      }
      return regionList.filter({$0.regionType == .구 && $0.parentId == SI.regionId})
    }
    var listDONG: [RegionEntity.Response] {
      guard let GU = selectedGU else {
        return []
      }
      return regionList.filter({$0.regionType == .동 && $0.parentId == GU.regionId})
    }
    
    var selectedSI: RegionEntity.Response?
    var selectedGU: RegionEntity.Response?
    var selectedDONG: RegionEntity.Response?
  }
  
  
  enum Action {
    case onAppear
    case onDisappear
    
    case selectSI(RegionEntity.Response?)
    case selectGU(RegionEntity.Response?)
    case selectDONG(RegionEntity.Response?)
    
    /// 네트워크
    case requestRegionList
    case requestRegionListResponse(Result<[RegionEntity.Response]?, HTTPError>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .send(.requestRegionList)
      case .onDisappear:
        return .none
        
      case .selectSI(let selected):
        state.selectedSI = selected
        return .merge(.send(.selectGU(nil)))
      case .selectGU(let selected):
        state.selectedGU = selected
        return .merge(.send(.selectDONG(nil)))
      case .selectDONG(let selected):
        state.selectedDONG = selected
        return .none
        
        /// 네트워크
      case .requestRegionList:
        return .publisher {
          regionService.readRegions(RegionEntity.Params(type: nil))
            .receive(on: mainQueue)
            .map{Action.requestRegionListResponse(.success($0))}
            .catch{Just(Action.requestRegionListResponse(.failure($0)))}
        }
        
      case .requestRegionListResponse(.success(let res)):
        guard let res = res else {
          state.regionList = []
          return .none
        }
        state.regionList = res
        logger.log(.debug, res)
        return .none
      case .requestRegionListResponse(.failure(let error)):
        logger.log(.error, error)
        return .none
      }
    }
  }
  
  @Dependency(\.appService.regionService) var regionService
  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.logger) var logger
}

