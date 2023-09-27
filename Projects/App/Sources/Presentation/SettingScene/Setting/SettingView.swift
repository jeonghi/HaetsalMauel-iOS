//
//  SettingView.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct SettingView: View {

    typealias Core = Setting
    typealias State = Core.State
    typealias Action = Core.Action
    typealias Route = Core.Route

    private let store: StoreOf<Core>

    struct ViewState: Equatable {
        init(state: State){
            
        }
    }
    
    init(store: StoreOf<Core>){
        self.store = store
    }

    var body: some View {
        // 여기에 작성
        VStack(spacing: 0){
            Text("설정화면")
        }
        .navigationBarTitle("설정")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(initialState: Setting.State()){
            Setting()
        }
        SettingView(store: store)
    }
}
