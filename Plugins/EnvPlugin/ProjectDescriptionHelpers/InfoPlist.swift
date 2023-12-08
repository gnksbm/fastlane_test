//
//  InfoPlist.swift
//  EnvPlugin
//
//  Created by gnksbm on 2023/12/08.
//

import ProjectDescription

public extension InfoPlist {
    static let infoPlist: Self = .extendingDefault(
        with: .baseInfoPlist.merging(
            .additionalInfoPlist,
            uniquingKeysWith: { $1 }
        )
    )
}

public extension [String: InfoPlist.Value] {
    static let baseInfoPlist: Self = [
        "CFBundleDisplayName": .bundleDisplayName,
        "CFBundleShortVersionString": .bundleShortVersionString,
        "CFBundleVersion": .bundleVersion,
        "UILaunchStoryboardName": "LaunchScreen",
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ],
                ]
            ]
        ],
    ]
    
    static let additionalInfoPlist: Self = [
        :
    ]
}
