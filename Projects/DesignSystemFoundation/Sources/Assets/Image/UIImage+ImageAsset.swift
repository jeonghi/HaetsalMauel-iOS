//
//  UIImage+Asset.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/25.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//
import UIKit

extension UIImage {
    convenience init(_ asset: ImageAsset) {
        self.init(cgImage: asset.toUIImage().cgImage!)
    }
}
