//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by JH Park on 2023/09/18.
//

import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.0.1"))
    ],
    platforms: [.iOS]
)
