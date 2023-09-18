//
//  OnboardingViewController.swift
//  Eum
//
//  Created by JH Park on 2023/09/14.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

final class OnboardingViewController: UIViewController, StoryboardInstantiable, Alertable {
    
//    @IBOutlet private var skipButton: UIButton!
//    @IBOutlet private var startButton: UIButton!
    
    private var viewModel: OnboardingViewModel!
    
    // MARK: - Lifecycle
    static func create(
        with viewModel: OnboardingViewModel
    ) -> OnboardingViewController {
        let view = OnboardingViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBehaviours()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: OnboardingViewModel) {
        
    }
    
    // MARK: - Private
    private func setupViews() {
        
    }
    
    private func setupBehaviours() {
//        addBehaviors([BackButtonEmptyTitleNavigationBarBehavior(),
//                      BlackStyleNavigationBarBehavior()])
    }

}
