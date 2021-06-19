// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {
    var isCI: Bool {
        return environmentVariable(get: "CI") == "true" ? true : false
    }
    
    var targetSchemeName: String {
        return environmentVariable(get: "TARGET_SCHEME_NAME")
    }
    
    func swiftLintLane() {
        desc("Run SwiftLint")
        
        // Run 'pod install'
        cocoapods()
        
        swiftlint(configFile: ".swiftlint.yml",
                  strict: true,
                  ignoreExitStatus: false,
                  raiseIfSwiftlintError: true,
                  executable: "Pods/SwiftLint/swiftlint"
        )
    }

    func debugLane() {

        desc("Create a test build and export an .ipa file")

        buildProduct(configuration: InternalDebug(), exportIpa: true)
    }
    
    func stagingLane() {

        desc("Create a test build and export an .ipa file")

        buildProduct(configuration: TestFlight(), exportIpa: true)
    }

    func productionLane() {

        desc("Create a production build and export an .ipa file")

        buildProduct(configuration: AppStore(), exportIpa: true)
    }
    
    private func buildProduct(configuration: Configuration, exportIpa: Bool) {

        // Update provisioning profile and certificate for the specified build configuration
        match(
            type: configuration.exportMethod,
            readonly: isCI,
            appIdentifier: [configuration.bundleIdentifier],
            gitBranch: targetSchemeName,
            forceForNewDevices: configuration.exportMethod == "development"
        )

        // Build the product for the specified build configuration
        gym(
            scheme: .fastlaneDefault(targetSchemeName),
            outputName: .fastlaneDefault("\(targetSchemeName)-\(configuration.buildConfiguration).ipa"),
            configuration: .fastlaneDefault(configuration.buildConfiguration),
            skipPackageIpa: !exportIpa
        )
    }
}

protocol Configuration {
    var exportMethod: String { get }
    var buildConfiguration: String { get }
    var bundleIdentifier: String { get }
}

struct InternalDebug: Configuration {
    // Configuration for building debug builds on physical devices in-house
    var exportMethod = "development"
    var buildConfiguration = "Debug"
    var bundleIdentifier: String {
        let rootIdentifier = environmentVariable(get: "BUNDLE_IDENTIFIER")
        return "\(rootIdentifier).debug"
    }
}

struct TestFlight: Configuration {
    // Configuration for building test builds to deploy in Test Flight
    var exportMethod = "appstore"
    var buildConfiguration = "Staging"
    var bundleIdentifier: String {
        let rootIdentifier = environmentVariable(get: "BUNDLE_IDENTIFIER")
        return "\(rootIdentifier).staging"
    }
}

struct AppStore: Configuration {
    // Configuration for building release builds to deploy in App Store
    var exportMethod = "appstore"
    var buildConfiguration = "Release"
    var bundleIdentifier: String {
        let rootIdentifier = environmentVariable(get: "BUNDLE_IDENTIFIER")
        return "\(rootIdentifier)"
    }
}
