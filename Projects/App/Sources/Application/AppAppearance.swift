//
//  AppAppearance.swift
//  Eum
//
//  Created by JH Park on 2023/09/13.
//  Copyright © 2023 tuist.io. All rights reserved.
//
import Foundation
import UIKit
import UISystem
import DesignSystemFoundation

final class AppAppearance {
  
  static func setupAppearance() {
      setupTabBarAppearance() // 텝 바 설정
      setupNavigationBarAppearance() // 내비게이션 바 설정
      //setupToolBarAppearance() // 툴 바 설정
  }
}

// MARK: 내비게이션 바 외형 설정
extension AppAppearance {
  private static func setupNavigationBarAppearance() {
    
    let appearance = UINavigationBarAppearance()
    let navigationBar = UINavigationBar()
    
    let backButtonImage = ImageAsset.뒤로가기.toUIImage()
    appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
    appearance.configureWithTransparentBackground()
    UINavigationBar.appearance().backIndicatorImage = backButtonImage
    UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
    navigationBar.tintColor = .white
    navigationBar.standardAppearance = appearance;
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
  }
}

// MARK: 탭 바 외형 설정
extension AppAppearance {
  private static func setupTabBarAppearance() {
    let tabBarAppearance = UITabBar.appearance()

    tabBarAppearance.shadowImage = UIImage()
    tabBarAppearance.backgroundImage = UIImage()
    tabBarAppearance.isTranslucent = true
    tabBarAppearance.backgroundColor = .white
    
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

