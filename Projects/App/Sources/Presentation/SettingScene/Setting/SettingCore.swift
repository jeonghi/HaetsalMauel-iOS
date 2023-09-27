//
//  SettingCore.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct Setting: Reducer {
    
    struct State {
        var route: Route? = nil
    }
    
    enum Route {

    }
    
    enum Action {
        case setRoute(Route?)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .setRoute(let selectedRoute):
            state.route = selectedRoute
            return .none
        }
    }
}
