# Luqta iOS SDK (Swift)

Official iOS SDK for the Luqta API — Integrate contests, quizzes, rewards, and gamification features into your iOS applications.

**Version:** 1.1.0

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Usage Modes](#usage-modes)
  - [Preconfigured Mode](#1-preconfigured-mode---complete-ui-in-one-line)
  - [Custom Mode](#2-custom-mode---build-your-own-ui)
- [API Reference](#api-reference)
  - [Contests API](#contests-api)
  - [Levels API](#levels-api)
  - [Quiz API](#quiz-api)
  - [Rewards API](#rewards-api)
  - [Notifications API](#notifications-api)
  - [Profile API](#profile-api)
  - [HTTP Methods](#http-methods)
- [Available Widgets](#available-widgets)
- [Models](#models)
- [Theming & Branding](#theming--branding)
- [Localization](#localization)
- [Error Handling](#error-handling)
- [Example App](#example-app)
- [Support](#support)

---

## Features

- **Two Integration Modes**: Preconfigured (instant UI) or Custom (full control)
- **Contest Management**: Browse, participate, and track contest progress
- **Level Completion**: Text, QR code, Link, Image, and Quiz levels
- **Rewards & Gamification**: Points, rewards, and achievements
- **Beautiful SwiftUI UI**: Pre-built screens and widgets
- **Multi-language**: English and Arabic support
- **RTL Support**: Right-to-left layout for Arabic
- **Secure**: Keychain token storage, rate limiting, request deduplication
- **Swift Native**: Built with modern Swift using async/await
- **Flexible Authentication**: Email or phone number

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.9+

---

## Installation

### CocoaPods

Add to your `Podfile`:

```ruby
pod 'LuqtaSDK', '~> 1.1.0'
```

Then run:

```bash
pod install
```

> **Note:** Open the `.xcworkspace` file (not `.xcodeproj`) after running pod install.

### Swift Package Manager

In Xcode:
1. File > Add Package Dependencies
2. Enter URL: `https://github.com/MTayyaBH/luqta-ios-sdk`
3. Select version and add to your project

Or in `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/MTayyaBH/luqta-ios-sdk", from: "1.1.0")
]
```

---

## Quick Start

### Minimum Setup (3 Steps)

```swift
import LuqtaSDK

// Step 1: Create client
let client = try LuqtaClient(config: LuqtaConfig(
    apiKey: "your-api-key",
    appId: "your-app-id"
))

// Step 2: Initialize SDK
try await client.initializeSdk()

// Step 3: Initialize user
try await client.syncAndInitializeUser(UserProfile(
    name: "John Doe",
    email: "john@example.com",
    policyAccept: true
))

// Done! Now use the SDK
```

---

## Usage Modes

The SDK supports **two modes** — choose based on your needs:

| Mode | Best For | Effort |
|------|----------|--------|
| **Preconfigured** | Quick integration, standard UI | Minimal — just call `render()` |
| **Custom** | Full UI control, custom designs | More work — use APIs directly |

---

## 1. Preconfigured Mode - Complete UI in One Line

Use this mode to get a **complete, beautiful UI** with minimal code. The SDK handles everything: screens, navigation, API calls, and state management.

### Complete Example

```swift
import SwiftUI
import LuqtaSDK

struct ContestsView: View {
    @State private var client: LuqtaClient?
    @State private var isLoading = true
    @State private var error: String?

    var body: some View {
        Group {
            if isLoading {
                ProgressView("Loading...")
            } else if let error = error {
                Text(error).foregroundColor(.red)
            } else if let client = client {
                client.render()  // That's it!
            }
        }
        .task {
            await initializeLuqta()
        }
    }

    func initializeLuqta() async {
        do {
            let config = LuqtaConfig(
                mode: .preconfigured,
                apiKey: "your-api-key",
                appId: "your-app-id",
                production: false,
                branding: LuqtaBranding(
                    primaryColor: "#9333ea",
                    secondaryColor: "#4f46e5"
                ),
                locale: "en",
                rtl: false,
                onAction: { action in
                    print("Action: \(action)")
                },
                onError: { error in
                    print("Error: \(error)")
                }
            )

            let newClient = try LuqtaClient(config: config)
            _ = try await newClient.initializeSdk()

            try await newClient.syncAndInitializeUser(UserProfile(
                name: "John Doe",
                email: "john@example.com",
                policyAccept: true
            ))

            self.client = newClient
            self.isLoading = false
        } catch {
            self.error = error.localizedDescription
            self.isLoading = false
        }
    }
}
```

### What `render()` Provides

| Feature | Description |
|---------|-------------|
| Contest carousel | Horizontal scrollable contest cards |
| Contest detail page | Full detail with levels, progress, prizes |
| Level completion flows | Text, QR code, Link, Image upload |
| Quiz interface | Questions with timer and scoring |
| Progress tracking | Visual progress bars per contest |
| Congratulations screen | Animated celebration on level/contest completion |
| Access code handling | Bottom sheet for private contest codes |
| Pull-to-refresh | Swipe down to refresh contests |
| Countdown timers | Live countdowns on contest cards |
| Error handling | Automatic retry and error display |

### Session Restore

The SDK automatically stores tokens in Keychain. On subsequent app launches, restore the session without API calls:

```swift
if client.tryRestoreSession() {
    // Session restored — skip initializeSdk()
} else {
    _ = try await client.initializeSdk()
}
```

---

## 2. Custom Mode - Build Your Own UI

Use this mode when you need **complete control** over the UI. Use SDK APIs for data and optionally embed individual widgets.

### Setup

```swift
import LuqtaSDK

// Custom mode is the default
let client = try LuqtaClient(config: LuqtaConfig(
    apiKey: "your-api-key",
    appId: "your-app-id"
))

// Initialize SDK
_ = try await client.initializeSdk()

// Set user and initialize
try client.setUser(LuqtaUser(email: "john@example.com"))
try await client.initializeUser()
```

### Or Sync + Initialize in One Call

```swift
try await client.syncAndInitializeUser(UserProfile(
    name: "John Doe",
    email: "john@example.com",
    phoneNumber: "+923147940690",
    gender: "male",
    country: "PK",
    policyAccept: true
))
```

---

## API Reference

### Client Methods

| Method | Description |
|--------|-------------|
| `initializeSdk()` | Initialize SDK and obtain app token |
| `initializeUser()` | Initialize user session |
| `syncUser(userData)` | Sync user profile to backend |
| `syncAndInitializeUser(userData)` | Sync + initialize in one call |
| `setUser(user)` | Set user identification (email or phone) |
| `tryRestoreSession()` | Restore session from Keychain tokens |
| `isSdkReady()` | Check if SDK is initialized |
| `isInitialized()` | Check if user is initialized |
| `clearUserToken()` | Clear user token (logout) |
| `render()` | Get pre-configured SwiftUI view |

---

### Contests API

Access via `client.contests`:

```swift
// Get all contests (paginated)
let response = try await client.contests.getAll(page: 1, perPage: 10)
let contests = response.data.items  // [[String: Any]]
let hasMore = response.data.hasNextPage

// Get trending contests
let trending = try await client.contests.getTrending()

// Get premium/VIP contests
let premium = try await client.contests.getPremium()

// Get recent contests
let recent = try await client.contests.getRecent()

// Participate in a contest
let result = try await client.contests.participate(contestId)

// Participate with access code (private contest)
let result = try await client.contests.participate(contestId, accessCode: "ABC123")

// Get contest progress
let progress = try await client.contests.getProgress(contestId)

// Get contest compete data (levels + progress)
let compete = try await client.contests.compete(contestId)

// Get user's contest history
let history = try await client.contests.getHistory()
```

Or use convenience methods on the client:

```swift
// Fetch contests with pagination
let response = try await client.fetchContests(page: 1, perPage: 10)

// Get public contests (no user auth required)
let public = try await client.getPublicContests()

// Get contest details with user progress
let details = try await client.getContestDetailsProgress(contestId, accessCode: nil)

// Participate
let result = try await client.participateContest(contestId)
```

---

### Levels API

Access via `client.levels`:

```swift
// Complete a text level
let result = try await client.levels.complete(levelId, data: [
    "textContent": "my answer"
])

// Complete a link level
let result = try await client.levels.complete(levelId, data: [
    "link": "https://example.com"
])

// Complete a QR level
let result = try await client.levels.complete(levelId, data: [
    "qrData": "scanned-qr-content"
])

// Complete an image level
let result = try await client.levels.completeWithImage(levelId, imageUrl: "https://...")

// Update level progress (mark as in-progress)
let result = try await client.levels.updateProgress(levelId)

// Get congratulation data after completion
let congrats = try await client.levels.getCongratulation(levelId: levelId, contestId: contestId)

// Validate a QR code
let result = try await client.levels.scanQR("qr-data-string")
```

---

### Quiz API

Access via `client.quiz`:

```swift
// Start a quiz attempt
let attempt = try await client.quiz.start(quizId)
// Returns: attemptId, questions, timer info

// Submit an answer
let result = try await client.quiz.submitAnswer(
    attemptId: attemptId,
    questionId: questionId,
    optionId: selectedOptionId
)

// Submit/complete the quiz
let result = try await client.quiz.submit(attemptId)
// Returns: score, passed, totalMarks
```

---

### Rewards API

Access via `client.rewards`:

```swift
// Get available rewards (no user auth required)
let rewards = try await client.rewards.getList()

// Get user earnings and points balance
let earnings = try await client.rewards.getEarnings()
// Returns: totalPoints, availablePoints, redeemedPoints

// Redeem a reward
let result = try await client.rewards.redeem(rewardId, points: 100)

// Get reward redemption history
let history = try await client.rewards.getHistory()

// Get prize history
let prizes = try await client.rewards.getPrizeHistory()
```

Or use convenience methods:

```swift
let categories = try await client.getCategories()
let rewards = try await client.getRewardsList()
```

---

### Notifications API

Access via `client.notifications`:

```swift
// Get all notifications
let notifications = try await client.notifications.getAll()

// Mark notifications as read
let result = try await client.notifications.markAsRead([notificationId1, notificationId2])

// Update notification settings
let result = try await client.notifications.updateSettings([
    "push_enabled": true,
    "email_enabled": false
])
```

---

### Profile API

Access via `client.profile`:

```swift
// Get user profile
let profile = try await client.profile.get()

// Get user activities
let activities = try await client.profile.getActivities()

// Get user progress across all contests
let progress = try await client.profile.getProgress()

// Submit feedback
let result = try await client.profile.submitFeedback(rating: 5, feedback: "Great app!")

// Delete account (irreversible)
let result = try await client.profile.deleteAccount()
```

---

### HTTP Methods

For custom API calls:

```swift
// Application-level request (no user auth required)
let data = try await client.applicationRequest("/sdk/app/contest/all", method: "GET")

// User-level request (requires user initialization)
let data = try await client.userRequest("/sdk/app/contest/history", method: "GET")

// Shorthand methods
let data = try await client.get("/endpoint", params: ["key": "value"])
let data = try await client.post("/endpoint", body: ["key": "value"])
let data = try await client.put("/endpoint", body: ["key": "value"])
let data = try await client.delete("/endpoint")
let data = try await client.patch("/endpoint", body: ["key": "value"])
```

---

## Available Widgets

Use these pre-built SwiftUI views in your custom UI:

### Screens

| Widget | Description |
|--------|-------------|
| `ContestsScreen` | Full contests listing with carousel and see-all |
| `ContestDetailScreen` | Contest detail with levels, progress, and completion flows |

### Cards & Items

| Widget | Description |
|--------|-------------|
| `ContestCard` | Contest card with banner carousel, timer, pills |
| `LevelItemView` | Level row with type icon, name, and completion status |
| `AccessCodeSheet` | Bottom sheet for entering private contest access codes |

### Level Completion Views

| Widget | Level Type | Description |
|--------|------------|-------------|
| `TextLevelView` | Text | Text input submission |
| `QRLevelView` | QR Code | Camera QR scanner |
| `LinkLevelView` | Link | Link visit verification |
| `ImageLevelView` | Image | Camera/gallery image upload |

### Interactive Widgets

| Widget | Description |
|--------|-------------|
| `QuizWidget` | Quiz questions with options, timer, and scoring |
| `CongratulationDialog` | Animated celebration on completion |
| `LuqtaToast` | Toast notification overlay |

### Utility Widgets

| Widget | Description |
|--------|-------------|
| `RemoteImage` | Async image loader with placeholder |
| `ShimmerView` | Loading shimmer animation |

---

## Models

### LuqtaConfig

```swift
LuqtaConfig(
    mode: .preconfigured,           // .preconfigured or .custom (default)
    apiKey: "your-api-key",         // Required
    appId: "your-app-id",          // Required
    production: false,              // Default: false
    user: LuqtaUser(               // Optional: set user at init
        email: "user@example.com"
    ),
    baseURL: nil,                   // Optional: custom base URL
    timeout: 30,                    // Default: 30 seconds
    headers: ["X-Custom": "value"], // Optional: custom headers
    branding: LuqtaBranding(...),   // Optional: UI customization
    locale: "en",                   // "en" or "ar"
    rtl: false,                     // RTL layout
    screens: ["contests", "quizzes", "rewards", "profile"],
    onAction: { action in },        // Action callback
    onError: { error in }           // Error callback
)
```

### LuqtaUser

Identify users by email, phone number, or both:

```swift
// Email only
LuqtaUser(email: "user@example.com")

// Phone only (international format)
LuqtaUser(phoneNumber: "+923147940690")

// Both
LuqtaUser(email: "user@example.com", phoneNumber: "+923147940690")
```

**Phone number format:** Must start with `+` followed by country code (up to 15 digits).

| Country | Example |
|---------|---------|
| Pakistan | `+923147940690` |
| USA | `+11234567890` |
| UK | `+441234567890` |
| UAE | `+971501234567` |

### UserProfile

Full user profile for sync:

```swift
UserProfile(
    name: "John Doe",
    email: "john@example.com",
    phoneNumber: "+923147940690",
    dob: "1990-01-01",              // ISO 8601
    gender: "male",
    country: "PK",
    verified: true,
    imageUrl: "https://...",
    interestedIn: ["sports", "music"],
    policyAccept: true
)
```

### LuqtaBranding

Customize the look and feel:

```swift
LuqtaBranding(
    primaryColor: "#9333ea",
    secondaryColor: "#4f46e5",
    backgroundColor: "#ffffff",
    textColor: "#111827",
    logoUrl: "https://...",
    appName: "My App",
    borderRadius: 8,
    fontFamily: nil
)
```

### LuqtaMode

```swift
.custom          // Use SDK APIs with your own UI
.preconfigured   // Auto-rendered UI — call render()
```

---

## Theming & Branding

### Set at Initialization

```swift
LuqtaConfig(
    branding: LuqtaBranding(
        primaryColor: "#9333ea",
        secondaryColor: "#6366f1",
        backgroundColor: "#ffffff",
        textColor: "#111827"
    )
)
```

### Update at Runtime

```swift
client.setBranding(LuqtaBranding(primaryColor: "#FF5722"))
```

---

## Localization

### Set at Initialization

```swift
LuqtaConfig(
    locale: "ar",   // "en" or "ar"
    rtl: true       // Enable RTL for Arabic
)
```

### Update at Runtime

```swift
client.setLocale("ar")
client.setRtl(true)
```

### Supported Languages

| Language | Code | RTL |
|----------|------|-----|
| English | `en` | No |
| Arabic | `ar` | Yes |

---

## Error Handling

### Using Do-Catch

```swift
do {
    _ = try await client.initializeSdk()
} catch let error as LuqtaError {
    print("Code: \(error.code)")       // e.g. "SDK_INIT_FAILED"
    print("Message: \(error.message)") // Human-readable message
    print("Status: \(error.status)")   // HTTP status code (optional)
}
```

### Using Callbacks

```swift
LuqtaConfig(
    onAction: { action in
        // action is [String: Any] with type & data
        print("User action: \(action)")
    },
    onError: { error in
        if let luqtaError = error as? LuqtaError {
            showAlert(luqtaError.message)
        }
    }
)
```

### Error Codes

#### SDK Initialization

| Code | Description |
|------|-------------|
| `SDK_INIT_FAILED` | SDK initialization failed |
| `SDK_NOT_INITIALIZED` | SDK not initialized before making requests |
| `MISSING_SDK_TOKEN` | No SDK token received |

#### User

| Code | Description |
|------|-------------|
| `USER_INIT_FAILED` | User initialization failed |
| `USER_NOT_INITIALIZED` | User not initialized before making requests |
| `USER_NOT_SYNCED` | User needs to be synced first |
| `MISSING_USER_IDENTIFIER` | Email or phone number required |
| `USER_SYNC_FAILED` | User profile sync failed |

#### Validation

| Code | Description |
|------|-------------|
| `MISSING_API_KEY` | API key not provided |
| `MISSING_APP_ID` | App ID not provided |
| `INVALID_EMAIL_FORMAT` | Invalid email format |
| `INVALID_PHONE_FORMAT` | Invalid phone number format |
| `INVALID_PARAMETER` | Invalid parameter value |

#### Network

| Code | Description |
|------|-------------|
| `REQUEST_FAILED` | API request failed |
| `TIMEOUT` | Request timed out |
| `NETWORK_ERROR` | No network connection |

#### Security

| Code | Description |
|------|-------------|
| `RATE_LIMIT_EXCEEDED` | Too many requests |
| `TOKEN_VALIDATION_FAILED` | Token validation error |
| `DUPLICATE_REQUEST` | Duplicate request detected |

---

## Configuration Methods

Update SDK settings at runtime:

```swift
// API key
try client.setApiKey("new-api-key")
client.getApiKey()  // Returns masked key

// App ID
try client.setAppId("new-app-id")
client.getAppId()

// Production mode
client.setProduction(true)
client.isProductionMode()

// Timeout
try client.setTimeout(60)  // seconds
client.getTimeout()

// Base URL
client.getBaseURL()

// Mode
client.getMode()  // .custom or .preconfigured

// Security status
let status = client.getSecurityStatus()
```

---

## Example App

See the [example app](../examples/ios_example_swift/) for a complete implementation including:

- User authentication (login/signup)
- SDK initialization with session restore
- Pre-configured UI with `render()`
- Branding customization
- Error handling

### Running the Example

```bash
cd examples/ios_example_swift
pod install
open LuqtaExample.xcworkspace
```

---

## Support

- **Email**: support@luqta.com
- **Issues**: [GitHub Issues](https://github.com/MTayyaBH/luqta-ios-sdk/issues)
- **Swift Package Index**: [swiftpackageindex.com/MTayyaBH/luqta-ios-sdk](https://swiftpackageindex.com/MTayyaBH/luqta-ios-sdk)

## License

MIT License - See [LICENSE](LICENSE) file for details.
