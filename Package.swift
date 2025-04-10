// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RecordKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "RecordKit",
            targets: ["RecordKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-swift.git", .upToNextMajor(from: "20.0.1"))
        ],
    targets: [
        .target(
            name: "RecordKit",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-swift")
            ]
        ),
        .testTarget(
            name: "Tests",
            dependencies: ["RecordKit"]
        )
    ]
)
