// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "LuqtaSDK",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "LuqtaSDK", targets: ["LuqtaSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "LuqtaSDK",
            url: "https://github.com/MTayyaBH/luqta-ios-sdk/releases/download/1.1.0/LuqtaSDK.xcframework.zip",
            checksum: "52c8437e486519d168a85fd7dc08713f2ad4f46a5add3a763d0b4d1a1e61b2e4"
        ),
    ]
)
