// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "MobileCoin",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(name: "MobileCoinCore", targets: ["MobileCoin"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.4.0"),
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.5.0"),
    ],
    targets: [
        .binaryTarget(
            name: "LibMobileCoin",
            url: "https://build-artifacts.signal.org/libraries/libmobilecoin-ios-build-v6.0.2.zip",
            checksum: "bd99aff553c7c48fd6638fbe51685b508abf6100749c6563feb018315ec2bf26"
        ),
        .target(
            name: "LibMobileCoinCommon",
            dependencies: [
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
            ],
            path: "Vendor/libmobilecoin/Sources/Common"
        ),
        .target(
            name: "LibMobileCoinHTTP",
            dependencies: ["LibMobileCoinCommon"],
            path: "Vendor/libmobilecoin/Sources/HTTP"
        ),
        .target(
            name: "MobileCoin",
            dependencies: [
                "LibMobileCoin",
                "LibMobileCoinCommon",
                "LibMobileCoinHTTP",
                .product(name: "Logging", package: "swift-log"),
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
            ],
            path: "Sources",
            exclude: [
                "GRPC",
            ],
            linkerSettings: [
                .linkedLibrary("z"),
            ]
        ),
    ]
)
