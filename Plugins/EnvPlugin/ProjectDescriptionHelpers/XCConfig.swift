//
//  XCConfig.swift
//  EnvPlugin
//
//  Created by gnksbm on 2023/12/08.
//

import ProjectDescription

public extension Settings {
    static let secret: Self = .settings(
        base: .baseSetting.setVersion()
            .setCodeSignManual()
            .setProvisioning(),
        configurations: [
            .debug(
                name: .debug,
                xcconfig: .relativeToRoot("XCConfig/Debug.xcconfig")
            ),
            .release(
                name: .release,
                xcconfig: .relativeToRoot("XCConfig/Release.xcconfig")
            ),
        ],
        defaultSettings: .recommended
    )
}

public extension SettingsDictionary {
    static let baseSetting: Self = [:]
    
    func setVersion() -> SettingsDictionary {
        merging(
            [
                "VERSIONING_SYSTEM": .string("apple-generic"),
                "CURRENT_PROJECT_VERSION": .currentProjectVersion,
                "MARKETING_VERSION": .marketingVersion
            ]
        )
    }
    
    func setProvisioning() -> SettingsDictionary {
        merging(
            [
                "PROVISIONING_PROFILE_SPECIFIER": .string("$(APP_PROVISIONING_PROFILE)"),
                "PROVISIONING_PROFILE": .string("$(APP_PROVISIONING_PROFILE)"),
            ]
        )
    }
    
    func setCodeSignManual() -> SettingsDictionary {
        merging(
            [
                "CODE_SIGN_STYLE": .string("Manual"),
                "DEVELOPMENT_TEAM": .string("ASU4PNB5MG"),
                "CODE_SIGN_IDENTITY": .string("$(CODE_SIGN_IDENTITY)")
            ]
        )
    }
}
