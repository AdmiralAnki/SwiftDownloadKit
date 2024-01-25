// swift-tools-version: 5.7.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftDownloadKit",
    platforms: [
        .macOS(.v12), .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftDownloadKit",
            targets: ["SwiftDownloadKit"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftDownloadKit",
            path: "Sources"),
        .testTarget(
            name: "SwiftDownloadKitTests",
            dependencies: ["SwiftDownloadKit"]),
    ]
)
