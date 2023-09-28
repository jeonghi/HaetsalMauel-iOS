//
//  UIView+ShadowAsset.swift
//  DesignSystemFoundation
//
//  Created by JH Park on 2023/09/25.
//  Copyright © 2023 kr.tagotago. All rights reserved.
//

import UIKit

extension UIView {
    func shadowAsset(_ asset: ShadowAsset) {
        layer.shadowColor = UIColor(asset.color).cgColor
        layer.shadowOpacity = Float(asset.opacity)
        layer.shadowOffset = CGSize(width: asset.x, height: asset.y)
        layer.shadowRadius = CGFloat(asset.blurRadius)
        
        if asset.spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -asset.spread
            let rect = layer.bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
