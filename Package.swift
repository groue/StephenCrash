// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StephenCrash",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "StephenCrash",
            targets: ["StephenCrash"]),
    ],
    dependencies: [
        .package(url: "http://github.com/groue/GRDB.swift", from: "7.0.0-beta.3"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "StephenCrash"
        ),
        .testTarget(
            name: "StephenCrashTests",
            dependencies: [
                "StephenCrash",
                .product(name: "GRDB", package: "GRDB.swift"),
            ]
        ),
    ]
)
