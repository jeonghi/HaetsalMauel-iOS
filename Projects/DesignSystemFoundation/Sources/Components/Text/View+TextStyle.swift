//
//  View+TextStyle.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/29.
//  Copyright © 2023 com.eum. All rights reserved.
//

import SwiftUI

public struct TextStyleModifier: ViewModifier {
    var style: TextStyle
    
    public func body(content: Content) -> some View {
        content
            .font(style.font)
            .foregroundColor(style.color)
    }
}

extension View {
    public func textStyle(_ style: TextStyle) -> some View {
        self.modifier(TextStyleModifier(style: style))
    }
}
