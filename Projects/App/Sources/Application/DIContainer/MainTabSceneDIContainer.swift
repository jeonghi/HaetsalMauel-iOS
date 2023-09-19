//
//  TabBarSceneDIContainer.swift
//  Eum
//
//  Created by JH Park on 2023/09/14.
//  Copyright © 2023 tuist.io. All rights reserved.
//
import UIKit

final class MainTabSceneDIContainer: MainTabFlowCoordinatorDependencies {

    struct Dependencies {
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func makeMainTabViewController() -> MainTabViewController {
        let homeVC = makeHomeSceneDIContainer().makeSceneViewController()
        let communityVC = makeCommunitySceneDIContainer().makeSceneViewController()
        let payVC = makePaySceneDIContainer().makeSceneViewController()
        let settingVC = makeSettingsSceneDIContainer().makeSceneViewController()
        
        let mainTabViewController = MainTabViewController.create(
            with: makeMainTabViewModel(),
            homeVC: homeVC,
            communityVC: communityVC,
            payVC: payVC,
            settingVC: settingVC
        )
        
        return mainTabViewController
    }
    
    private func makeMainTabViewModel() -> MainTabViewModel {
        let viewModel = DefaultMainTabViewModel()
        return viewModel
    }
    
    func makeHomeSceneDIContainer() -> HomeSceneDIContainer {
        let dependencies = HomeSceneDIContainer.Dependencies()
        return HomeSceneDIContainer(dependencies: dependencies)
    }

    func makeCommunitySceneDIContainer() -> CommunitySceneDIContainer {
        let dependencies = CommunitySceneDIContainer.Dependencies()
        return CommunitySceneDIContainer(dependencies: dependencies)
    }

    func makePaySceneDIContainer() -> PaySceneDIContainer {
        let dependencies = PaySceneDIContainer.Dependencies()
        return PaySceneDIContainer(dependencies: dependencies)
    }

    func makeSettingsSceneDIContainer() -> SettingSceneDIContainer {
        let dependencies = SettingSceneDIContainer.Dependencies()
        return SettingSceneDIContainer(dependencies: dependencies)
    }
    
    func makeMainTabFlowCoordinator(navigationController: UINavigationController) -> MainTabFlowCoordinator {
        MainTabFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}
