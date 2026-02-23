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
            url: "https://github.com/MTayyaBH/luqta-ios-sdk/releases/download/1.0.0/LuqtaSDK.xcframework.zip",
            checksum: "86963562aa9a362b19c74ffd7ae924ef1148f7e5062cd7fde46ee00bc6a63117"
        ),
    ]
)
