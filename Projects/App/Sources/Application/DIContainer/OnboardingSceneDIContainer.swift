//
//  OnboardingSceneDIContainer.swift
//  Eum
//
//  Created by JH Park on 2023/09/14.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation
import UIKit

final class OnboardingSceneDIContainer: OnboardingFlowCoordinatorDependencies {
    
    struct Dependencies {
        
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies){
        self.dependencies = dependencies
    }
    
    func makeOnboardingViewController() -> OnboardingViewController {
        OnboardingViewController.create(
            with: makeOnboardingViewModel()
        )
    }
    
    func makeOnboardingViewModel() -> OnboardingViewModel {
        DefaultOnboardingViewModel()
    }
    
    func makeSignUpViewController() -> UIViewController {
        let vc = UIViewController()
        return vc
    }
    
    func makeSignInViewController() -> UIViewController {
        let vc = UIViewController()
        return vc
    }
    
    func makeOnboardingFlowCoordinator(navigationController: UINavigationController) -> OnboardingFlowCoordinator {
        OnboardingFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}
