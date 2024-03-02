// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftDownloadKit",
    platforms: [
        .macOS(.v12), .iOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftDownloadKit",
            targets: ["SwiftDownloadKit"]),
    ],
    dependencies: [.package(url: "https://github.com/AdmiralAnki/Networking.git", branch: "main"),],
    targets: [
        .target(
            name: "SwiftDownloadKit",
            dependencies: ["Networking"],
            path: "Sources"),
        .testTarget(
            name: "SwiftDownloadKitTests",
            dependencies: ["SwiftDownloadKit"]),
    ]
)
