//
//  ColorAsset.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/24.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//

import UIKit
import SwiftUI

#if canImport(AppKit)
import AppKit
#endif

public struct ColorAsset {
    
    enum ColorType {
        case literal
        case asset(named: String, bundler: Bundle?)
    }
    
    var red: Double
    var green: Double
    var blue: Double
    var alpha: Double
    var colorType: ColorType
    
    public init(red: Double, green: Double, blue: Double, alpha: Double) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
        self.colorType = .literal
    }
    
    public init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        
        Scanner(string: hex).scanHexInt64(&int)
        
        let r = Double((int >> 16) & 0xFF) / 255.0
        let g = Double((int >> 8) & 0xFF) / 255.0
        let b = Double(int & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    public init(named: String, bundle: Bundle? = nil, alpha: Double = 1.0) {
        let color = UIColor(named: named, in: bundle, compatibleWith: nil)
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        
        color?.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: alpha)
    }
}

public extension ColorAsset {
    // Convert to SwiftUI's Color
    func toColor() -> Color {
        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }

    // Convert to UIKit's UIColor
    func toUIColor() -> UIColor {
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }

    #if canImport(AppKit)
    // Convert to AppKit's NSColor (only if AppKit is available, e.g. macOS platform)
    func toNSColor() -> NSColor {
        return NSColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
    #endif
}

extension ColorAsset {
    static let primary: ColorAsset = ColorAsset(named: "")
}
