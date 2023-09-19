//
//  UIView+AddSub.swift
//  App
//
//  Created by JH Park on 2023/09/19.
//  Copyright © 2023 com.eum. All rights reserved.
//

import UIKit

extension UIView {
    
    public func addSubViews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
}
