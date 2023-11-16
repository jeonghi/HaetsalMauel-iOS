//
//  View+Popup.swift
//  UISystem
//
//  Created by 쩡화니 on 11/14/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation
import SwiftUI
import PopupView

public extension View {
  func eumPopup(isShowing: Binding<Bool>, popupContent: @escaping () -> some View) -> some View {
        self.popup(isPresented: isShowing) {
          popupContent()
            .padding(.horizontal, 8)
        } customize: {
            $0
                .isOpaque(true)
                .position(.center)
                .animation(.easeInOut)
                .closeOnTapOutside(true)
                .backgroundColor(Color.black.opacity(0.5))
        }
    }
}


