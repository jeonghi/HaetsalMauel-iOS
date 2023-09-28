//
//  ShadowAsset.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/24.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//

import Foundation
import SwiftUI

public struct ShadowAsset {
    var color: Color
    var opacity: Double
    var x: Double
    var y: Double
    var blurRadius: Double
    var spread: Double
}

extension ShadowAsset {
    static let level1 = ShadowAsset(color: .black, opacity: 0.1, x: 0, y: 1, blurRadius: 1, spread: 0)
    static let level2 = ShadowAsset(color: .black, opacity: 0.2, x: 0, y: 2, blurRadius: 2, spread: 0)
    // ... add other predefined shadows
}
