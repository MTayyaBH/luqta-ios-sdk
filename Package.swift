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
            url: "https://github.com/MTayyaBH/luqta-ios-sdk/releases/download/1.1.1/LuqtaSDK.xcframework.zip",
            checksum: "fe7b867ec02ea7abf3239bc4f52b2fcd18d7004790c95e01a0f4a747331e30df"
        ),
    ]
)
