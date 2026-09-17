# Rdmns iOS Application - Complete Project & Deployment Guide

The **Rdmns iOS Application** has been fully created in your workspace directory:
📁 **`c:\Users\hesha\Documents\Rdmns iOS`**

It contains the **exact same feature set** as the Android application:
- 📱 **100% Fullscreen Edge-to-Edge WKWebView** (`https://rdmns.hesn.xyz`).
- 🎨 **Animated Splash Percentage Counter (0% -> 100%)** with circular progress animation and smooth 400ms fade-out.
- 🔔 **5-State Live Status Tracking Notifications** (Uber Eats style: Order Received, Preparing, On The Way, Arriving Soon, Delivered).
- 🔄 **Automatic Server API Polling** (`https://rdmns.hesn.xyz/api/status.php?userId=USER_ID`).
- 📲 **In-App Auto-Update Checker** (`https://rdmns.hesn.xyz/update.json`).
- 🔗 **Deep Links & Intent Handlers** (WhatsApp, Phone, Mail, Maps).
- 📷 **Camera, Photo Library & Microphone Permissions** (`Info.plist`).

---

## 📁 iOS Project File Structure

```
Rdmns iOS/
├── RdmnsApp.swift              (App Main Entry Point & User Notification Delegate)
├── ContentView.swift           (SwiftUI View with animated 0%-100% loading overlay)
├── WebView.swift              (WKWebView wrapper with mobile UserAgent & deep links)
├── LiveNotificationManager.swift (5-Status Uber Eats style Live Notification manager)
├── AutoUpdater.swift           (In-App Update checker)
├── Info.plist                  (iOS permissions & background modes)
└── Package.swift               (Swift Package Manager manifest)
```

---

## 🚀 How to Open & Build in Xcode

1. Copy or extract the **`Rdmns iOS`** folder to any **Mac**.
2. Open **Xcode** (Version 14+ / 15+).
3. Select **File -> Open** and choose the `Rdmns iOS` folder (or double-click `Package.swift`).
4. Select your iOS device or Simulator and press **`Cmd + R`** to run!

---

## 📦 How to Export `.ipa` File for Distribution / TestFlight

1. In Xcode, select **Product -> Scheme -> Edit Scheme** and choose **Release**.
2. Select **Product -> Archive**.
3. Once the archive completes, click **Distribute App**:
   - Choose **App Store Connect / TestFlight** for public iOS distribution.
   - Choose **Ad-Hoc / Development** to export a direct `.ipa` installer file for registered iOS devices.
