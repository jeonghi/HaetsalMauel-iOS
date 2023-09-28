//
//  View+ShadowAsset.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/25.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//

import SwiftUI

extension View {
    func shadowAsset(_ asset: ShadowAsset) -> some View {
        self.shadow(color: asset.color.opacity(asset.opacity), radius: asset.blurRadius, x: asset.x, y: asset.y)
    }
}
