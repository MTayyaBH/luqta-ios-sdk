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
            checksum: "a1ca49cdbee210c37c243826024a0a6ae1b2c0c949b1a1a9d38b4639685681a9"
        ),
    ]
)
