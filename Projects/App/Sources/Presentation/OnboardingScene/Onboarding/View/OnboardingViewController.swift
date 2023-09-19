//
//  OnboardingViewController.swift
//  Eum
//
//  Created by JH Park on 2023/09/14.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit
import SnapKit
import DesignSystem

final class OnboardingViewController: UIViewController, Alertable {
    
    private let titleStackView = UIStackView() // 타이틀 스택뷰
    private let mainTitleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    private let skipButton = UIButton() // 둘러보기
    
    private let loginStackView = UIStackView() // 로그인 스택뷰
    private let localLoginButton = UIButton() // 자체 로그인
    private let kakaoLoginButton = UIButton() // 카카오 로그인
    private let appleLoginButton = UIButton() // 애플 로그인
    
    private var viewModel: OnboardingViewModel!
    
    // MARK: - Lifecycle
    static func create(
        with viewModel: OnboardingViewModel
    ) -> OnboardingViewController {
        let view = OnboardingViewController()
        view.viewModel = viewModel
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
    
    private func bind(to viewModel: OnboardingViewModel) {
        
    }
    
    // MARK: - Private
    private func setupViews() {
        
        view.backgroundColor = .systemBackground
        
        // 라벨 설정
        titleStackView.axis = .vertical
        titleStackView.spacing = 16
        mainTitleLabel.text = "지역을 하나로 이어주는 나눔 플랫폼 이음"
        mainTitleLabel.tintColor = .black
        subTitleLabel.text = "이웃이랑 함께 정을 나눠요"
        
        // 둘러보기 버튼 설정
        skipButton.backgroundColor = .systemGray
        
        // 로그인 스택뷰 설정
        loginStackView.axis = .vertical
        loginStackView.spacing = 12
        
        // 로그인 버튼 설정
        localLoginButton.backgroundColor = .systemBlue
        kakaoLoginButton.backgroundColor = .systemBlue
        appleLoginButton.backgroundColor = .systemBlue
    }
    
    private func setupLayout() {
        view.addSubViews([titleStackView, skipButton, loginStackView])
        titleStackView.addArrangedSubviews([mainTitleLabel, subTitleLabel])
        loginStackView.addArrangedSubviews([localLoginButton, kakaoLoginButton, appleLoginButton])
        
        titleStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(72)
            make.leading.trailing.equalToSuperview().inset(22)
        }
        
        skipButton.snp.makeConstraints { make in
            make.bottom.equalTo(loginStackView.snp.top).offset(-78)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        loginStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50) // 하단 -50
            make.leading.trailing.equalToSuperview().inset(15) // 좌우 10
        }
        
        localLoginButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
    }
    
    // vc의 특정 동작이나 스타일 등을 설정
    private func setupBehaviours() {
//        addBehaviors([BackButtonEmptyTitleNavigationBarBehavior(),
//                      BlackStyleNavigationBarBehavior()])
    }

}

#if DEBUG
import SwiftUI

struct OnboardingViewPreview: PreviewProvider {

    static var previews: some View {

        let viewModel = DefaultOnboardingViewModel()
        return OnboardingViewController.create(with: viewModel).toPreview()
    }

}
#endif
