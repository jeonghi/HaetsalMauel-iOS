//
//  DashBoard.swift
//  App
//
//  Created by JH Park on 2023/09/29.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI
import UISystem

import SwiftUI

struct DashBoard: View {

    // 1. Define a grid layout for 1 row and 3 columns
    private var gridLayout: [GridItem] = Array(repeating: .init(.fixed(100)), count: 3)

    var body: some View {
        // 2. Use LazyHGrid to place the labels in the defined grid
        LazyVGrid(columns: gridLayout, spacing: 0) {
            DashBoardLabel(icon: .pencil, title: "잔여 햇살", subtitle: "20")
                .dashBoardLabelStyle(.homeDashBoard)

            DashBoardLabel(icon: .pencil, title: "누적 사용 햇살", subtitle: "50")
                .dashBoardLabelStyle(.homeDashBoard)

            DashBoardLabel(icon: .pencil, title: "우리 마을 상위", subtitle: "20.2%")
                .dashBoardLabelStyle(.homeDashBoard)
        }
        .padding(.horizontal, 19.5)
        .padding(.vertical, 20)
    }
}


struct DashBoard_Previews: PreviewProvider {
  static var previews: some View {
    DashBoard()
  }
}
