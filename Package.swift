// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Frontless", 
    platforms: [.macOS(.v11)],
    products: [
        .library(
            name: "Frontless",
            targets: ["Frontless"]),
        .executable(
            name: "DemoApp", 
            targets: ["DemoApp"]
        )
    ],
    dependencies: [
        .package(name: "Tokamak", url: "https://github.com/TokamakUI/Tokamak", from: "0.6.1"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0")        
    ],
    targets: [
        .target(
            name: "Frontless",
            dependencies: [
                .product(name: "TokamakDOM", package: "Tokamak"),
                .product(name: "TokamakShim", package: "Tokamak"),
                .product(name: "Logging", package: "swift-log")                
            ]),
        .target(
               name: "DemoApp",
               dependencies: [
                .target(name: "Frontless"), 
               ]),
        .testTarget(
            name: "TokamakBootstrapTests",
            dependencies: [
                .target(name: "Frontless")
            ]),
    ]
)
