#!/usr/bin/env python3
"""
Load Hadith data from fawazahmed0/hadith-api into the app's SQLite database.

Collections loaded:
- Nawawi's 40 (42 hadiths) — curated, essential
- Qudsi Hadith (40 hadiths) — powerful, divine speech

Source: https://github.com/fawazahmed0/hadith-api (free to use without credits)

Run: python3 tools/load_hadith.py
"""
import json
import os
import sqlite3
import sys

DB_PATH = os.path.join(os.path.dirname(__file__), '..', 'assets', 'quran', 'quran.db')

def create_tables(cursor):
    """Create islamic_teachings and prophet_stories tables if they don't exist."""
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS islamic_teachings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            hadith_arabic TEXT,
            hadith_translation TEXT,
            explanation TEXT NOT NULL,
            source_reference TEXT NOT NULL,
            category TEXT NOT NULL,
            is_premium INTEGER DEFAULT 0
        )
    """)

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS prophet_stories (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            prophet_name_arabic TEXT NOT NULL,
            prophet_name_english TEXT NOT NULL,
            segment_number INTEGER NOT NULL,
            total_segments INTEGER NOT NULL,
            title TEXT NOT NULL,
            body_text TEXT NOT NULL,
            source_reference TEXT NOT NULL,
            is_premium INTEGER DEFAULT 0
        )
    """)

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS sahabah_stories (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            sahabah_name_arabic TEXT NOT NULL,
            sahabah_name_english TEXT NOT NULL,
            segment_number INTEGER NOT NULL,
            total_segments INTEGER NOT NULL,
            title TEXT NOT NULL,
            body_text TEXT NOT NULL,
            source_reference TEXT NOT NULL,
            is_premium INTEGER DEFAULT 0
        )
    """)

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS islamic_history (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            event_name_arabic TEXT,
            event_name_english TEXT NOT NULL,
            year_hijri TEXT,
            segment_number INTEGER NOT NULL,
            total_segments INTEGER NOT NULL,
            title TEXT NOT NULL,
            body_text TEXT NOT NULL,
            source_reference TEXT NOT NULL,
            is_premium INTEGER DEFAULT 0
        )
    """)

def load_collection(en_path, ar_path, collection_name, category):
    """Load a hadith collection from JSON files."""
    teachings = []

    with open(en_path, 'r') as f:
        en_data = json.load(f)

    ar_data = None
    if os.path.exists(ar_path):
        with open(ar_path, 'r') as f:
            ar_data = json.load(f)

    en_hadiths = en_data.get('hadiths', [])
    ar_hadiths = ar_data.get('hadiths', []) if ar_data else []

    # Build Arabic lookup by hadith number
    ar_lookup = {}
    for h in ar_hadiths:
        ar_lookup[h.get('hadithnumber', h.get('arabicnumber', 0))] = h.get('text', '')

    for h in en_hadiths:
        num = h.get('hadithnumber', 0)
        en_text = h.get('text', '').strip()
        ar_text = ar_lookup.get(num, '').strip()

        if not en_text:
            continue

        # Build source reference
        ref = h.get('reference', {})
        if isinstance(ref, dict):
            book = ref.get('book', '')
            hadith = ref.get('hadith', '')
            source_ref = f"{collection_name}"
            if book:
                source_ref += f", Book {book}"
            if hadith:
                source_ref += f", Hadith {hadith}"
        else:
            source_ref = f"{collection_name}, Hadith {num}"

        # Create a title from the first sentence
        first_sentence = en_text.split('.')[0]
        if len(first_sentence) > 80:
            first_sentence = first_sentence[:77] + '...'
        title = f"Hadith {num}: {first_sentence}"

        # Grades info
        grades = h.get('grades', [])
        grade_text = ''
        if grades:
            grade_names = [g.get('grade', '') for g in grades if g.get('grade')]
            if grade_names:
                grade_text = f" (Grade: {grade_names[0]})"

        teachings.append({
            'title': title,
            'hadith_arabic': ar_text,
            'hadith_translation': en_text,
            'explanation': en_text + grade_text,
            'source_reference': source_ref,
            'category': category,
            'is_premium': 0,  # Hadith should be free
        })

    return teachings

def insert_teachings(cursor, teachings):
    """Insert teachings into the database."""
    cursor.execute("SELECT COUNT(*) FROM islamic_teachings")
    existing = cursor.fetchone()[0]
    print(f"  Existing teachings: {existing}")

    # Track existing by source to avoid duplicates
    cursor.execute("SELECT source_reference FROM islamic_teachings")
    existing_refs = {row[0] for row in cursor.fetchall()}

    inserted = 0
    for t in teachings:
        if t['source_reference'] in existing_refs:
            continue

        cursor.execute("""
            INSERT INTO islamic_teachings (title, hadith_arabic, hadith_translation, explanation, source_reference, category, is_premium)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """, (
            t['title'],
            t['hadith_arabic'],
            t['hadith_translation'],
            t['explanation'],
            t['source_reference'],
            t['category'],
            t['is_premium'],
        ))
        existing_refs.add(t['source_reference'])
        inserted += 1

    return inserted

if __name__ == '__main__':
    print("Loading Hadith data into database...")
    print("=" * 50)

    if not os.path.exists(DB_PATH):
        print(f"Database not found at {DB_PATH}")
        sys.exit(1)

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    print("\nCreating tables...")
    create_tables(cursor)
    conn.commit()

    all_teachings = []

    # Nawawi's 40
    print("\n1. Loading Nawawi's 40 Hadith...")
    nawawi = load_collection(
        '/tmp/hadith_data/nawawi_en.json',
        '/tmp/hadith_data/nawawi_ar.json',
        "Nawawi's 40",
        'ethics'
    )
    print(f"   Found {len(nawawi)} hadiths")
    all_teachings.extend(nawawi)

    # Qudsi
    print("\n2. Loading Qudsi Hadith...")
    qudsi = load_collection(
        '/tmp/hadith_data/qudsi_en.json',
        '/tmp/hadith_data/qudsi_ar.json',
        'Hadith Qudsi',
        'worship'
    )
    print(f"   Found {len(qudsi)} hadiths")
    all_teachings.extend(qudsi)

    print(f"\nTotal collected: {len(all_teachings)} hadiths")
    print("=" * 50)

    print("\nInserting into database...")
    inserted = insert_teachings(cursor, all_teachings)
    conn.commit()

    cursor.execute("SELECT COUNT(*) FROM islamic_teachings")
    final = cursor.fetchone()[0]
    print(f"Inserted: {inserted}")
    print(f"Total teachings in database: {final}")

    # Category breakdown
    cursor.execute("SELECT category, COUNT(*) FROM islamic_teachings GROUP BY category")
    print("\nCategory breakdown:")
    for row in cursor.fetchall():
        print(f"  {row[0]}: {row[1]}")

    conn.close()
    print("\nDone!")
