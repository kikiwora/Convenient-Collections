// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Convenient Collections",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(
      name: "Convenient Collections",
      targets: ["Convenient Collections"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/Quick/Nimble", from: "12.0.0"),
    .package(url: "https://github.com/Quick/Quick", from: "7.0.0")
  ],
  targets: [
    .target(
      name: "Convenient Collections"
    ),
    .testTarget(
      name: "Convenient Collections Tests",
      dependencies: ["Convenient Collections", "Nimble", "Quick"]
    )
  ]
)

let packageVersion: Version = "1.0.2"
