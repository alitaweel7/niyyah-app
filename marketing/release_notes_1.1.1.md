# Niyyah 1.1.1 — App Store submission copy

Build: `1.1.1+9` · Trust patch: re-lock reliability + streak correctness. No new features.

## What's New (English)

This update makes the gate more dependable:

- Apps now re-lock reliably when your unlock window ends, even if Niyyah stays closed
- Gated categories no longer lose their protection after a temporary unlock
- A gentle notification lets you know when your unlock window ends
- Reading streaks now survive midnight, travel, and daylight saving changes

Small fixes and refinements throughout.

## ما الجديد (العربية)

في هذا التحديث جعلنا البوابة أكثر موثوقية:

- تعود التطبيقات إلى القفل تلقائيًا عند انتهاء نافذة الاستخدام، حتى لو بقي تطبيق نِيّة مغلقًا
- لم تعد الفئات المحمية تفقد حمايتها بعد الفتح المؤقت
- إشعار لطيف يخبرك عند انتهاء نافذة الاستخدام
- سلسلة قراءتك اليومية محفوظة الآن عبر منتصف الليل وأثناء السفر ومع التوقيت الصيفي

إصلاحات وتحسينات صغيرة في مختلف أنحاء التطبيق.

## App Review note

Same Family Controls usage as 1.1.0 (see `release_notes_1.1.0.md`): user-initiated
self-restriction with `.individual` authorization; no child accounts, no parental controls.
This update only hardens the re-lock timing (DeviceActivity usage-threshold events + a
backstop schedule) and fixes shield restoration; no new entitlements, no new data collection.

## While in App Store Connect (from the audit)

- Upload the app preview video: `marketing/remotion/out/walkthrough_886x1920.mp4` (6.5" slot).
- Add the Arabic listing localization (description source: `store/app_store_description.md`;
  translate natively per the copy rules in `.claude/skills/niyyah-marketing/SKILL.md`).
