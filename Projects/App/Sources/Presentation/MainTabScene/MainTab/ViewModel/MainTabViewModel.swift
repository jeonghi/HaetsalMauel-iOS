//
//  MainTabViewModel.swift
//  App
//
//  Created by JH Park on 2023/09/19.
//  Copyright © 2023 com.eum. All rights reserved.
//

import Foundation

protocol MainTabViewModelInput {
    func viewDidLoad()
}

protocol MainTabViewModelOutput {
    
}

typealias MainTabViewModel = MainTabViewModelInput & MainTabViewModelOutput

final class DefaultMainTabViewModel: MainTabViewModel {
    
    private let mainQueue: DispatchQueueType
    
    init(
        mainQueue: DispatchQueueType = DispatchQueue.main
    ) {
        self.mainQueue = mainQueue
    }
}

extension DefaultMainTabViewModel {
    /// 뷰가 로드되었을 때 호출되는 메서드입니다.
    func viewDidLoad() { }
}
