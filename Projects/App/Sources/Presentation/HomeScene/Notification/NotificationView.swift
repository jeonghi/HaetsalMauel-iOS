//
//  NotificationView.swift
//  App
//
//  Created by JH Park on 2023/09/27.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        VStack(spacing: 0){
            ScrollView {
                Text("투두")
            }
        }
        .navigationBarTitle("알림", displayMode: .inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NotificationView()
        }
    }
}
