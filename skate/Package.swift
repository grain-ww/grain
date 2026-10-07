// swift-tools-version: 6.2

import PackageDescription

let strictSettings: [SwiftSetting] = [
    .enableExperimentalFeature("StrictMemorySafety"),
    .unsafeFlags(["-warnings-as-errors"]),
]

var products: [Product] = [
    .library(name: "SkateCore", targets: ["SkateCore"]),
]
var targets: [Target] = [
    .target(
        name: "SkateCore",
        swiftSettings: strictSettings
    ),
    .testTarget(
        name: "SkateCoreTests",
        dependencies: ["SkateCore"],
        swiftSettings: strictSettings
    ),
]

#if os(macOS)
products.append(.executable(name: "SkateDesk", targets: ["SkateDesk"]))
targets.append(
    .executableTarget(
        name: "SkateDesk",
        dependencies: ["SkateCore"],
        swiftSettings: [.unsafeFlags(["-warnings-as-errors"])]
    )
)
#endif

let package = Package(
    name: "Skate",
    products: products,
    targets: targets,
    swiftLanguageModes: [.v6]
)
