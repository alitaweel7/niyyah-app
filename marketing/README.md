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

## App preview video — `remotion/`

`remotion/out/walkthrough.mp4` — **1290 × 2796, 30 fps, ~28 s, H.264** (iPhone 6.9"
app-preview spec; 15–30 s required). A 7-scene walkthrough: intro → gate → unlock →
prayer tracker → learning → Qibla → outro.

```bash
cd marketing/remotion
npm install            # first time only
npm run render         # -> out/walkthrough.mp4
npm run studio         # live-edit the timeline in the browser
```

Scenes and timing live in `src/Walkthrough.tsx`; brand palette in `src/theme.ts`.

> iPad app-preview video is not included — App Store Connect does not require it, and
> the iPad screenshot set already covers tablet. A dedicated iPad-tuned video can be
> added on request (needs its own layout pass for the 1200 × 1600 / 1600 × 1200 frame).

## Uploading in App Store Connect

1. **My Apps → Niyyah → (version) → App Previews and Screenshots.**
2. Select the **iPhone 6.9"** display → drag in the 7 `iphone_*.png` in order; drag
   `walkthrough.mp4` into the App Preview slot.
3. Select the **iPad Pro (12.9") / 13"** display → drag in the 5 `ipad_*.png`.
4. Save. (The 6.9" and 13" sets satisfy the required iPhone/iPad sizes.)
