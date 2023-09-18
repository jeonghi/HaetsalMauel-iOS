//
//  OnboardingSceneCoordinator.swift
//  Eum
//
//  Created by JH Park on 2023/09/14.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

protocol OnboardingFlowCoordinatorDependencies {
    func makeOnboardingViewController(
    ) -> OnboardingViewController
    func makeSignUpViewController(
    ) -> UIViewController
    func makeSignInViewController(
    ) -> UIViewController
}

final class OnboardingFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: OnboardingFlowCoordinatorDependencies
    
    private weak var onboardingVC: OnboardingViewController?
    private weak var signupVC: UIViewController?
    private weak var signinVC: UIViewController?
    
    init(
        navigationController: UINavigationController,
        dependencies: OnboardingFlowCoordinatorDependencies
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makeOnboardingViewController()
        navigationController?.pushViewController(vc, animated: false)
        onboardingVC = vc
    }
    
    private func showSignUp() {
        let vc = dependencies.makeSignUpViewController()
    }
    
    private func showSignIn() {
        let vc = dependencies.makeSignInViewController()
    }
    
    private func closeSignUp() {
        
    }
    
    private func closeSignIn() {
        
    }
}
