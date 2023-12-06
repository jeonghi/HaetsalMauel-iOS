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
      .remote(url: "https://github.com/exyte/Chat.git", requirement: .upToNextMajor(from: "1.2.2")),
      .remote(url: "https://github.com/pointfreeco/swift-composable-architecture.git", requirement: .upToNextMajor(from: "1.5.0")),
      .remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .upToNextMajor(from: "10.11.0"))
    ],
    dependencies: [
        .Projcet.EumNetwork,
        .Projcet.UISystem,
        .Projcet.DesignSystemFoundation,
        .Projcet.EumAuth,
        .sdk(name: "WebKit", type: .framework, status: .required),
        .package(product: "ExyteChat"),
        .package(product: "ExyteMediaPicker"),
        .package(product: "ComposableArchitecture"),
        .package(product: "FirebaseStorage"),
        .package(product: "FirebaseAuth"),
        .package(product: "FirebaseAuthCombine-Community"),
        .package(product: "FirebaseFirestore"),
        .package(product: "FirebaseFirestoreCombine"),
        .package(product: "FirebaseFirestoreSwift"),
        .external(name: "Moya"),
        .external(name: "CombineMoya"),
        .external(name: "PopupView"),
        .external(name: "Kingfisher"),
        .external(name: "KakaoSDK")
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Sources/Info.plist"),
    entitlements: .relativeToCurrentFile("App.entitlements")
)
