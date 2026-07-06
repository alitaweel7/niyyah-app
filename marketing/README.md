# Niyyah — App Store marketing assets

All assets are built to current App Store Connect specs (opaque RGB, no alpha).
Screenshots are generated from self-contained HTML rendered with headless Chrome;
the app-preview video is a Remotion project.

## Screenshots — `screenshots/`

Rendered at the exact required pixel sizes. To re-render after editing any `.html`:

```bash
cd marketing/screenshots
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
# iPhone 6.9"  (1320 x 2868)
for f in iphone_*; do f=${f%.html}; [ -f "$f.html" ] && \
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
  --window-size=1320,2868 --virtual-time-budget=6000 --screenshot="$f.png" "file://$PWD/$f.html"; done
# iPad 13"     (2048 x 2732)
for f in ipad_*; do f=${f%.html}; [ -f "$f.html" ] && \
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
  --window-size=2048,2732 --virtual-time-budget=6000 --screenshot="$f.png" "file://$PWD/$f.html"; done
```

### iPhone 6.9" — 1320 × 2868 (upload all 7; first 3 appear on the install sheet)

| Order | File | Screen | Headline | Theme |
|-------|------|--------|----------|-------|
| 1 | `iphone_01_gate.png` | Reading gate | Pause before you scroll | Light |
| 2 | `iphone_02_tracker.png` | Prayer tracker | Track your five daily prayers | Light |
| 3 | `iphone_03_learning.png` | Learning progress | Your journey through the Qur'an | Light |
| 4 | `iphone_04_qibla.png` | Qibla compass | Find the Qibla, wherever you are | Dark |
| 5 | `iphone_05_arabic.png` | Arabic / RTL | التطبيق بالكامل باللغة العربية | Dark |
| 6 | `iphone_06_nudge.png` | Prayer-aware gating | The right nudge at the right time | Dark |
| 7 | `iphone_07_blocking.png` | App blocking | You choose what to pause | Light |

### iPad 13" — 2048 × 2732 (upload all 5)

| Order | File | Screen | Theme |
|-------|------|--------|-------|
| 1 | `ipad_01_gate.png` | Reading gate | Light |
| 2 | `ipad_02_tracker.png` | Prayer tracker | Light |
| 3 | `ipad_03_learning.png` | Learning progress | Light |
| 4 | `ipad_04_qibla.png` | Qibla compass | Dark |
| 5 | `ipad_05_arabic.png` | Arabic / RTL | Dark |

`_shared.css` / `_shared_ipad.css` hold the common device-frame + brand styles.

## Remotion project — `remotion/`

One Remotion project renders the App Store preview **and** all social video/image assets.
All copy is bilingual (EN + AR) from a single locale table in `src/strings.ts`; Arabic is
RTL with the bundled Amiri font (`public/`), Arabic-Indic numerals, and system-safe layout.
Brand palette in `src/theme.ts`; locale/format context in `src/ctx.tsx`; shared phone + the
7 app scenes in `src/Phone.tsx` / `src/Walkthrough.tsx` (scenes are exported and reused by
the trailer); carousel/story/profile/cover in `src/Posts.tsx`; launch trailer in
`src/Release.tsx`; all compositions registered in `src/Root.tsx`.

```bash
cd marketing/remotion
npm install            # first time only
npm run studio         # live-edit any composition in the browser
```

| Composition | npm script | Output | Spec | Use |
|---|---|---|---|---|
| `Walkthrough` | `npm run render` | `out/walkthrough.mp4` | 1290×2796 · ~28s | App Store 6.9" app preview (EN store master) |
| `ReelEN` / `ReelAR` | `npm run reels` | `out/reel_{en,ar}.mp4` | 1080×1920 · 9:16 · ~28s | Instagram / TikTok Reels (full-bleed) |
| `Carousel` | `npm run posts` | `out/posts/car_{en,ar}_1..7.png` | 1080×1350 · 4:5 | IG/FB carousel, 7 slides each |
| `Story` | `npm run posts` | `out/posts/story_{en,ar}_1..4.png` | 1080×1920 · 9:16 | IG/FB stories, 4 frames each |
| `Profile` | (still) | `out/brand/profile_fb.png` | 1080×1080 | FB/IG profile picture (App Store mark) |
| `FBCover` | (still) | `out/brand/fb_cover.png` | 1640×624 | FB page cover (bilingual, mobile-safe center) |
| `ReleaseEN` / `ReleaseAR` | `npm run trailers` | `out/release_{en,ar}.mp4` | 1920×1080 · 16:9 · ~25s | Cinematic launch trailer, premium-night theme |

- `render-posts.sh` renders the full carousel + story sets. Profile/FBCover render individually with `npx remotion still src/index.ts Profile out/brand/profile_fb.png` (and `FBCover`).
- Reels + trailer are **silent** (add audio in the editor). The trailer uses a styled "Download on the App Store" badge; swap Apple's official badge for full compliance.
- `out/walkthrough_886x1920.mp4` (old letterboxed preview) is **superseded** by `reel_en.mp4`.
- Brand mark art: `public/icon_fg.png` (transparent book + crescent). Icon sage `#4f5d45`.

## Social copy decks — `social/`
- `SOCIAL_KIT.md` — reel captions, suggested audio, hashtag sets, story + carousel copy, posting strategy, and an asset/spec map. (Captions here still use em dashes; `PROFILES.md` holds the em-dash-free versions.)
- `PROFILES.md` — Instagram + Facebook bios (EN/AR), current em-dash-free reel captions, brand-image specs.
- `GROUP_POSTS.md` — Facebook/community group posts: group-safe (no link) EN + AR, plus a bilingual share post with an App Store link placeholder.

> iPad app-preview video is not included — App Store Connect does not require it, and
> the iPad screenshot set already covers tablet.

## Uploading in App Store Connect

1. **My Apps → Niyyah → (version) → App Previews and Screenshots.**
2. Select the **iPhone 6.9"** display → drag in the 7 `iphone_*.png` in order; drag
   `walkthrough.mp4` into the App Preview slot.
3. Select the **iPad Pro (12.9") / 13"** display → drag in the 5 `ipad_*.png`.
4. Save. (The 6.9" and 13" sets satisfy the required iPhone/iPad sizes.)
