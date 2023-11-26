//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by JH Park on 2023/09/18.
//

import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeNetworkModule(
    name: "EumNetwork",
    product: .staticFramework,
    dependencies: [
      .external(name: "Moya"),
      .external(name: "CombineMoya"),
      .Projcet.EumAuth
    ]
)
