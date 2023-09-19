//
//  CommunityDIContainer.swift
//  Eum
//
//  Created by JH Park on 2023/09/14.
//  Copyright © 2023 tuist.io. All rights reserved.
//
import UIKit

class CommunitySceneDIContainer {
    
    struct Dependencies {
        
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeSceneViewController() -> UIViewController {
        // TODO: 홈 VC로 추후 변경
        // let viewModel = makeViewModel
        // return CommunityViewController(viewModel: viewModel)
        return UIViewController()
    }
    
    private func makeViewModel() {
        // TODO: 홈 VM로 추후 변경
    }
}
