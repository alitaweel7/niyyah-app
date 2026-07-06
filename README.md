# Niyyah — نِيّة

**Set your niyyah before you scroll.**

[![App Store](https://img.shields.io/badge/App_Store-Niyyah_—_Set_Your_Intention-0D96F6?logo=apple&logoColor=white)](https://apps.apple.com/app/id6761061944)

Niyyah places a calm Quran or Dua reading between you and your social media apps. Instead of
mindlessly opening Instagram or TikTok, you spend a few minutes with the words of Allah — then the
app unlocks for a short window, and the gate returns.

Not another app blocker: no guilt trips, no gamification, no ads, no accounts, no tracking.
A spiritual intentionality tool for Muslims who want to reclaim their attention with purpose.

**[Download on the App Store](https://apps.apple.com/app/id6761061944)** · [Website](https://alitaweel7.github.io/niyyah/) · [Privacy policy](https://alitaweel7.github.io/niyyah-app/privacy.html)

## Features

- **Quran-gated apps** — shield your chosen apps with Apple Screen Time; read to unlock a temporary window
- **Full Quran** in Uthmani script (Amiri typography) with English translation — short surahs, random ayahs, or sequential reading with a saved position
- **76+ authentic Duas** from the Quran and Sunnah, with sources
- **Prayer times & tracker** — on-device calculation, region-aware methods, the five prayers on your dashboard
- **Qibla compass**
- **Progress & streaks** — accurate reading timeline and true % of the Quran completed
- **Fully bilingual** — English and Arabic, complete RTL support
- **Calm Minimal light theme & Premium Night dark theme**
- **Private by design** — everything stays on your device; no data collected

## How it works (iOS)

Niyyah uses Apple's FamilyControls / Screen Time APIs: a `ShieldConfiguration` extension renders
the gate (with a rotating ayah) over your chosen apps, a `ShieldAction` extension hands you into
the reading flow, and a `DeviceActivityMonitor` extension restores the shield when your unlock
window ends. Reading content is bundled (Tanzil-sourced Quran text, Sahih International
translation) and read fully offline.

## Stack

Flutter (Riverpod, go_router, Drift/SQLite) + native Swift for the Screen Time integration.
iOS 16+. The `android/` target exists but is not shipped.

```
lib/            Flutter app (features, services, data layer, l10n)
ios/            Runner + ShieldConfiguration / ShieldAction / DeviceActivityMonitor extensions
assets/quran/   Bundled Quran database
marketing/      Screenshots + Remotion video/social pipeline
docs/           GitHub Pages (landing + privacy policy)
```

## Building

```bash
flutter pub get
open ios/Runner.xcworkspace   # set your signing team
flutter run --release -d <device-id>
```

Screen Time APIs require a **physical device** (they do nothing in the Simulator) and the
FamilyControls entitlement on your Apple Developer team.

## License

Source-available for reading and learning. **All rights reserved** — this is not open-source
software; please don't republish the app or derivatives to any app store.

---

جعل الله هذا العمل خالصًا لوجهه الكريم
