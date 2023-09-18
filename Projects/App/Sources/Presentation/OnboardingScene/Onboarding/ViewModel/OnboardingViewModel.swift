//
//  OnboardingViewModel.swift
//  Eum
//
//  Created by JH Park on 2023/09/14.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation

protocol OnboardingViewModelInput {
    func viewDidLoad()
}

protocol OnboardingViewModelOutput {
    
}

typealias OnboardingViewModel = OnboardingViewModelInput & OnboardingViewModelOutput

final class DefaultOnboardingViewModel: OnboardingViewModel {
    
    private let mainQueue: DispatchQueueType
    
    init(
        mainQueue: DispatchQueueType = DispatchQueue.main
    ) {
        self.mainQueue = mainQueue
    }
}

extension DefaultOnboardingViewModel {
    /// 뷰가 로드되었을 때 호출되는 메서드입니다.
    func viewDidLoad() { }
}
