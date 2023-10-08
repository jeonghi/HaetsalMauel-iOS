//
//  UIColor+Asset.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/25.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//

import UIKit

public extension UIColor {
    convenience init(_ asset: ColorAsset) {
        let uiColor = asset.toUIColor()
        self.init(cgColor: uiColor.cgColor)
    }
}
