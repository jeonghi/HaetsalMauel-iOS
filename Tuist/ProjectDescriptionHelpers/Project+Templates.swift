import ProjectDescription
import ProjectDescriptionHelpers

public extension Project {
  
  static let organizationName = "com.haetsal"
  static let targetVersion = "16.0"
  
  
  static func makeAppModule(
    name: String,
    platform: Platform = .iOS,
    product: Product,
    organizationName: String = organizationName,
    packages: [Package] = [],
    deploymentTarget: DeploymentTarget? = .iOS(targetVersion: targetVersion, devices: [.iphone]),
    dependencies: [TargetDependency] = [],
    sources: SourceFilesList = ["Sources/**"],
    resources: ResourceFileElements? = nil,
    infoPlist: InfoPlist = .default,
    entitlements: Path? = nil
  ) -> Project {
    
    let settings: Settings = .settings(
      configurations: [
        .debug(name: .debug, xcconfig: .relativeToManifest("debug-config.xcconfig")),
        .release(name: .release, xcconfig: .relativeToManifest("release-config.xcconfig"))
      ],
      defaultSettings: .recommended
    )
    
    let appTarget = Target(
      name: name,
      platform: platform,
      product: product,
      bundleId: "\(organizationName).\(name)",
      deploymentTarget: deploymentTarget,
      infoPlist: infoPlist,
      sources: sources,
      resources: resources,
      entitlements: entitlements,
      dependencies: dependencies
    )
    
    let testTarget = Target(
      name: "\(name)Tests",
      platform: platform,
      product: .unitTests,
      bundleId: "\(organizationName).\(name)Tests",
      deploymentTarget: deploymentTarget,
      infoPlist: .default,
      sources: ["Tests/**"],
      entitlements: entitlements,
      dependencies: [.target(name: name)]
    )
    
    let schemes: [Scheme] = [.makeScheme(target: .debug, name: name)]
    
    let targets: [Target] = [appTarget, testTarget]
    
    return Project(
      name: name,
      organizationName: organizationName,
      packages: packages,
      settings: settings,
      targets: targets,
      schemes: schemes
    )
  }
  
  static func makeDesignSystemFoundationModule(
    name: String,
    platform: Platform = .iOS,
    product: Product,
    organizationName: String = organizationName,
    packages: [Package] = [],
    deploymentTarget: DeploymentTarget? = .iOS(targetVersion: targetVersion, devices: [.iphone]),
    dependencies: [TargetDependency] = [],
    sources: SourceFilesList = ["Sources/**"],
    resources: ResourceFileElements? = nil,
    infoPlist: InfoPlist = .default
  ) -> Project {
    let settings: Settings = .settings(
      configurations: [
        .debug(name: .debug),
        .release(name: .release)
      ],
      defaultSettings: .recommended)
    
    let appTarget = Target(
      name: name,
      platform: platform,
      product: product,
      bundleId: "\(organizationName).\(name)",
      deploymentTarget: deploymentTarget,
      infoPlist: infoPlist,
      sources: sources,
      resources: resources,
      dependencies: dependencies
    )
    
    let testTarget = Target(
      name: "\(name)Tests",
      platform: platform,
      product: .unitTests,
      bundleId: "\(organizationName).\(name)Tests",
      deploymentTarget: deploymentTarget,
      infoPlist: .default,
      sources: ["Tests/**"],
      dependencies: [.target(name: name)]
    )
    
    let schemes: [Scheme] = [.makeScheme(target: .debug, name: name)]
    
    let targets: [Target] = [appTarget, testTarget]
    
    return Project(
      name: name,
      organizationName: organizationName,
      packages: packages,
      settings: settings,
      targets: targets,
      schemes: schemes
    )
  }
  
  static func makeUISystemModule(
    name: String,
    platform: Platform = .iOS,
    product: Product,
    organizationName: String = organizationName,
    packages: [Package] = [],
    deploymentTarget: DeploymentTarget? = .iOS(targetVersion: targetVersion, devices: [.iphone]),
    dependencies: [TargetDependency] = [],
    sources: SourceFilesList = ["Sources/**"],
    resources: ResourceFileElements? = nil,
    infoPlist: InfoPlist = .default
  ) -> Project {
    let settings: Settings = .settings(
      configurations: [
        .debug(name: .debug),
        .release(name: .release)
      ], defaultSettings: .recommended)
    
    let appTarget = Target(
      name: name,
      platform: platform,
      product: product,
      bundleId: "\(organizationName).\(name)",
      deploymentTarget: deploymentTarget,
      infoPlist: infoPlist,
      sources: sources,
      resources: resources,
      dependencies: dependencies
    )
    
    let testTarget = Target(
      name: "\(name)Tests",
      platform: platform,
      product: .unitTests,
      bundleId: "\(organizationName).\(name)Tests",
      deploymentTarget: deploymentTarget,
      infoPlist: .default,
      sources: ["Tests/**"],
      dependencies: [.target(name: name)]
    )
    
    let schemes: [Scheme] = [.makeScheme(target: .debug, name: name)]
    
    let targets: [Target] = [appTarget, testTarget]
    
    return Project(
      name: name,
      organizationName: organizationName,
      packages: packages,
      settings: settings,
      targets: targets,
      schemes: schemes
    )
  }
  
  static func makeNetworkModule(
    name: String,
    platform: Platform = .iOS,
    product: Product,
    organizationName: String = organizationName,
    packages: [Package] = [],
    deploymentTarget: DeploymentTarget? = .iOS(targetVersion: targetVersion, devices: [.iphone]),
    dependencies: [TargetDependency] = [],
    sources: SourceFilesList = ["Sources/**"],
    resources: ResourceFileElements? = nil,
    infoPlist: InfoPlist = .default
  ) -> Project {
    let settings: Settings = .settings(
      configurations: [
        .debug(name: .debug),
        .release(name: .release)
      ], defaultSettings: .recommended)
    
    let appTarget = Target(
      name: name,
      platform: platform,
      product: product,
      bundleId: "\(organizationName).\(name)",
      deploymentTarget: deploymentTarget,
      infoPlist: infoPlist,
      sources: sources,
      resources: resources,
      dependencies: dependencies
    )
    
    let testTarget = Target(
      name: "\(name)Tests",
      platform: platform,
      product: .unitTests,
      bundleId: "\(organizationName).\(name)Tests",
      deploymentTarget: deploymentTarget,
      infoPlist: .default,
      sources: ["Tests/**"],
      dependencies: [.target(name: name)]
    )
    
    let schemes: [Scheme] = [.makeScheme(target: .debug, name: name)]
    
    let targets: [Target] = [appTarget, testTarget]
    
    return Project(
      name: name,
      organizationName: organizationName,
      packages: packages,
      settings: settings,
      targets: targets,
      schemes: schemes
    )
  }
  
  static func makeAuthModule(
    name: String,
    platform: Platform = .iOS,
    product: Product,
    organizationName: String = organizationName,
    packages: [Package] = [],
    deploymentTarget: DeploymentTarget? = .iOS(targetVersion: targetVersion, devices: [.iphone]),
    dependencies: [TargetDependency] = [],
    sources: SourceFilesList = ["Sources/**"],
    resources: ResourceFileElements? = nil,
    infoPlist: InfoPlist = .default
  ) -> Project {
    let settings: Settings = .settings(
      configurations: [
        .debug(name: .debug),
        .release(name: .release)
      ], defaultSettings: .recommended)
    
    let appTarget = Target(
      name: name,
      platform: platform,
      product: product,
      bundleId: "\(organizationName).\(name)",
      deploymentTarget: deploymentTarget,
      infoPlist: infoPlist,
      sources: sources,
      resources: resources,
      dependencies: dependencies
    )
    
    let testTarget = Target(
      name: "\(name)Tests",
      platform: platform,
      product: .unitTests,
      bundleId: "\(organizationName).\(name)Tests",
      deploymentTarget: deploymentTarget,
      infoPlist: .default,
      sources: ["Tests/**"],
      dependencies: [.target(name: name)]
    )
    
    let schemes: [Scheme] = [.makeScheme(target: .debug, name: name)]
    
    let targets: [Target] = [appTarget, testTarget]
    
    return Project(
      name: name,
      organizationName: organizationName,
      packages: packages,
      settings: settings,
      targets: targets,
      schemes: schemes
    )
  }
}

extension Scheme {
  static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
    return Scheme(
      name: name,
      shared: true,
      buildAction: .buildAction(targets: ["\(name)"]),
      testAction: .targets(
        ["\(name)Tests"],
        configuration: target,
        options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
      ),
      runAction: .runAction(configuration: target),
      archiveAction: .archiveAction(configuration: target),
      profileAction: .profileAction(configuration: target),
      analyzeAction: .analyzeAction(configuration: target)
    )
  }
}
