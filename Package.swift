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
            checksum: "14012661a47b0bf7e5230e55730ed34f3d4a2d5a495e8e4c8e7a98cc9063a157"
        ),
    ]
)
