// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SubviewHierarchy",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SubviewHierarchy",
            targets: ["SubviewHierarchy"]),
    ],
    targets: [
        .target(
            name: "SubviewHierarchy"),
        .testTarget(
            name: "SubviewHierarchyTests",
            dependencies: ["SubviewHierarchy"]
        ),
    ]
)
