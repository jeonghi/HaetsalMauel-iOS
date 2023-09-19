//
//  AppFlowCoordinator.swift
//  Eum
//
//  Created by JH Park on 2023/09/13.
//  Copyright © 2023 tuist.io. All rights reserved.
//
import UIKit

// AppFlowCoordinator 클래스: 앱의 전체적인 흐름을 조정하는 역할을 담당하는 코디네이터 클래스
final class AppFlowCoordinator {
    
    // navigationController: 앱 내에서 화면 전환을 관리하는 네비게이션 컨트롤러
    var navigationController: UINavigationController
    // appDIContainer: 앱의 의존성 주입(DI) 컨테이너
    private let appDIContainer: AppDIContainer
    
    // AppFlowCoordinator의 생성자
    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    // 앱의 시작 지점을 정의하는 메서드
    func start() {
        // App Flow에서는 사용자가 로그인해야 하는지 확인하고, 필요한 경우 로그인 플로우를 실행할 수 있음
        
        // 온보딩
        let onboardingSceneDIContainer = appDIContainer.makeOnboardingSceneDIContainer()
        
        let onboardingFlow = onboardingSceneDIContainer
            .makeOnboardingFlowCoordinator(navigationController: navigationController)
        
//        onboardingFlow.start()
        
        // 메인 탭
        let mainTabSceneDIContainer = appDIContainer.makeMainTabSceneDIContainer()
        let mainTabFlow = mainTabSceneDIContainer.makeMainTabFlowCoordinator(navigationController: navigationController)
        
        mainTabFlow.start()
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct AppFlowCoordinatorPreview: PreviewProvider {
    static var previews: some View {
        let navigationController = UINavigationController()
        let appDIContainer = AppDIContainer()
        let appFlowCoordinator = AppFlowCoordinator(
            navigationController: navigationController,
            appDIContainer: appDIContainer
        )
        
        // 시작 메서드를 호출하여 설정을 완료하고 초기 뷰를 로드한다.
        appFlowCoordinator.start()
        
        return navigationController
            .toPreview()
            .previewLayout(.fixed(width: 400, height: 800))
            .previewDisplayName("App Flow Coordinator Preview")
    }
}
#endif
