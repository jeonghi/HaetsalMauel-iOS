//
//  UIFont+Extension.swift
//  DesignSystem
//
//  Created by JH Park on 2023/09/18.
//  Copyright © 2023 com.eum. All rights reserved.
//

import UIKit

public extension UIFont {
    
    static func fontWithName(size: Font.Size, weight: Font.Weight) -> UIFont {
        var fontName = ""
        switch weight {
        case .bold:
            fontName = "Pretendard-Bold"
        case .regular:
            fontName = "Pretendard-Regular"
        }
        
        return UIFont(name: fontName, size: size.rawValue) ?? UIFont.systemFont(ofSize: size.rawValue)
    }
    
    static func eumFont(size: Font.Size, weight: Font.Weight) -> UIFont {
        return fontWithName(size: size, weight: weight)
    }
}
