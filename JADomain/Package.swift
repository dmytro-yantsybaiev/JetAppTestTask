// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JADomain",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "JADomain", targets: ["JADomain"]),
    ],
    dependencies: [
        .package(name: "JADataSource", path: "../JADataSource"),
        .package(name: "JAInfrastructure", path: "../JAInfrastructure"),
    ],
    targets: [
        .target(
            name: "JADomain",
            dependencies: [
                .product(name: "JADataSource", package: "JADataSource"),
                .product(name: "JAInfrastructure", package: "JAInfrastructure"),
            ]
        ),
        .testTarget(name: "JADomainTests", dependencies: ["JADomain"]),
    ]
)
