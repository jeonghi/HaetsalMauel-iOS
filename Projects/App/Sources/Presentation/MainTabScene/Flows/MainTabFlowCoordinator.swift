//
//  MainTabFlowCoordinator.swift
//  App
//
//  Created by JH Park on 2023/09/19.
//  Copyright © 2023 com.eum. All rights reserved.
//

import UIKit

protocol MainTabFlowCoordinatorDependencies {
    func makeMainTabViewController(
    ) -> MainTabViewController
}

final class MainTabFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: MainTabFlowCoordinatorDependencies
    
    private weak var mainTabVC: MainTabViewController?
    
    init(
        navigationController: UINavigationController,
        dependencies: MainTabFlowCoordinatorDependencies
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makeMainTabViewController()
        navigationController?.pushViewController(vc, animated: false)
        mainTabVC = vc
    }
}

