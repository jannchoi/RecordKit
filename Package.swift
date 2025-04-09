// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RecordKit",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RecordKit",
            targets: ["RecordKit"]),
    ],
    dependencies: [
            .package(url: "https://github.com/realm/realm-swift.git", from: "20.0.1")
        ],
    targets: [
        .target(
            name: "RecordKit",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-swift")
            ]
        ),
        
    ]
)
