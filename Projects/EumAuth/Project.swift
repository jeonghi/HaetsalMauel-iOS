//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 쩡화니 on 11/27/23.
//

import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeAuthModule(
    name: "EumAuth",
    product: .staticFramework,
    dependencies: [
      .external(name: "KeychainAccess")
    ]
)
