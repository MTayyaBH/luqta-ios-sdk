# LuqtaSDK for iOS

Official iOS SDK for the Luqta API — Integrate contests, quizzes, rewards, and gamification features into your iOS applications.

**Version:** 1.0.0

## Installation

### CocoaPods

Add to your `Podfile`:

```ruby
pod 'LuqtaSDK', '~> 1.0.0'
```

Then run:

```bash
pod install
```

> Open the `.xcworkspace` file (not `.xcodeproj`) after running pod install.

## Features

- **Two Integration Modes**: Preconfigured (instant UI) or Custom (full control)
- **Contest Management**: Browse, participate, and track contest progress
- **Level Completion**: Text, QR code, Link, Image, and Quiz levels
- **Rewards & Gamification**: Points, rewards, and achievements
- **Beautiful SwiftUI UI**: Pre-built screens and widgets
- **Multi-language**: English and Arabic support with RTL
- **Secure**: Keychain token storage, rate limiting
- **Swift Native**: Built with modern Swift using async/await

## Quick Start

### Preconfigured Mode (Easiest)

```swift
import SwiftUI
import LuqtaSDK

struct ContestsView: View {
    @State private var client: LuqtaClient?
    @State private var isLoading = true

    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else if let client = client {
                client.render()  // Complete UI in one line
            }
        }
        .task { await setup() }
    }

    func setup() async {
        do {
            let c = try LuqtaClient(config: LuqtaConfig(
                mode: .preconfigured,
                apiKey: "your-api-key",
                appId: "your-app-id",
                branding: LuqtaBranding(primaryColor: "#9333ea"),
                locale: "en"
            ))
            _ = try await c.initializeSdk()
            try await c.syncAndInitializeUser(UserProfile(
                name: "John Doe",
                email: "john@example.com",
                policyAccept: true
            ))
            self.client = c
            self.isLoading = false
        } catch {
            print("Error: \(error)")
        }
    }
}
```

### Custom Mode (Full Control)

```swift
import LuqtaSDK

let client = try LuqtaClient(config: LuqtaConfig(
    apiKey: "your-api-key",
    appId: "your-app-id"
))

_ = try await client.initializeSdk()
try await client.syncAndInitializeUser(UserProfile(
    email: "john@example.com",
    policyAccept: true
))

// Use API services
let contests = try await client.contests.getAll()
let details = try await client.getContestDetailsProgress(contestId: 123)
```

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.9+

## Documentation

For full documentation, see the [iOS SDK Documentation](https://github.com/MTayyaBH/luqta-sdk/blob/main/ios-sdk-swift/README.md).

## Support

- **Email**: support@luqta.com
- **Issues**: [GitHub Issues](https://github.com/MTayyaBH/luqta-ios-sdk/issues)

## License

MIT License - See [LICENSE](LICENSE) file for details.
