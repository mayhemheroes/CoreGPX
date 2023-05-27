// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreGPX",
    platforms: [
        .iOS(.v11), .macOS(.v10_13), .watchOS(.v4)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "CoreGPX",
            targets: ["CoreGPX"]),
        .executable(
            name: "CoreGPXFuzz",
            targets: ["CoreGPXFuzz"])
        ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "CoreGPX",
            dependencies: [],
            path: "Classes"),
        .testTarget(
            name: "CoreGPXTests",
            dependencies: ["CoreGPX"],
            path: "Example/Tests"),
        .target(
            name: "CoreGPXFuzz",
            dependencies: ["CoreGPX"],
            path: "mayhem",
            sources: ["FuzzedDataProvider.swift", "main.swift"],
            swiftSettings: [
                .unsafeFlags(["-sanitize=fuzzer,address"]),
                .unsafeFlags(["-parse-as-library"])
            ],
            linkerSettings: [
                .unsafeFlags(["-sanitize=fuzzer,address"])
            ]
        )
        ],
    swiftLanguageVersions: [ .v4_2, .v5 ]
)
