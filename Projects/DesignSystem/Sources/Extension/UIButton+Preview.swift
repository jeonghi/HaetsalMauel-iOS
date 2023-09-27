//
//  UIButton+Preview.swift
//  DesignSystem
//
//  Created by JH Park on 2023/09/22.
//  Copyright © 2023 com.eum. All rights reserved.
//
import UIKit

#if DEBUG
import SwiftUI

@available(iOS 13, *)
extension UIButton {
    private struct Preview: UIViewRepresentable {
        let button: UIButton

        func makeUIView(context: Context) -> UIButton {
            return button
        }

        func updateUIView(_ uiView: UIButton, context: Context) {
            // Update the UIButton if needed
        }
    }

    func toPreview() -> some View {
        Preview(button: self)
    }
}
#endif
