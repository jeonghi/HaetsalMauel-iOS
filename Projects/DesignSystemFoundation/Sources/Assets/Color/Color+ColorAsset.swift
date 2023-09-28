//
//  Color+ColorAsset.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/25.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//
import SwiftUI

extension Color {
    public init(_ asset: ColorAsset) {
        self = asset.toColor()
    }
}
