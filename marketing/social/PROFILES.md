# Niyyah (نِيّة) — Profiles & Reel Captions

App is **live on the App Store**. Copy below avoids em dashes by request. Replace `APP_STORE_LINK` with your real listing URL.

---

## 1. Instagram Bio

Instagram bios cap at 150 characters. Both versions below sit comfortably under that.

### English (~112 chars)
```
نِيّة · Niyyah
Pause before you scroll.
Read an ayah, set your niyyah, unlock your apps.
Now on the App Store ↓
```

### العربية (~99 chars)
```
نِيّة · Niyyah
توقّف قبل أن تتصفّح.
اقرأ آية، اعقد نيّتك، وافتح تطبيقاتك.
متوفّر الآن على App Store ↓
```

> Put `APP_STORE_LINK` in the website field (or your Linktree). If you run one bilingual account, lead with English and add the Arabic tagline line; if you run a dedicated Arabic account, use the Arabic version on its own.

---

## 2. Facebook

Facebook Pages have a short **Bio** field (about 101 characters) and a longer **About / Intro** section. Both are provided.

### Short bio — English (~99 chars)
```
Pause before you scroll. Read an ayah, set your niyyah, then unlock your apps. Now on the App Store.
```

### Short bio — العربية
```
توقّف قبل أن تتصفّح. اقرأ آية، اعقد نيّتك، ثم افتح تطبيقاتك. متوفّر الآن على App Store.
```

### About / Intro — English
```
Niyyah turns the urge to scroll into a moment with the Quran. When you open a distracting app, it greets you with an ayah to read and an intention to set, then unlocks the app for 15 focused minutes. Niyyah also tracks your five daily prayers, follows your progress through the Quran, and points you to the qibla. Less mindless scrolling, more meaning. Download Niyyah on the App Store.
```

### About / Intro — العربية
```
يحوّل «نِيّة» اندفاعك نحو التصفّح إلى لحظةٍ مع القرآن. حين تفتح تطبيقًا يشتّت انتباهك، يستقبلك بآيةٍ تقرؤها ونيّةٍ تعقدها، ثم يفتح لك التطبيق خمس عشرة دقيقةً من التركيز. كما يتابع «نِيّة» صلواتك الخمس، ويرصد تقدّمك في القرآن، ويدلّك على القبلة. تصفّحٌ أقل بلا وعي، ومعنى أكثر. حمّل «نِيّة» الآن من App Store.
```

---

## 3. Reel Captions

### English reel → English caption
```
Before you open Instagram, the Quran opens first.

You reach for the app out of habit. Niyyah meets you with one ayah and a quiet moment to set your intention. Read it, mean it, then continue for 15 minutes on purpose.

Along the way it tracks your five daily prayers, shows how much of the Quran you have read, and points you to the qibla.

Set your niyyah before you scroll. Niyyah is now on the App Store.

#Niyyah #Quran #Islam #Muslim #DeenOverDopamine #DigitalWellbeing #IntentionalLiving #MuslimApp #DailyQuran #PrayerTracker #ScreenTime #iOSApp
```

### Arabic reel → Arabic caption
```
قبل أن تفتح إنستغرام، يفتح القرآن أولًا.

تمدّ يدك إلى التطبيق بحكم العادة، فيستقبلك «نِيّة» بآيةٍ ووقفةٍ تعقد فيها نيّتك. اقرأها، واعقد عليها قلبك، ثم تابِع خمس عشرة دقيقةً عن وعيٍ وقصد.

وفي أثناء ذلك يتابع صلواتك الخمس، ويُريك كم قرأت من القرآن، ويدلّك على القبلة.

اعقد نيّتك قبل أن تتصفّح. «نِيّة» متوفّر الآن على App Store.

#نِيّة #القرآن #الإسلام #مسلم #قرآن_كريم #تطبيق_إسلامي #اقرأ_القرآن #الصلاة #ورد_القرآني #وقتك_أمانة #الخشوع #تطبيقات_إسلامية
```

> First comment tip: drop `APP_STORE_LINK` in the first comment of each reel so people can tap straight through.

---

## 4. Brand Images

| Asset | File | Size | Notes |
|---|---|---|---|
| **Profile picture** | `marketing/remotion/out/brand/profile_fb.png` | 1080×1080 | Facebook and Instagram crop it to a circle. The mark is centered and safe. Same image works for both. |
| **Facebook cover** | `marketing/remotion/out/brand/fb_cover.png` | 1640×624 | Bilingual. All text sits in the mobile-safe center; the faint نِيّة on the right is meant to be cropped. |

**Upload tips**
- Facebook cover renders wider on desktop and taller on mobile, so it crops differently on each. Everything important here is centered, so it stays visible on both.
- The profile picture matches the App Store icon exactly, so people recognize Niyyah across the store and your socials.

Re-render either image from `marketing/remotion/`:
```
npx remotion still src/index.ts Profile out/brand/profile_fb.png
npx remotion still src/index.ts FBCover out/brand/fb_cover.png
```
