---
name: niyyah-marketing
description: Generate or extend Niyyah's bilingual (EN/AR) marketing assets — Instagram/Facebook reels, carousels, stories, profile/cover images, cinematic launch trailers, and caption/bio/group-post copy. Use for any Niyyah social or marketing asset or copy task.
---

# Niyyah marketing assets

Niyyah (نِيّة) is a live iOS app: a Qur'an-gated focus app ("pause before you scroll" — read an
ayah to unlock distracting apps for 15 minutes; plus daily duas, a weekly/monthly Qur'an completion
plan, prayer tracking, Qur'an progress, and a qibla compass). All assets are **bilingual EN + AR**.

## Copy rules (always)
- English and Arabic are both first-class. Write Arabic natively (warm Modern Standard Arabic), not a literal translation.
- **No excessive em dashes** (owner preference). Use periods, commas, and line breaks.
- Voice: calm, intentional, warm, never preachy or ad-spammy. Quote ayat accurately
  (signature: «إِنَّ مَعَ الْعُسْرِ يُسْرًا», Ash-Sharh 94:6). Audience is music-sensitive, so default audio guidance to nasheed / vocals-only.
- Existing copy to match/extend: `marketing/social/PROFILES.md` (bios + em-dash-free reel captions),
  `SOCIAL_KIT.md` (captions, audio, hashtags, story + carousel copy), `GROUP_POSTS.md` (group posts).

## Rendering assets (Remotion) — `marketing/remotion/`
`npm install` once. Bilingual dictionary in `src/strings.ts`; palette in `src/theme.ts`
(sage/cream light + midnight/gold "premium night"); brand mark `public/icon_fg.png` (icon sage `#4f5d45`).
Compositions are registered in `src/Root.tsx`. Always verify visually: render a still and view it —
`npx remotion still src/index.ts <Comp> out/qa/x.png --frame=<n>` (add `--props='{"lang":"ar","i":3}'`
for Carousel/Story), then read the PNG. Tile many stills with ffmpeg for fast review.

| Want | Composition(s) | Script | Spec |
|---|---|---|---|
| App Store preview | `Walkthrough` | `npm run render` | 1290×2796 |
| IG/TikTok reel | `ReelEN` / `ReelAR` | `npm run reels` | 1080×1920 |
| Carousel (7 slides) | `Carousel` (props `{lang,i}`) | `npm run posts` | 1080×1350 |
| Story (4 frames) | `Story` (props `{lang,i}`) | `npm run posts` | 1080×1920 |
| FB profile / cover | `Profile` / `FBCover` | `npx remotion still …` | 1080×1080 / 1640×624 |
| Launch trailer | `ReleaseEN` / `ReleaseAR` | `npm run trailers` | 1920×1080 |

The 7 app scenes are exported from `src/Walkthrough.tsx` and reusable (the trailer in `src/Release.tsx`
reuses them). To add copy or a locale, extend `src/strings.ts`; register new sizes in `src/Root.tsx`.
Videos render **silent** (add audio in the editor).

## Notes
- The trailer's App Store badge is a styled stand-in; swap Apple's official badge for full compliance.
- Full pipeline reference: `marketing/README.md`.
