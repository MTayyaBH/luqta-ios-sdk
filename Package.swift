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
            url: "https://github.com/MTayyaBH/luqta-ios-sdk/releases/download/1.0.2/LuqtaSDK.xcframework.zip",
            checksum: "c3563b06a29f7c1184178124e0e3c893922a84b7078e13bc12a00a213587e25c"
        ),
    ]
)
