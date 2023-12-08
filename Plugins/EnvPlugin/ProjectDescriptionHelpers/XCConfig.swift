//
//  XCConfig.swift
//  EnvPlugin
//
//  Created by gnksbm on 2023/12/08.
//

import ProjectDescription

public extension Settings {
    enum XCConfig {
        static let secrets: Path = .relativeToRoot("XCConfig/Secrets.xcconfig")
    }
    static let secret: Self = .settings(
        configurations: [
            .debug(
                name: .debug,
                xcconfig: .relativeToRoot("XCConfig/Secrets.xcconfig")
            ),
            .release(
                name: .release,
                xcconfig: .relativeToRoot("XCConfig/Secrets.xcconfig")
            ),
        ],
        defaultSettings: .recommended
    )
}
