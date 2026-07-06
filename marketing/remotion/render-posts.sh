#!/usr/bin/env bash
# Render all Instagram carousel + story stills for Niyyah (EN + AR).
# Carousel: 1080×1350 (4:5) · Story: 1080×1920 (9:16)
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p out/posts

for lang in en ar; do
  for i in 1 2 3 4 5 6 7; do
    npx remotion still src/index.ts Carousel "out/posts/car_${lang}_${i}.png" --props="{\"lang\":\"$lang\",\"i\":$i}"
  done
  for i in 1 2 3 4; do
    npx remotion still src/index.ts Story "out/posts/story_${lang}_${i}.png" --props="{\"lang\":\"$lang\",\"i\":$i}"
  done
done

echo "Done → out/posts/ (14 carousel slides, 8 story frames)"
