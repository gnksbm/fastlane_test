import ProjectDescription

import EnvPlugin

extension Project {
    // MARK: Refact
    public static func makeProject(
        name: String,
        targetKinds: TargetKind,
        entitlements: Path? = nil,
        isTestable: Bool = false,
        hasResource: Bool = false,
        dependencies: [TargetDependency]
    ) -> Self {
        var targets = [Target]()
        targets = {
            switch targetKinds {
            case .app:
                var result = [Target]()
                let app = appTarget(name: name, entitlements: entitlements, dependencies: dependencies)
                result.append(app)
                if isTestable {
                    let test = unitTestTarget(name: name, dependencies: dependencies)
                    result.append(test)
                }
                return result
            case .framework:
                var result = [Target]()
                let framework = frameworkTarget(name: name, entitlements: entitlements, hasResource: hasResource, dependencies: dependencies)
                result.append(framework)
                if isTestable {
                    let test = unitTestTarget(name: name, dependencies: dependencies)
                    result.append(test)
                }
                return result
            case .feature:
                var result = [Target]()
                let framework = frameworkTarget(name: name, entitlements: entitlements, hasResource: hasResource, isFeature: true, dependencies: dependencies)
                result.append(framework)
                let frameworkDependency = TargetDependency.target(framework)
//                let demoApp = demoAppTarget(name: name, entitlements: entitlements, dependencies: [frameworkDependency])
//                result.append(demoApp)
                let test = unitTestTarget(name: name, isFeature: true, dependencies: [frameworkDependency])
                result.append(test)
                return result
            }
        }()
        return Project(
            name: name,
            organizationName: .organizationName,
            targets: targets
        )
    }
    
    private static func appTarget(
        name: String,
        entitlements: Path?,
        dependencies: [TargetDependency]
    ) -> Target {
        let target: Target = .init(
            name: name,
            platform: .iOS,
            product: .app,
            bundleId: .bundleID,
            deploymentTarget: .deploymentTarget,
            infoPlist: .infoPlist,
            sources: ["\(name)/Sources/**"],
            resources: ["\(name)/Resources/**"],
            entitlements: entitlements,
//            scripts: [.swiftLint],
            dependencies: dependencies,
            settings: .secret
        )
        return target
    }

    private static func demoAppTarget(
        name: String,
        entitlements: Path? = nil,
        dependencies: [TargetDependency]
    ) -> Target {
        let target: Target = .init(
            name: "\(name)DemoApp",
            platform: .iOS,
            product: .app,
            bundleId: .bundleID + ".\(name)DemoApp",
            deploymentTarget: .deploymentTarget,
            infoPlist: .infoPlist,
            sources: [
                "\(name)/Demo/**",
                "\(name)/Sources/**"
            ],
            entitlements: entitlements,
//            scripts: [.featureSwiftLint],
            dependencies: dependencies,
            settings: .secret
        )
        return target
    }

    private static func frameworkTarget(
        name: String,
        entitlements: Path?,
        hasResource: Bool,
        isFeature: Bool = false,
        dependencies: [TargetDependency]
    ) -> Target {
        let target: Target = .init(
            name: name,
            platform: .iOS,
            product: .framework,
            bundleId: .bundleID + ".\(name)",
            deploymentTarget: .deploymentTarget,
            infoPlist: .infoPlist,
            sources: ["\(name)/Sources/**"],
            resources: hasResource ? ["\(name)/Resources/**"] : nil,
            entitlements: entitlements,
//            scripts: isFeature ? [.featureSwiftLint] : [.swiftLint],
            dependencies: dependencies,
            settings: .secret
        )
        return target
    }
    
    private static func unitTestTarget(
        name: String,
        isFeature: Bool = false,
        dependencies: [TargetDependency]
    ) -> Target {
        return Target(
            name: "\(name)Tests",
            platform: .iOS,
            product: .unitTests,
            bundleId: .bundleID + ".\(name)Test",
            deploymentTarget: .deploymentTarget,
            infoPlist: .infoPlist,
            sources: ["\(name)/Tests/**"],
//            scripts: isFeature ? [.featureSwiftLint] : [.swiftLint],
            dependencies: dependencies
        )
    }
}
import ProjectDescription

public enum TargetKind {
    case app, framework, feature
    
    var product: Product {
        switch self {
        case .app:
            return .app
        case .framework:
            return .framework
        case .feature:
            return .app
        }
    }
}
