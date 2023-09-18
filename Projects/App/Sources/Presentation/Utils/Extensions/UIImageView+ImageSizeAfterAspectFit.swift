//
//  UIImageView+ImageSizeAfterAspectFit.swift
//  Eum
//
//  Created by JH Park on 2023/09/14.
//  Copyright © 2023 tuist.io. All rights reserved.
//
import Foundation
import UIKit

extension UIImageView {
    
    // 이미지가 Aspect Fit 모드로 조정된 후의 크기를 계산하여 반환하는 계산된 속성
    var imageSizeAfterAspectFit: CGSize {
        var newWidth: CGFloat
        var newHeight: CGFloat
        
        // 이미지가 nil이면 현재 이미지 뷰의 크기를 반환
        guard let image = image else { return frame.size }
        
        // 이미지의 세로 길이가 가로 길이보다 큰 경우
        if image.size.height >= image.size.width {
            newHeight = frame.size.height
            newWidth = ((image.size.width / image.size.height) * newHeight)
            
            // 새로 계산된 너비가 이미지 뷰의 가로 길이보다 큰 경우
            if newWidth > frame.size.width {
                let diff = frame.size.width - newWidth
                newHeight = newHeight + CGFloat(diff) / newHeight * newHeight
                newWidth = frame.size.width
            }
        } else { // 이미지의 가로 길이가 세로 길이보다 큰 경우
            newWidth = frame.size.width
            newHeight = (image.size.height / image.size.width) * newWidth
            
            // 새로 계산된 높이가 이미지 뷰의 세로 길이보다 큰 경우
            if newHeight > frame.size.height {
                let diff = Float(frame.size.height) - Float(newHeight)
                newWidth = newWidth + CGFloat(diff) / newWidth * newWidth
                newHeight = frame.size.height
            }
        }
        
        // 새로 계산된 이미지 크기를 CGSize 형태로 반환
        return CGSize(width: newWidth, height: newHeight)
    }
}

