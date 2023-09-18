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
    product: .staticFramework,
    packages: [],
    dependencies: [],
    resources: ["Resources/**"]
)
