// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JAInfrastructure",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "JAInfrastructure", targets: ["JAInfrastructure"]),
    ],
    dependencies: [
        .package(name: "JADataSource", path: "../JADataSource"),
    ],
    targets: [
        .target(
            name: "JAInfrastructure",
            dependencies: [
                .product(name: "JADataSource", package: "JADataSource"),
            ]),
        .testTarget(name: "JAInfrastructureTests", dependencies: ["JAInfrastructure"]),
    ]
)
