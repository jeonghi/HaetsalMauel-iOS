//
//  LoadingView.swift
//  Eum
//
//  Created by JH Park on 2023/09/14.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

class LoadingView {

    // 로딩 화면에 사용할 UIActivityIndicatorView
    internal static var spinner: UIActivityIndicatorView?

    // 로딩 화면을 보여주는 메서드
    static func show() {
        DispatchQueue.main.async {
            // 디바이스의 방향 변경 감지 시 update 메서드를 호출하도록 옵저버 등록
            NotificationCenter.default.addObserver(self, selector: #selector(update), name: UIDevice.orientationDidChangeNotification, object: nil)
            
            // spinner가 없고, UIWindow가 존재할 경우
            if spinner == nil, let window = UIApplication.shared.keyWindow {
                let frame = UIScreen.main.bounds
                let spinner = UIActivityIndicatorView(frame: frame)
                spinner.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                spinner.style = .whiteLarge
                window.addSubview(spinner)
                
                // spinner를 시작하고 spinner를 클래스 속성에 할당
                spinner.startAnimating()
                self.spinner = spinner
            }
        }
    }

    // 로딩 화면을 숨기는 메서드
    static func hide() {
        DispatchQueue.main.async {
            guard let spinner = spinner else { return }
            
            // spinner를 중지하고 화면에서 제거, spinner를 클래스 속성에서 제거
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            self.spinner = nil
        }
    }

    // 디바이스 방향 변경 시 호출되는 메서드
    @objc static func update() {
        DispatchQueue.main.async {
            if spinner != nil {
                // spinner가 있는 경우 hide 후 다시 show를 호출하여 화면 갱신
                hide()
                show()
            }
        }
    }
}

