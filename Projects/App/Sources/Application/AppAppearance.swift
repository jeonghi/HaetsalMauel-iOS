//
//  AppAppearance.swift
//  Eum
//
//  Created by JH Park on 2023/09/13.
//  Copyright © 2023 tuist.io. All rights reserved.
//
import Foundation
import UIKit

final class AppAppearance {
    
    static func setupAppearance() {
        if #available(iOS 15, *) {
            // iOS 15 이상에서는 UINavigationBarAppearance을 사용하여 네비게이션 바 스타일 설정
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground() // 배경 설정
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black] // 타이틀 텍스트 색상 설정
            appearance.backgroundColor = UIColor.white
            UINavigationBar.appearance().standardAppearance = appearance // 일반적인 상태의 스타일 설정
            UINavigationBar.appearance().scrollEdgeAppearance = appearance // 스크롤된 엣지의 스타일 설정
        } else {
            // iOS 15 미만에서는 기존 방식으로 네비게이션 바 스타일 설정
            UINavigationBar.appearance().barTintColor = .white // 네비게이션 바 배경색 설정
            UINavigationBar.appearance().tintColor = .black // 아이템 색상 설정 (버튼 등)
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black] // 타이틀 텍스트 색상
        }
    }
}

extension UINavigationController {
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // 상태바 스타일 설정 (흰색 텍스트 등)ggg
    }
}
