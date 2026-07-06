#!/usr/bin/env python3
"""
Downloads Quran translations from AlQuran.cloud API and loads them
into quran.db.
"""
import json
import os
import sqlite3
import urllib.request

DB_PATH = os.path.join(os.path.dirname(__file__), '..', 'assets', 'quran', 'quran.db')

TRANSLATIONS = [
    ('ur', 'Urdu', 'ur.ahmedali'),
    ('tr', 'Turkish', 'tr.diyanet'),
    ('fr', 'French', 'fr.hamidullah'),
    ('id', 'Indonesian', 'id.indonesian'),
    ('bn', 'Bengali', 'bn.bengali'),
    ('ms', 'Malay', 'ms.basmeih'),
    ('de', 'German', 'de.aburida'),
    ('es', 'Spanish', 'es.cortes'),
]

API_BASE = 'https://api.alquran.cloud/v1/quran'


def create_tables(conn):
    conn.execute('''
        CREATE TABLE IF NOT EXISTS quran_translations (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ayah_id INTEGER NOT NULL,
            language_code TEXT NOT NULL,
            translation_text TEXT NOT NULL,
            UNIQUE(ayah_id, language_code)
        )
    ''')
    conn.execute('''
        CREATE INDEX IF NOT EXISTS idx_translations_lang
        ON quran_translations(language_code)
    ''')
    conn.execute('''
        CREATE TABLE IF NOT EXISTS available_languages (
            code TEXT PRIMARY KEY,
            display_name TEXT NOT NULL,
            is_downloaded INTEGER DEFAULT 0
        )
    ''')
    all_langs = [
        ('en', 'English', 1),
        ('ur', 'اردو (Urdu)', 0),
        ('tr', 'Türkçe (Turkish)', 0),
        ('fr', 'Français (French)', 0),
        ('id', 'Bahasa Indonesia', 0),
        ('bn', 'বাংলা (Bengali)', 0),
        ('ms', 'Bahasa Melayu', 0),
        ('de', 'Deutsch (German)', 0),
        ('es', 'Español (Spanish)', 0),
    ]
    for code, name, downloaded in all_langs:
        conn.execute(
            'INSERT OR REPLACE INTO available_languages (code, display_name, is_downloaded) VALUES (?, ?, ?)',
            (code, name, downloaded)
        )
    conn.commit()


def download_and_load(conn, lang_code, display_name, edition_id):
    row = conn.execute(
        'SELECT COUNT(*) FROM quran_translations WHERE language_code = ?',
        (lang_code,)
    ).fetchone()
    if row[0] > 0:
        print(f'  {display_name}: already loaded ({row[0]} ayahs)')
        return

    url = f'{API_BASE}/{edition_id}'
    print(f'  Downloading {display_name} ({edition_id})...')

    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'NiyyahApp/1.0'})
        with urllib.request.urlopen(req, timeout=60) as resp:
            data = json.loads(resp.read().decode('utf-8'))
    except Exception as e:
        print(f'    Error: {e}')
        return

    if data.get('code') != 200:
        print(f'    API error: {data.get("status")}')
        return

    surahs = data.get('data', {}).get('surahs', [])
    count = 0

    for surah in surahs:
        surah_num = surah['number']
        for ayah in surah['ayahs']:
            ayah_num = ayah['numberInSurah']

            # Look up our ayah ID
            db_row = conn.execute(
                'SELECT id FROM quran_ayahs WHERE surah = ? AND ayah = ?',
                (surah_num, ayah_num)
            ).fetchone()

            if db_row:
                conn.execute(
                    'INSERT OR REPLACE INTO quran_translations (ayah_id, language_code, translation_text) VALUES (?, ?, ?)',
                    (db_row[0], lang_code, ayah['text'])
                )
                count += 1

    conn.commit()

    if count > 0:
        conn.execute(
            'UPDATE available_languages SET is_downloaded = 1 WHERE code = ?',
            (lang_code,)
        )
        conn.commit()

    print(f'    Loaded {count} ayahs')


def main():
    conn = sqlite3.connect(DB_PATH)
    print('Setting up tables...')
    create_tables(conn)

    for lang_code, display_name, edition_id in TRANSLATIONS:
        download_and_load(conn, lang_code, display_name, edition_id)

    print('\n--- Summary ---')
    for row in conn.execute('SELECT code, display_name, is_downloaded FROM available_languages ORDER BY code'):
        status = 'yes' if row[2] else 'no'
        print(f'  {row[0]}: {row[1]} (downloaded: {status})')

    total = conn.execute('SELECT COUNT(*) FROM quran_translations').fetchone()[0]
    print(f'\nTotal translation entries: {total}')
    conn.close()


if __name__ == '__main__':
    main()
