---
description: How to deploy the Flutter app to TestFlight using Codemagic
---

# Deploying to TestFlight with Codemagic

This guide assumes you have a **Codemagic Account** and an **Apple Developer Account**.

## 1. Prerequisites
1.  **App Store Connect API Key**:
    *   Log in to App Store Connect -> Users and Access -> Integrations.
    *   Generate a new API Key with "App Manager" access.
    *   Download the `.p8` file (Save this safely, you can only download it once!).
    *   Note the `Issuer ID` and `Key ID`.

2.  **App ID**:
    *   Ensure your Bundle ID in `ios/Runner/Info.plist` matches an App ID created in your Apple Developer Portal.

## 2. Codemagic Setup (Environment Variables)
1.  Go to Codemagic -> Add Application -> Select Repository.
2.  Go to the **App Settings** -> **Environment variables**.
3.  Add the following secure variables (Select "Secure" checkbox):
    *   `APP_STORE_CONNECT_ISSUER_ID`: Your Issuer ID.
    *   `APP_STORE_CONNECT_KEY_IDENTIFIER`: Your Key ID.
    *   `APP_STORE_CONNECT_PRIVATE_KEY`: The content of your `.p8` file.
    *   `CERTIFICATE_PRIVATE_KEY`: (Optional) If you manually handle certificates. Codemagic can auto-generate them if you use the API Key correctly.

## 3. Configuration (`codemagic.yaml`)
I have created a `codemagic.yaml` file in your project root. This file defines the build pipeline.

### Key Sections:
*   **scripts**: Installs dependencies and runs `flutter build ipa`.
*   **publishing**: Uploads the artifact (`.ipa`) to TestFlight using the API Key.

## 4. Run the Build
1.  Push your code (including `codemagic.yaml`) to your git repository.
2.  In Codemagic, start a new build using the **default-workflow** (or whatever name is in the yaml).
3.  Watch the build logs.
4.  Once complete, check your email or TestFlight for the invite!
