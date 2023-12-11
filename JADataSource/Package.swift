// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JADataSource",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "JADataSource", targets: ["JADataSource"]),
    ],
    targets: [
        .target(name: "JADataSource"),
        .testTarget(name: "JADataSourceTests", dependencies: ["JADataSource"]),
    ]
)
