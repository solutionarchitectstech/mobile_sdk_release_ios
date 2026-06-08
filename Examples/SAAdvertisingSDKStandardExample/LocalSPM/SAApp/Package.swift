// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SAApp",
  platforms: [.iOS(.v16)],
  products: [
    .library(name: "SAApp", targets: ["SAApp"])
  ],
  dependencies: [
    .package(url: "https://github.com/solutionarchitectstech/mobile_sdk_release", exact: "1.6.0"),
    .package(url: "https://github.com/devxoul/Toaster.git", branch: "master")
  ],
  targets: [
    .target(
      name: "SAApp",
      dependencies: [
        .product(name: "SAAdvertisingSDKStandard", package: "mobile_sdk_release"),
        .product(name: "Toaster", package: "Toaster")
      ]
    )
  ],
  swiftLanguageModes: [.v5]
)
