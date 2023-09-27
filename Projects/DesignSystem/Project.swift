//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by JH Park on 2023/09/18.
//
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDesignSystemModule(
    name: "DesignSystem",
    platform: .iOS,
    product: .framework,
    packages: [
    ],
    dependencies: [
        .external(name: "SnapKit")
    ],
    resources: ["Resources/**"]
)
