//
//  Project.swift
//  Config
//
//  Created by JH Park on 2023/09/24.
//
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDesignSystemFoundationModule(
    name: "DesignSystemFoundation",
    product: .framework,
    packages: [],
    dependencies: [],
    resources: ["Resources/**"],
    infoPlist: .file(path: "SupportingFile/Info.plist")
)
