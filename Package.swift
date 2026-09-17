// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "RdmnsiOS",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "RdmnsiOS",
            targets: ["RdmnsiOS"]
        ),
    ],
    targets: [
        .target(
            name: "RdmnsiOS",
            path: "."
        )
    ]
)
