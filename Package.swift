// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Convenient Collections",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "Convenient Collections",
            targets: ["Convenient Collections"]
        )
    ],
    targets: [
        .target(
            name: "Convenient Collections"
        )
    ]
)

let packageVersion: Version = "1.0.0"
