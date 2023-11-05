//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by JH Park on 2023/09/18.
//

import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.0.1")),
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture.git", requirement: .upToNextMajor(from: "1.2.0")),
        .remote(url: "https://github.com/fermoya/SwiftUIPager.git", requirement: .upToNextMajor(from: "2.5.0")),
        .remote(url: "https://github.com/interactord/LinkNavigator.git", requirement: .upToNextMajor(from: "0.6.1")),
        .remote(url: "https://github.com/exyte/PopupView.git", requirement: .upToNextMajor(from: "2.7.0"))
    ],
    platforms: [.iOS]
)
