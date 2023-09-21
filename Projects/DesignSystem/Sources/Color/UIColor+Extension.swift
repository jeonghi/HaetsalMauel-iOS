//
//  UIColor+Extension.swift
//  DesignSystem
//
//  Created by JH Park on 2023/09/21.
//  Copyright © 2023 com.eum. All rights reserved.
//
import UIKit
import SwiftUI

public extension UIColor {
    static func eumColor(_ color: Palette) -> UIColor? {
        return UIColor(named: color.rawValue, in: Bundle.module, compatibleWith: nil)
    }
    
    static func appearanceColor(light: Palette, dark: Palette) -> UIColor {
        UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                return eumColor(light)!
            case .dark:
                return eumColor(dark)!
            @unknown default:
                return eumColor(light)!
            }
        }
    }
    
    static func aC(_ light: Palette, _ dark: Palette) -> UIColor {
        appearanceColor(light: light, dark: dark)
    }
    
    // SwiftUI.Color 객체로 변환
    func toColor() -> Color {
        Color(self)
    }
}


// MARK: - Semantic Colors

public extension UIColor {
    
    // MARK: - Background
    static let outlinedButtonBackground = appearanceColor(light: .white, dark: .white)
    static let defaultButtonBackground = appearanceColor(light: .green94, dark: .green94)
    static let definedButtonBackground = appearanceColor(light: .greenF9, dark: .greenF9)
    static let otherButtonBackground = appearanceColor(light: .grayE5, dark: .grayE5)
    static let cantButtonBackground = appearanceColor(light: .grayAE, dark: .grayAE)
    
    // MARK: - Label
    static let outlinedButtonLabel = appearanceColor(light: .grayAE, dark: .grayAE)
    static let defaultButtonLabel = appearanceColor(light: .white, dark: .white)
    static let definedButtonLabel = appearanceColor(light: .green94, dark: .green94)
    static let otherButtonLabel = appearanceColor(light: .gray8E, dark: .gray8E)
    static let cantButtonLabel = appearanceColor(light: .white, dark: .white)
    
    // MARK: - Line
    static let outlinedButtonLine = aC(.grayAE, .grayAE)
    
    // MARK: - Icon
}

