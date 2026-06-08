// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SAAdvertisingSDK",
  platforms: [.iOS(.v16)],
  products: [
    .library(name: "SAAdvertisingSDKStandard", targets: ["SAAdvertisingSDKStandard"])
  ],
  dependencies: [
  ],
  targets: [
    .binaryTarget(
      name: "SAAdvertisingSDKStandard",
      path: "SAAdvertisingSDKStandard.xcframework"
    )
  ],
  swiftLanguageModes: [.v5]
)
