//
//  Font.swift
//  DesignSystem
//
//  Created by JH Park on 2023/09/18.
//  Copyright © 2023 com.eum. All rights reserved.
//

import UIKit

public enum Font {
    
    public enum Size: CGFloat {
        case largeTitle = 30
        case title = 24
        case header = 20
        case sub = 16
        case description = 12
    }
    
    public enum Weight {
        case regular
        case bold
        
        var value: UIFont.Weight {
            switch self {
            case .regular:
                return .regular
            case .bold:
                return .bold
            }
        }
    }
}
