//
//  AppDIContainer.swift
//  Eum
//
//  Created by JH Park on 2023/09/13.
//  Copyright © 2023 tuist.io. All rights reserved.
//
import Foundation

// AppDIContainer 클래스: 앱의 의존성 주입(DI)을 담당하는 클래스
final class AppDIContainer {
    
    // 앱 설정을 관리하는 인스턴스
    lazy var appConfiguration = AppConfiguration()
    
    // 네트워크 관련 의존성을 설정하는 부분
    
    // API 데이터 전송 서비스를 설정
    
    // 이미지 데이터 전송 서비스를 설정
    
    // 각각의 Scene의 DIContainer를 생성하는 메서드
    func makeOnboardingSceneDIContainer() -> OnboardingSceneDIContainer {
        
        let dependencies = OnboardingSceneDIContainer.Dependencies()
        
        return OnboardingSceneDIContainer(dependencies: dependencies)
    }
    
    func makeMainTabSceneDIContainer() -> MainTabSceneDIContainer {
        
        let dependencies = MainTabSceneDIContainer.Dependencies()
        
        return MainTabSceneDIContainer(dependencies: dependencies)
    }
    
}

