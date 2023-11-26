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
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture.git", requirement: .upToNextMajor(from: "1.3.0")),
        .remote(url: "https://github.com/fermoya/SwiftUIPager.git", requirement: .upToNextMajor(from: "2.5.0")),
        .remote(url: "https://github.com/interactord/LinkNavigator.git", requirement: .upToNextMajor(from: "0.6.1")),
        .remote(url: "https://github.com/exyte/PopupView.git", requirement: .upToNextMajor(from: "2.7.0")),
        //.remote(url: "https://github.com/exyte/Chat.git", requirement: .upToNextMajor(from: "1.2.2")),
        .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "7.10.0")),
        .remote(url: "https://github.com/kakao/kakao-ios-sdk.git", requirement: .upToNextMajor(from: "2.19.0")),
        .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMajor(from: "15.0.3"))
        .remote(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", requirement: .upToNextMajor(from: "4.2.2"))
    ],
    platforms: [.iOS]
)
