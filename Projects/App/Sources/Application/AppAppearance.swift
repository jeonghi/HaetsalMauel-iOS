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
//        setupNavigationBarAppearance() // 내비게이션 바 설정
    //    setupToolBarAppearance() // 툴 바 설정
  }
}

// MARK: 내비게이션 바 외형 설정
extension AppAppearance {
  private static func setupNavigationBarAppearance() {
    
    let appearance = UINavigationBarAppearance()
    let navigationBar = UINavigationBar()
    

    appearance.configureWithTransparentBackground()
    navigationBar.tintColor = .white
    navigationBar.standardAppearance = appearance;
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
  }
}

// MARK: 탭 바 외형 설정
extension AppAppearance {
  private static func setupTabBarAppearance() {
    let tabBarAppearance = UITabBar.appearance()

    let tabBarStandardAppearance = UITabBarAppearance()
    tabBarStandardAppearance.configureWithDefaultBackground()
    tabBarStandardAppearance.backgroundColor = UIColor.white

    // 선택된 탭의 아이콘 색상을 오렌지로 설정
    tabBarStandardAppearance.selectionIndicatorTintColor = UIColor.orange
    
    // 선택된 탭의 아이콘 및 텍스트 색상을 오렌지로 설정
    tabBarAppearance.tintColor = UIColor.orange


    // 선택된 탭의 텍스트 색상을 오렌지로 설정
    let attributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.orange
    ]
    tabBarStandardAppearance.stackedLayoutAppearance.selected.titleTextAttributes = attributes

    tabBarAppearance.standardAppearance = tabBarStandardAppearance
  }
}


extension AppAppearance {
  private static func setupToolBarAppearance() {
    let toolBarAppearance = UIToolbar.appearance()
    
    toolBarAppearance.tintColor = UIColor.orange  // 툴바 아이템 색상
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
