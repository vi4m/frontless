// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TokamakBootstrap", 
    platforms: [.macOS(.v11)],
    products: [
        .library(
            name: "TokamakBootstrap",
            targets: ["TokamakBootstrap"]),
    ],
    dependencies: [
        .package(name: "Tokamak", url: "https://github.com/TokamakUI/Tokamak", from: "0.6.1")
    ],
    targets: [
        .target(
            name: "TokamakBootstrap",
            dependencies: [
                .product(name: "TokamakDOM", package: "Tokamak"),
                .product(name: "TokamakShim", package: "Tokamak")                
            ]),
        .testTarget(
            name: "TokamakBootstrapTests",
            dependencies: ["TokamakBootstrap"]),
    ]
)
