//
//  MainTabViewController.swift
//  App
//
//  Created by JH Park on 2023/09/19.
//  Copyright © 2023 com.eum. All rights reserved.
//
import UIKit

final class MainTabViewController: UIViewController {
    
    private var customTabBarController = UITabBarController()

    private var homeVC: UIViewController!
    private var communityVC: UIViewController!
    private var payVC: UIViewController!
    private var settingVC: UIViewController!
    
    private var viewModel: MainTabViewModel!
    
    // MARK: - Lifecycle
    static func create(
        with viewModel: MainTabViewModel,
        homeVC: UIViewController,
        communityVC: UIViewController,
        payVC: UIViewController,
        settingVC: UIViewController
    ) -> MainTabViewController {
        let view = MainTabViewController()
        view.viewModel = viewModel
        view.homeVC = homeVC
        view.communityVC = communityVC
        view.payVC = payVC
        view.settingVC = settingVC
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupBehaviours()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: MainTabViewModel) {
    }
    
    // MARK: - Private
    private func setupViews() {
        
        // TabBar 아이템 설정
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: nil, tag: 0)
        communityVC.tabBarItem = UITabBarItem(title: "커뮤니티", image: nil, tag: 1)
        payVC.tabBarItem = UITabBarItem(title: "페이", image: nil, tag: 2)
        settingVC.tabBarItem = UITabBarItem(title: "설정", image: nil, tag: 3)
        
        // 탭바 컨트롤러에 뷰 컨트롤러를 할당
        customTabBarController.setViewControllers( [homeVC, communityVC, payVC, settingVC], animated: true)
    }
    
    private func setupLayout() {
        addChild(customTabBarController)
        view.addSubview(customTabBarController.view)
        customTabBarController.didMove(toParent: self)
    }
    
    // vc의 특정 동작이나 스타일 등을 설정
    private func setupBehaviours() {
    }
}

#if DEBUG
import SwiftUI

struct MainTabViewPreview: PreviewProvider {
    
    static var previews: some View {
        
        let viewModel = DefaultMainTabViewModel()
        
        let homeVC = UINavigationController()
        let communityVC = UINavigationController()
        let payVC = UINavigationController()
        let settingsVC = UINavigationController()
        
        return MainTabViewController.create(
            with: viewModel,
            homeVC: homeVC,
            communityVC: communityVC,
            payVC: payVC,
            settingVC: settingsVC
        ).toPreview()
    }
    
}
#endif
