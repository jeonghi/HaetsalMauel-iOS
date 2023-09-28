import ProjectDescription

public extension TargetDependency {
    enum Projcet {}
}

public extension TargetDependency.Projcet {
    static let Network = TargetDependency.project(target: "Network", path: .relativeToRoot("Projects/Network"))
    static let DesignSystemFoundation = TargetDependency.project(target: "DesignSystemFoundation", path: .relativeToRoot("Projects/DesignSystemFoundation"))
    static let UISystem = TargetDependency.project(target: "UISystem", path: .relativeToRoot("Projects/UISystem"))
}
