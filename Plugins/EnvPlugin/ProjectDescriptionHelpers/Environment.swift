//
//  Environment.swift
//  EnvPlugin
//
//  Created by gnksbm on 2023/12/08.
//

import Foundation

import ProjectDescription

public extension String {
    static let appName: Self = "YamYamPick"
    static let displayName: Self = "얌얌픽"
    static let organizationName = "Pepsi-Club"
    static let bundleID: Self = "com.\(organizationName).\(appName)"
    static let targetVersion: Self = "16.0"
    static let marketingVersion: Self = "1" // 앱스토어에 게시할 때마다 증가해줘야 하는 버전
    static var buildVersion: Self { // 개발자가 내부적으로 확인하기 위한 용도 (날짜를 사용하기도 함 - 2023.12.8.1 )
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: .init())
    }
}

extension InfoPlist.Value {
    static let bundleDisplayName: Self = .string(.displayName)
    static let bundleShortVersionString: Self = .string(.marketingVersion)
    static let bundleVersion: Self = .string(.buildVersion)
}

extension SettingValue {
    static let marketingVersion: Self = .string(.marketingVersion)
    static let currentProjectVersion: Self = .string(.buildVersion)
}
//"MARKETING_VERSION": "1.0",
//    "CURRENT_PROJECT_VERSION": "1.0.0.6"

public extension DeploymentTarget {
    static let deploymentTarget: Self = .iOS(
        targetVersion: .targetVersion,
        devices: .iphone
    )
}

public extension Platform {
    static let platform: Self = .iOS
}
