//
//  Font+FontAsset.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/25.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//

import SwiftUI
import UIKit

extension Font {
    init(_ asset: FontAsset) {
        if let leading = asset.leading {
            self = Font.custom(asset.config.fontName(), size: asset.size, relativeTo: .body)
        } else {
            self = Font.custom(asset.config.fontName(), size: asset.size)
        }
    }
}
