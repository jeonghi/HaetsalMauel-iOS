//
//  View+DashBoardLabelStyle.swift
//  UISystem
//
//  Created by JH Park on 2023/09/29.
//  Copyright © 2023 com.eum. All rights reserved.
//

import Foundation
import SwiftUI


//public extension View where Self == DashBoardLabel {
//    func dashBoardLabelStyle(_ style: DashBoardLabelStyle) -> some View {
//        self.modifier(DashBoardLabelStyleModifier(style: style))
//    }
//}
//
//public struct DashBoardLabelStyleModifier: ViewModifier {
//    var style: DashBoardLabelStyle
//
//    public func body(content: Content) -> some View {
//        content
//            .environment(\.dashBoardLabelStyle, style)
//    }
//}

public extension DashBoardLabel {
    func dashBoardLabelStyle(_ style: DashBoardLabelStyle) -> some View {
        self.environment(\.dashBoardLabelStyle, style)
    }
}
