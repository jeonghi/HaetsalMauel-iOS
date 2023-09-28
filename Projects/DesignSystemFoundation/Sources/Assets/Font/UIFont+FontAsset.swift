//
//  UIFont+FontAsset.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/25.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//
import UIKit

extension UIFont {
    static func asset(_ asset: FontAsset) -> UIFont {
        guard let font = UIFont(name: asset.config.fontName(), size: asset.size) else {
            fatalError("Failed to load the font: \(asset.config.fontName())")
        }
        return font
    }
}
