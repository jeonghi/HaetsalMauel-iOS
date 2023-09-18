//
//  StoryboardInstantiable.swift
//  Eum
//
//  Created by JH Park on 2023/09/14.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

// Storyboard로부터 뷰 컨트롤러를 인스턴스화할 수 있는 프로토콜
protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype T // 연관 타입으로 반환할 뷰 컨트롤러 타입을 지정
    static var defaultFileName: String { get } // 스토리보드 파일 이름 반환
    static func instantiateViewController(_ bundle: Bundle?) -> T // 뷰 컨트롤러 인스턴스화 메서드
}

extension StoryboardInstantiable where Self: UIViewController {
    
    // 스토리보드 파일 이름을 반환하는 계산된 속성
    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    // 스토리보드로부터 뷰 컨트롤러를 인스턴스화하는 메서드
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        
        // 스토리보드로부터 초기 뷰 컨트롤러를 인스턴스화하고 Self 타입으로 다운캐스팅
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
        }
        return vc
    }
}

