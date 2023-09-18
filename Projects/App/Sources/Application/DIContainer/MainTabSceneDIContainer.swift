//
//  TabBarSceneDIContainer.swift
//  Eum
//
//  Created by JH Park on 2023/09/14.
//  Copyright © 2023 tuist.io. All rights reserved.
//
import UIKit

class MainTabSceneDIContainer {
    
    struct Dependencies {
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeMainTabController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = []
        
        return tabBarController
    }
}
