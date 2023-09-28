//
//  Image+Asset.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/25.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//
import SwiftUI

extension Image {
    init(_ asset: ImageAsset){
        self = asset.toImage()
    }
}
