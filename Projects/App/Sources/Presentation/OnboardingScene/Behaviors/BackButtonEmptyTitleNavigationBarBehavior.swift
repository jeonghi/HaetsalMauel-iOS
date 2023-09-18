//
//  BackButtonEmptyTitleNavigationBarBehavior.swift
//  Eum
//
//  Created by JH Park on 2023/09/14.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

struct BackButtonEmptyTitleNavigationBarBehavior: ViewControllerLifecycleBehavior {
    
    func viewDidLoad(viewController: UIViewController) {
        
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
    }
}
