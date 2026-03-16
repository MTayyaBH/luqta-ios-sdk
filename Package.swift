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
            checksum: "572b92219e22f24488e4254e55dcc0e74391fd060a9d37b682dbe1805d69988f"
        ),
    ]
)
