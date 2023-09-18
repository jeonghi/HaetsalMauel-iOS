//
//  UIViewController+AddChild.swift
//  Eum
//
//  Created by JH Park on 2023/09/14.
//  Copyright © 2023 tuist.io. All rights reserved.
//
import UIKit

extension UIViewController {
    
    // 다른 UIViewController를 현재 UIViewController에 자식으로 추가하는 메서드
    func add(child: UIViewController, container: UIView) {
        // 자식 UIViewController를 현재 UIViewController에 추가
        addChild(child)
        
        // 자식 UIViewController의 뷰를 컨테이너의 경계에 맞추고, 컨테이너에 추가
        child.view.frame = container.bounds
        container.addSubview(child.view)
        
        // 자식 UIViewController의 추가가 완료되었음을 알림
        child.didMove(toParent: self)
    }
    
    // 현재 UIViewController를 부모에서 제거하는 메서드
    func remove() {
        // 현재 UIViewController가 부모에 속해있는지 확인
        guard parent != nil else {
            return // 부모가 없다면 종료
        }
        
        // UIViewController가 부모에서 제거될 예정임을 알림
        willMove(toParent: nil)
        
        // UIViewController를 부모에서 제거
        removeFromParent()
        
        // UIViewController의 뷰를 화면에서 제거
        view.removeFromSuperview()
    }
}

