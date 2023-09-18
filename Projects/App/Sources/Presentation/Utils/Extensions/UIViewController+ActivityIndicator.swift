//
//  UIViewController+ActivityIndicator.swift
//  Eum
//
//  Created by JH Park on 2023/09/14.
//  Copyright © 2023 tuist.io. All rights reserved.
//
import UIKit

extension UITableViewController {
    
    // UIActivityIndicatorView를 생성하여 반환하는 메서드
    func makeActivityIndicator(size: CGSize) -> UIActivityIndicatorView {
        var style: UIActivityIndicatorView.Style
        
        // iOS 12 이상인 경우, 사용자 인터페이스 스타일에 따라 스타일을 설정
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                style = .white
            } else {
                style = .gray
            }
        } else {
            // iOS 12 미만인 경우, 항상 .gray 스타일로 설정
            style = .gray
        }

        // 설정된 스타일로 UIActivityIndicatorView 생성
        let activityIndicator = UIActivityIndicatorView(style: style)
        
        // 애니메이션 시작 및 화면에 표시
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        // 크기 및 위치 설정
        activityIndicator.frame = CGRect(origin: .zero, size: size)

        return activityIndicator // 생성된 UIActivityIndicatorView 반환
    }
}

