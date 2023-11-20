//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by JH Park on 2023/09/18.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeAppModule(
    name: "App",
    platform: .iOS,
    product: .app,
    packages: [
      .remote(url: "https://github.com/exyte/Chat.git", requirement: .upToNextMajor(from: "1.2.2"))
    ],
    dependencies: [
        .Projcet.EumNetwork,
        .Projcet.UISystem,
        .Projcet.DesignSystemFoundation,
        .sdk(name: "WebKit", type: .framework, status: .required),
        .package(product: "ExyteChat"),
        .package(product: "ExyteMediaPicker"),
        .external(name: "SnapKit"),
        .external(name: "ComposableArchitecture"),
        .external(name: "SwiftUIPager"),
        .external(name: "LinkNavigator"),
        .external(name: "PopupView"),
        .external(name: "Kingfisher"),
        .external(name: "KakaoSDK")
//        .external(name: "ExyteChat"),
//        .external(name: "ExyteMediaPicker")
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Sources/Info.plist"),
    entitlements: .relativeToCurrentFile("App.entitlements")
)
