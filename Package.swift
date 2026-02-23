// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "LuqtaSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "LuqtaSDK",
            targets: ["LuqtaSDK"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "LuqtaSDK",
            url: "https://github.com/MTayyaBH/luqta-ios-sdk/releases/download/1.0.1/LuqtaSDK.xcframework.zip",
            checksum: "81d897ff05bebde02700c2aee8ec56f614586ee5646d36f46e29eda34de41c29"
        ),
    ]
)
