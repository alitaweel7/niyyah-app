#!/usr/bin/env python3
"""
Content loading tool for Prophet stories, Sahabah stories, and Islamic history.

Usage:
  python3 tools/load_stories.py stories.json

JSON format:
[
  {
    "type": "prophet",
    "name_arabic": "يوسف",
    "name_english": "Yusuf",
    "segments": [
      {
        "title": "The Dream of Young Yusuf",
        "body": "When Yusuf was a young boy, he saw a dream...",
        "source": "Ibn Kathir, Stories of the Prophets"
      },
      {
        "title": "The Jealousy of His Brothers",
        "body": "Yusuf's brothers grew jealous of the love...",
        "source": "Ibn Kathir, Stories of the Prophets"
      }
    ]
  },
  {
    "type": "sahabah",
    "name_arabic": "أبو بكر الصديق",
    "name_english": "Abu Bakr as-Siddiq",
    "segments": [
      {
        "title": "The First to Believe",
        "body": "Abu Bakr was the first adult male to accept Islam...",
        "source": "Hayatus Sahabah"
      }
    ]
  },
  {
    "type": "history",
    "name_english": "The Hijra to Medina",
    "name_arabic": "الهجرة إلى المدينة",
    "year_hijri": "1 AH",
    "segments": [
      {
        "title": "The Journey Begins",
        "body": "When persecution in Makkah became unbearable...",
        "source": "Ibn Kathir, Al-Bidaya wan-Nihaya"
      }
    ]
  }
]

Each segment should be 500-800 words of authenticated content.
"""
import json
import os
import sqlite3
import sys

DB_PATH = os.path.join(os.path.dirname(__file__), '..', 'assets', 'quran', 'quran.db')

def load_stories(json_path):
    with open(json_path, 'r') as f:
        data = json.load(f)

    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()

    prophet_count = 0
    sahabah_count = 0
    history_count = 0

    for item in data:
        item_type = item.get('type', 'prophet')
        segments = item.get('segments', [])
        total_segments = len(segments)

        if item_type == 'prophet':
            name_ar = item.get('name_arabic', '')
            name_en = item.get('name_english', '')

            for i, seg in enumerate(segments):
                c.execute("""
                    INSERT INTO prophet_stories
                    (prophet_name_arabic, prophet_name_english, segment_number, total_segments, title, body_text, source_reference, is_premium)
                    VALUES (?, ?, ?, ?, ?, ?, ?, 0)
                """, (name_ar, name_en, i + 1, total_segments,
                      seg.get('title', ''), seg.get('body', ''),
                      seg.get('source', '')))
                prophet_count += 1

        elif item_type == 'sahabah':
            name_ar = item.get('name_arabic', '')
            name_en = item.get('name_english', '')

            for i, seg in enumerate(segments):
                c.execute("""
                    INSERT INTO sahabah_stories
                    (sahabah_name_arabic, sahabah_name_english, segment_number, total_segments, title, body_text, source_reference, is_premium)
                    VALUES (?, ?, ?, ?, ?, ?, ?, 0)
                """, (name_ar, name_en, i + 1, total_segments,
                      seg.get('title', ''), seg.get('body', ''),
                      seg.get('source', '')))
                sahabah_count += 1

        elif item_type == 'history':
            name_en = item.get('name_english', '')
            name_ar = item.get('name_arabic', '')
            year = item.get('year_hijri', '')

            for i, seg in enumerate(segments):
                c.execute("""
                    INSERT INTO islamic_history
                    (event_name_arabic, event_name_english, year_hijri, segment_number, total_segments, title, body_text, source_reference, is_premium)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, 0)
                """, (name_ar, name_en, year, i + 1, total_segments,
                      seg.get('title', ''), seg.get('body', ''),
                      seg.get('source', '')))
                history_count += 1

    conn.commit()

    print(f"Loaded: {prophet_count} prophet story segments, "
          f"{sahabah_count} sahabah story segments, "
          f"{history_count} history segments")

    # Show totals
    for table in ['prophet_stories', 'sahabah_stories', 'islamic_history']:
        c.execute(f'SELECT COUNT(*) FROM {table}')
        print(f"  {table}: {c.fetchone()[0]} total")

    conn.close()

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print(__doc__)
        print("\nNo JSON file provided.")
        print("Create a JSON file with the format above, then run:")
        print("  python3 tools/load_stories.py your_stories.json")
        sys.exit(0)

    json_path = sys.argv[1]
    if not os.path.exists(json_path):
        print(f"File not found: {json_path}")
        sys.exit(1)

    load_stories(json_path)
    print("\nDone!")
