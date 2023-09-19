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
        setupTabBarAppearance() // 텝 바 설정
        setupNavigationBarAppearance() // 내비게이션 바 설정
        setupToolBarAppearance() // 툴 바 설정
    }
}

// MARK: 내비게이션 바 외형 설정
extension AppAppearance {
    private static func setupNavigationBarAppearance() {
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

// MARK: 탭 바 외형 설정
extension AppAppearance {
    private static func setupTabBarAppearance() {
        let tabBarAppearance = UITabBar.appearance()
        
        tabBarAppearance.tintColor = UIColor.blue // 선택된 아이템의 색상
        tabBarAppearance.barTintColor = UIColor.white // 탭 바의 배경색
        tabBarAppearance.isTranslucent = false // 탭 바의 투명도
        
        if #available(iOS 15, *) {
            let tabBarStandardAppearance = UITabBarAppearance()
            tabBarStandardAppearance.configureWithDefaultBackground()
            tabBarStandardAppearance.backgroundColor = UIColor.white
            tabBarAppearance.standardAppearance = tabBarStandardAppearance
        }
    }
}

extension AppAppearance {
    private static func setupToolBarAppearance() {
        let toolBarAppearance = UIToolbar.appearance()
        
        toolBarAppearance.tintColor = UIColor.blue  // 툴바 아이템 색상
        toolBarAppearance.barTintColor = UIColor.white  // 툴바 배경색
        toolBarAppearance.isTranslucent = false  // 툴바의 투명도
        
        if #available(iOS 15, *) {
            let toolBarStandardAppearance = UIToolbarAppearance()
            toolBarStandardAppearance.configureWithDefaultBackground()
            toolBarStandardAppearance.backgroundColor = UIColor.white
            toolBarAppearance.standardAppearance = toolBarStandardAppearance
        }
    }
}

extension UINavigationController {
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // 상태바 스타일 설정 (흰색 텍스트 등)ggg
    }
}

#if DEBUG
import SwiftUI

struct AppAppearancePreview: PreviewProvider {
    static var previews: some View {
        Group {
            TabBarPreviewWrapper()
                .previewLayout(.fixed(width: 400, height: 100))
                .previewDisplayName("Tab Bar Preview")
            
            ToolBarPreviewWrapper()
                .previewLayout(.fixed(width: 400, height: 100))
                .previewDisplayName("Tool Bar Preview")
        }
    }
}

// Tab Bar Preview
struct TabBarPreviewWrapper: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        AppAppearance.setupAppearance() // apply appearance settings
        
        let tabBar = UITabBar(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        let tabItem1 = UITabBarItem(title: "홈", image: nil, tag: 0)
        let tabItem2 = UITabBarItem(title: "설정", image: nil, tag: 1)
        tabBar.items = [tabItem1, tabItem2]
        
        view.addSubview(tabBar)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // update UI if needed
    }
}

// Tool Bar Preview
struct ToolBarPreviewWrapper: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        AppAppearance.setupAppearance() // apply appearance settings
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        let barItem1 = UIBarButtonItem(title: "메뉴", style: .plain, target: nil, action: nil)
        let barItem2 = UIBarButtonItem(title: "설정", style: .plain, target: nil, action: nil)
        toolbar.items = [barItem1, UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), barItem2]
        
        view.addSubview(toolbar)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // update UI if needed
    }
}
#endif
