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
    dependencies: [
        .Projcet.Network,
        .Projcet.DesignSystem
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Sources/Info.plist"),
    entitlements: .relativeToCurrentFile("App.entitlements")
)
