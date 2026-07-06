#!/usr/bin/env python3
"""
Load Duas/Adhkar data from open source repos into the app's SQLite database.

Sources:
- Kind-Unes/Adhkar-Duaa-Multilingual-Database (Arabic duas by category)
- Seen-Arabic/Morning-And-Evening-Adhkar-DB (Arabic + English + sources)

Run: python3 tools/load_duas.py
"""
import json
import os
import re
import sqlite3
import sys

DB_PATH = os.path.join(os.path.dirname(__file__), '..', 'assets', 'quran', 'quran.db')

# Category mapping from Arabic to English
ARABIC_CATEGORIES = {
    'دعاء دخول الخلاء': ('Entering the restroom', 'daily_life'),
    'دعاء الخروج من الخلاء': ('Leaving the restroom', 'daily_life'),
    'الذكر قبل الوضوء': ('Before wudu', 'worship'),
    'الذكر بعد الفراغ من الوضوء': ('After wudu', 'worship'),
    'الذكر عند الخروج من المنزل': ('Leaving the house', 'daily_life'),
    'الذكر عند دخول المنزل': ('Entering the house', 'daily_life'),
    'دعاء الذهاب إلى المسجد': ('Going to the mosque', 'worship'),
    'دعاء دخول المسجد': ('Entering the mosque', 'worship'),
    'دعاء الخروج من المسجد': ('Leaving the mosque', 'worship'),
    'أذكار الاستيقاظ من النوم': ('Waking up', 'morning'),
    'دعاء لبْس الثوب الجديد': ('Wearing new clothes', 'daily_life'),
    'أذكار النوم': ('Before sleeping', 'evening'),
    'أذكار الصباح': ('Morning adhkar', 'morning'),
    'أذكار المساء': ('Evening adhkar', 'evening'),
    'أذكار بعد الصلاة': ('After prayer', 'worship'),
    'دعاء صلاة الاستخارة': ('Istikhara prayer', 'worship'),
    'دعاء الهم والحزن': ('Worry and sadness', 'protection'),
    'دعاء الكرب': ('Distress', 'protection'),
    'دعاء لقاء العدو': ('Meeting the enemy', 'protection'),
    'دعاء المظلوم': ('The oppressed', 'protection'),
    'دعاء السفر': ('Traveling', 'travel'),
    'دعاء دخول السوق': ('Entering the marketplace', 'daily_life'),
    'دعاء الطعام': ('Before eating', 'daily_life'),
    'الدعاء بعد الطعام': ('After eating', 'daily_life'),
    'دعاء الضيف': ('The guest', 'daily_life'),
    'التهنئة بالمولود': ('Newborn congratulation', 'daily_life'),
    'دعاء عند رؤية المبتلى': ('Seeing someone afflicted', 'daily_life'),
    'دعاء الريح': ('When wind blows', 'daily_life'),
    'دعاء المطر': ('When it rains', 'daily_life'),
    'دعاء الاستغفار': ('Seeking forgiveness', 'forgiveness'),
    'سيد الاستغفار': ('Master of seeking forgiveness', 'forgiveness'),
    'دعاء التوبة': ('Repentance', 'forgiveness'),
}

def clean_arabic_text(text):
    """Remove brackets and clean up Arabic text."""
    # Remove square and round brackets but keep content
    text = re.sub(r'[\[\]\(\)]', '', text)
    return text.strip()

def load_adhkar_arabic():
    """Load from Kind-Unes repo (Arabic only, categorized)."""
    js_path = '/tmp/Adhkar-Duaa-Multilingual-Database/java-script/arabic/duaa_ar.js'
    if not os.path.exists(js_path):
        print(f"Skipping {js_path} - not found")
        return []

    with open(js_path, 'r') as f:
        content = f.read()

    # Parse the JS array — convert JS object syntax to JSON
    content = content.replace('const duaas = ', '')
    content = content.rstrip().rstrip(';')
    # Quote unquoted keys (word followed by colon)
    content = re.sub(r'(?<=[{,\s])(\w+)\s*:', r'"\1":', content)
    # Remove trailing commas before ] or }
    content = re.sub(r',\s*([\]}])', r'\1', content)

    try:
        data = json.loads(content)
    except json.JSONDecodeError as e:
        print(f"Failed to parse Arabic duas JS file: {e}")
        # Try line-by-line extraction as fallback
        data = []
        current_cat = ''
        for line in open(js_path, 'r'):
            cat_match = re.search(r'category:\s*"([^"]+)"', line)
            if cat_match:
                current_cat = cat_match.group(1)
            text_match = re.search(r'text:\s*"([^"]+)"', line)
            if text_match and current_cat:
                if not data or data[-1].get('category') != current_cat:
                    data.append({'category': current_cat, 'array': []})
                data[-1]['array'].append({'text': text_match.group(1)})
        if not data:
            return []

    duas = []
    for category_obj in data:
        arabic_cat = category_obj.get('category', '')
        cat_info = ARABIC_CATEGORIES.get(arabic_cat, (arabic_cat, 'general'))
        english_title, category = cat_info

        for item in category_obj.get('array', []):
            text = clean_arabic_text(item.get('text', ''))
            if text and len(text) > 5:  # Skip very short entries
                duas.append({
                    'title_arabic': arabic_cat,
                    'title_english': english_title,
                    'text_arabic': text,
                    'text_translation_en': '',  # No English in this source
                    'source': 'Hisn al-Muslim',
                    'category': category,
                    'is_from_quran': 0,
                })

    return duas

def load_morning_evening():
    """Load from Seen-Arabic repo (Arabic + English + sources)."""
    en_path = '/tmp/Morning-And-Evening-Adhkar-DB/result/en.json'
    ar_path = '/tmp/Morning-And-Evening-Adhkar-DB/result/ar.json'

    duas = []

    if os.path.exists(en_path):
        with open(en_path, 'r') as f:
            en_data = json.load(f)

        for item in en_data:
            content = item.get('content', '').strip()
            translation = item.get('translation', '').strip()
            source = item.get('source', '').strip()
            item_type = item.get('type', 0)  # 0=morning, 1=evening, 2=other

            if content and len(content) > 5:
                category = 'morning' if item_type == 0 else ('evening' if item_type == 1 else 'general')
                duas.append({
                    'title_arabic': 'أذكار الصباح' if category == 'morning' else 'أذكار المساء',
                    'title_english': 'Morning adhkar' if category == 'morning' else 'Evening adhkar',
                    'text_arabic': content,
                    'text_translation_en': translation,
                    'source': source if source else 'Hisn al-Muslim',
                    'category': category,
                    'is_from_quran': 0,
                })

    return duas

def insert_into_db(duas):
    """Insert duas into the SQLite database."""
    if not os.path.exists(DB_PATH):
        print(f"Database not found at {DB_PATH}")
        sys.exit(1)

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Check current count
    cursor.execute("SELECT COUNT(*) FROM duas")
    existing = cursor.fetchone()[0]
    print(f"Existing duas in database: {existing}")

    # Track unique duas to avoid duplicates
    cursor.execute("SELECT text_arabic FROM duas")
    existing_texts = {row[0] for row in cursor.fetchall()}

    inserted = 0
    skipped = 0

    for dua in duas:
        # Skip if already exists (by Arabic text)
        if dua['text_arabic'] in existing_texts:
            skipped += 1
            continue

        cursor.execute("""
            INSERT INTO duas (title_arabic, title_english, text_arabic, text_translation_en, source, category, is_from_quran)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """, (
            dua['title_arabic'],
            dua['title_english'],
            dua['text_arabic'],
            dua['text_translation_en'],
            dua['source'],
            dua['category'],
            dua['is_from_quran'],
        ))

        existing_texts.add(dua['text_arabic'])
        inserted += 1

    conn.commit()

    # Final count
    cursor.execute("SELECT COUNT(*) FROM duas")
    final = cursor.fetchone()[0]

    print(f"Inserted: {inserted}, Skipped (duplicates): {skipped}")
    print(f"Total duas in database: {final}")

    # Show category breakdown
    cursor.execute("SELECT category, COUNT(*) FROM duas GROUP BY category ORDER BY COUNT(*) DESC")
    print("\nCategory breakdown:")
    for row in cursor.fetchall():
        print(f"  {row[0]}: {row[1]}")

    conn.close()

if __name__ == '__main__':
    print("Loading Duas/Adhkar from open source repos...")
    print("=" * 50)

    all_duas = []

    print("\n1. Loading Arabic duas (Kind-Unes repo)...")
    arabic_duas = load_adhkar_arabic()
    print(f"   Found {len(arabic_duas)} duas")
    all_duas.extend(arabic_duas)

    print("\n2. Loading Morning/Evening adhkar (Seen-Arabic repo)...")
    me_duas = load_morning_evening()
    print(f"   Found {len(me_duas)} adhkar entries")
    all_duas.extend(me_duas)

    print(f"\nTotal collected: {len(all_duas)} duas")
    print("=" * 50)

    print("\nInserting into database...")
    insert_into_db(all_duas)
    print("\nDone!")
