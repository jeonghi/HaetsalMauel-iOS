//
//  EnvironmentKey+DashBoardLebel.swift
//  UISystem
//
//  Created by JH Park on 2023/09/29.
//  Copyright © 2023 com.eum. All rights reserved.
//

import Foundation
import SwiftUI

private struct DashBoardLabelStyleKey: EnvironmentKey {
    static let defaultValue: DashBoardLabelStyle = .homeDashBoard
}

extension EnvironmentValues {
    var dashBoardLabelStyle: DashBoardLabelStyle {
        get { self[DashBoardLabelStyleKey.self] }
        set { self[DashBoardLabelStyleKey.self] = newValue }
    }
}
