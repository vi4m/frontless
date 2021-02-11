// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TokamakBootstrap", platforms: [.macOS(.v11)],
    products: [
        .library(
            name: "TokamakBootstrap",
            targets: ["TokamakBootstrap"]),
    ],
    dependencies: [
        .package(name: "Tokamak", url: "https://github.com/vi4m/Tokamak", .branch("html"))

    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "TokamakBootstrap",
            dependencies: [
                .product(name: "TokamakDOM", package: "Tokamak")
            ]),
        .testTarget(
            name: "TokamakBootstrapTests",
            dependencies: ["TokamakBootstrap"]),
    ]
)
