//
//  CGSize+ScaledSize.swift
//  Eum
//
//  Created by JH Park on 2023/09/14.
//  Copyright © 2023 tuist.io. All rights reserved.
//
import Foundation
import UIKit

extension CGSize {
    
    // 현재 CGSize를 현재 디바이스의 스케일에 맞춘 CGSize로 변환하는 계산된 속성
    var scaledSize: CGSize {
        // 현재 디바이스의 스케일을 곱한 새로운 width와 height를 가지는 CGSize를 반환
        .init(width: width * UIScreen.main.scale, height: height * UIScreen.main.scale)
    }
}

