// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TokamakBootstrap",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "TokamakBootstrap",
            targets: ["TokamakBootstrap"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Tokamak", url: "https://github.com/swiftwasm/Tokamak", .revision("8e5ad7f67fc79297838515bf156005972fec5799"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "TokamakBootstrap",
            dependencies: []),
        .testTarget(
            name: "TokamakBootstrapTests",
            dependencies: ["TokamakBootstrap"]),
    ]
)
