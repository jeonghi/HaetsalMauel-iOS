//
//  Project.swift
//  Config
//
//  Created by JH Park on 2023/09/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeUISystemModule(
    name: "UISystem",
    product: .framework,
    packages: [],
    dependencies: [
        .Projcet.DesignSystemFoundation
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "SupportingFile/Info.plist")
)
