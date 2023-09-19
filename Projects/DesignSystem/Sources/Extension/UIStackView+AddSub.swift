//
//  UIStackView+AddSub.swift
//  DesignSystem
//
//  Created by JH Park on 2023/09/19.
//  Copyright © 2023 com.eum. All rights reserved.
//

import UIKit

extension UIStackView {
    
    public func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
    
}
