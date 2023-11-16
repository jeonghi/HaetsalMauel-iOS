import ProjectDescription

public extension TargetDependency {
    enum Projcet {}
}

public extension TargetDependency.Projcet {
    static let EumNetwork = TargetDependency.project(target: "EumNetwork", path: .relativeToRoot("Projects/EumNetwork"))
    static let DesignSystemFoundation = TargetDependency.project(target: "DesignSystemFoundation", path: .relativeToRoot("Projects/DesignSystemFoundation"))
    static let UISystem = TargetDependency.project(target: "UISystem", path: .relativeToRoot("Projects/UISystem"))
}
