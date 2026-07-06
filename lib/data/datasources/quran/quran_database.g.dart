// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_database.dart';

// ignore_for_file: type=lint
class $QuranAyahsTable extends QuranAyahs
    with TableInfo<$QuranAyahsTable, QuranAyah> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuranAyahsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _surahMeta = const VerificationMeta('surah');
  @override
  late final GeneratedColumn<int> surah = GeneratedColumn<int>(
    'surah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahMeta = const VerificationMeta('ayah');
  @override
  late final GeneratedColumn<int> ayah = GeneratedColumn<int>(
    'ayah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textUthmaniMeta = const VerificationMeta(
    'textUthmani',
  );
  @override
  late final GeneratedColumn<String> textUthmani = GeneratedColumn<String>(
    'text_uthmani',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textTranslationEnMeta = const VerificationMeta(
    'textTranslationEn',
  );
  @override
  late final GeneratedColumn<String> textTranslationEn =
      GeneratedColumn<String>(
        'text_translation_en',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    surah,
    ayah,
    textUthmani,
    textTranslationEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quran_ayahs';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuranAyah> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah')) {
      context.handle(
        _surahMeta,
        surah.isAcceptableOrUnknown(data['surah']!, _surahMeta),
      );
    } else if (isInserting) {
      context.missing(_surahMeta);
    }
    if (data.containsKey('ayah')) {
      context.handle(
        _ayahMeta,
        ayah.isAcceptableOrUnknown(data['ayah']!, _ayahMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahMeta);
    }
    if (data.containsKey('text_uthmani')) {
      context.handle(
        _textUthmaniMeta,
        textUthmani.isAcceptableOrUnknown(
          data['text_uthmani']!,
          _textUthmaniMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_textUthmaniMeta);
    }
    if (data.containsKey('text_translation_en')) {
      context.handle(
        _textTranslationEnMeta,
        textTranslationEn.isAcceptableOrUnknown(
          data['text_translation_en']!,
          _textTranslationEnMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuranAyah map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuranAyah(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      surah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah'],
      )!,
      ayah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah'],
      )!,
      textUthmani: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_uthmani'],
      )!,
      textTranslationEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_translation_en'],
      ),
    );
  }

  @override
  $QuranAyahsTable createAlias(String alias) {
    return $QuranAyahsTable(attachedDatabase, alias);
  }
}

class QuranAyah extends DataClass implements Insertable<QuranAyah> {
  final int id;
  final int surah;
  final int ayah;
  final String textUthmani;
  final String? textTranslationEn;
  const QuranAyah({
    required this.id,
    required this.surah,
    required this.ayah,
    required this.textUthmani,
    this.textTranslationEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah'] = Variable<int>(surah);
    map['ayah'] = Variable<int>(ayah);
    map['text_uthmani'] = Variable<String>(textUthmani);
    if (!nullToAbsent || textTranslationEn != null) {
      map['text_translation_en'] = Variable<String>(textTranslationEn);
    }
    return map;
  }

  QuranAyahsCompanion toCompanion(bool nullToAbsent) {
    return QuranAyahsCompanion(
      id: Value(id),
      surah: Value(surah),
      ayah: Value(ayah),
      textUthmani: Value(textUthmani),
      textTranslationEn: textTranslationEn == null && nullToAbsent
          ? const Value.absent()
          : Value(textTranslationEn),
    );
  }

  factory QuranAyah.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuranAyah(
      id: serializer.fromJson<int>(json['id']),
      surah: serializer.fromJson<int>(json['surah']),
      ayah: serializer.fromJson<int>(json['ayah']),
      textUthmani: serializer.fromJson<String>(json['textUthmani']),
      textTranslationEn: serializer.fromJson<String?>(
        json['textTranslationEn'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surah': serializer.toJson<int>(surah),
      'ayah': serializer.toJson<int>(ayah),
      'textUthmani': serializer.toJson<String>(textUthmani),
      'textTranslationEn': serializer.toJson<String?>(textTranslationEn),
    };
  }

  QuranAyah copyWith({
    int? id,
    int? surah,
    int? ayah,
    String? textUthmani,
    Value<String?> textTranslationEn = const Value.absent(),
  }) => QuranAyah(
    id: id ?? this.id,
    surah: surah ?? this.surah,
    ayah: ayah ?? this.ayah,
    textUthmani: textUthmani ?? this.textUthmani,
    textTranslationEn: textTranslationEn.present
        ? textTranslationEn.value
        : this.textTranslationEn,
  );
  QuranAyah copyWithCompanion(QuranAyahsCompanion data) {
    return QuranAyah(
      id: data.id.present ? data.id.value : this.id,
      surah: data.surah.present ? data.surah.value : this.surah,
      ayah: data.ayah.present ? data.ayah.value : this.ayah,
      textUthmani: data.textUthmani.present
          ? data.textUthmani.value
          : this.textUthmani,
      textTranslationEn: data.textTranslationEn.present
          ? data.textTranslationEn.value
          : this.textTranslationEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuranAyah(')
          ..write('id: $id, ')
          ..write('surah: $surah, ')
          ..write('ayah: $ayah, ')
          ..write('textUthmani: $textUthmani, ')
          ..write('textTranslationEn: $textTranslationEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, surah, ayah, textUthmani, textTranslationEn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuranAyah &&
          other.id == this.id &&
          other.surah == this.surah &&
          other.ayah == this.ayah &&
          other.textUthmani == this.textUthmani &&
          other.textTranslationEn == this.textTranslationEn);
}

class QuranAyahsCompanion extends UpdateCompanion<QuranAyah> {
  final Value<int> id;
  final Value<int> surah;
  final Value<int> ayah;
  final Value<String> textUthmani;
  final Value<String?> textTranslationEn;
  const QuranAyahsCompanion({
    this.id = const Value.absent(),
    this.surah = const Value.absent(),
    this.ayah = const Value.absent(),
    this.textUthmani = const Value.absent(),
    this.textTranslationEn = const Value.absent(),
  });
  QuranAyahsCompanion.insert({
    this.id = const Value.absent(),
    required int surah,
    required int ayah,
    required String textUthmani,
    this.textTranslationEn = const Value.absent(),
  }) : surah = Value(surah),
       ayah = Value(ayah),
       textUthmani = Value(textUthmani);
  static Insertable<QuranAyah> custom({
    Expression<int>? id,
    Expression<int>? surah,
    Expression<int>? ayah,
    Expression<String>? textUthmani,
    Expression<String>? textTranslationEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surah != null) 'surah': surah,
      if (ayah != null) 'ayah': ayah,
      if (textUthmani != null) 'text_uthmani': textUthmani,
      if (textTranslationEn != null) 'text_translation_en': textTranslationEn,
    });
  }

  QuranAyahsCompanion copyWith({
    Value<int>? id,
    Value<int>? surah,
    Value<int>? ayah,
    Value<String>? textUthmani,
    Value<String?>? textTranslationEn,
  }) {
    return QuranAyahsCompanion(
      id: id ?? this.id,
      surah: surah ?? this.surah,
      ayah: ayah ?? this.ayah,
      textUthmani: textUthmani ?? this.textUthmani,
      textTranslationEn: textTranslationEn ?? this.textTranslationEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surah.present) {
      map['surah'] = Variable<int>(surah.value);
    }
    if (ayah.present) {
      map['ayah'] = Variable<int>(ayah.value);
    }
    if (textUthmani.present) {
      map['text_uthmani'] = Variable<String>(textUthmani.value);
    }
    if (textTranslationEn.present) {
      map['text_translation_en'] = Variable<String>(textTranslationEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuranAyahsCompanion(')
          ..write('id: $id, ')
          ..write('surah: $surah, ')
          ..write('ayah: $ayah, ')
          ..write('textUthmani: $textUthmani, ')
          ..write('textTranslationEn: $textTranslationEn')
          ..write(')'))
        .toString();
  }
}

class $QuranSurahsTable extends QuranSurahs
    with TableInfo<$QuranSurahsTable, QuranSurah> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuranSurahsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameArabicMeta = const VerificationMeta(
    'nameArabic',
  );
  @override
  late final GeneratedColumn<String> nameArabic = GeneratedColumn<String>(
    'name_arabic',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnglishMeta = const VerificationMeta(
    'nameEnglish',
  );
  @override
  late final GeneratedColumn<String> nameEnglish = GeneratedColumn<String>(
    'name_english',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameTransliterationMeta =
      const VerificationMeta('nameTransliteration');
  @override
  late final GeneratedColumn<String> nameTransliteration =
      GeneratedColumn<String>(
        'name_transliteration',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _ayahCountMeta = const VerificationMeta(
    'ayahCount',
  );
  @override
  late final GeneratedColumn<int> ayahCount = GeneratedColumn<int>(
    'ayah_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _revelationTypeMeta = const VerificationMeta(
    'revelationType',
  );
  @override
  late final GeneratedColumn<String> revelationType = GeneratedColumn<String>(
    'revelation_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _revelationOrderMeta = const VerificationMeta(
    'revelationOrder',
  );
  @override
  late final GeneratedColumn<int> revelationOrder = GeneratedColumn<int>(
    'revelation_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    number,
    nameArabic,
    nameEnglish,
    nameTransliteration,
    ayahCount,
    revelationType,
    revelationOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quran_surahs';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuranSurah> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    }
    if (data.containsKey('name_arabic')) {
      context.handle(
        _nameArabicMeta,
        nameArabic.isAcceptableOrUnknown(data['name_arabic']!, _nameArabicMeta),
      );
    } else if (isInserting) {
      context.missing(_nameArabicMeta);
    }
    if (data.containsKey('name_english')) {
      context.handle(
        _nameEnglishMeta,
        nameEnglish.isAcceptableOrUnknown(
          data['name_english']!,
          _nameEnglishMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nameEnglishMeta);
    }
    if (data.containsKey('name_transliteration')) {
      context.handle(
        _nameTransliterationMeta,
        nameTransliteration.isAcceptableOrUnknown(
          data['name_transliteration']!,
          _nameTransliterationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nameTransliterationMeta);
    }
    if (data.containsKey('ayah_count')) {
      context.handle(
        _ayahCountMeta,
        ayahCount.isAcceptableOrUnknown(data['ayah_count']!, _ayahCountMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahCountMeta);
    }
    if (data.containsKey('revelation_type')) {
      context.handle(
        _revelationTypeMeta,
        revelationType.isAcceptableOrUnknown(
          data['revelation_type']!,
          _revelationTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_revelationTypeMeta);
    }
    if (data.containsKey('revelation_order')) {
      context.handle(
        _revelationOrderMeta,
        revelationOrder.isAcceptableOrUnknown(
          data['revelation_order']!,
          _revelationOrderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_revelationOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {number};
  @override
  QuranSurah map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuranSurah(
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number'],
      )!,
      nameArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_arabic'],
      )!,
      nameEnglish: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_english'],
      )!,
      nameTransliteration: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_transliteration'],
      )!,
      ayahCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_count'],
      )!,
      revelationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}revelation_type'],
      )!,
      revelationOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revelation_order'],
      )!,
    );
  }

  @override
  $QuranSurahsTable createAlias(String alias) {
    return $QuranSurahsTable(attachedDatabase, alias);
  }
}

class QuranSurah extends DataClass implements Insertable<QuranSurah> {
  final int number;
  final String nameArabic;
  final String nameEnglish;
  final String nameTransliteration;
  final int ayahCount;
  final String revelationType;
  final int revelationOrder;
  const QuranSurah({
    required this.number,
    required this.nameArabic,
    required this.nameEnglish,
    required this.nameTransliteration,
    required this.ayahCount,
    required this.revelationType,
    required this.revelationOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['number'] = Variable<int>(number);
    map['name_arabic'] = Variable<String>(nameArabic);
    map['name_english'] = Variable<String>(nameEnglish);
    map['name_transliteration'] = Variable<String>(nameTransliteration);
    map['ayah_count'] = Variable<int>(ayahCount);
    map['revelation_type'] = Variable<String>(revelationType);
    map['revelation_order'] = Variable<int>(revelationOrder);
    return map;
  }

  QuranSurahsCompanion toCompanion(bool nullToAbsent) {
    return QuranSurahsCompanion(
      number: Value(number),
      nameArabic: Value(nameArabic),
      nameEnglish: Value(nameEnglish),
      nameTransliteration: Value(nameTransliteration),
      ayahCount: Value(ayahCount),
      revelationType: Value(revelationType),
      revelationOrder: Value(revelationOrder),
    );
  }

  factory QuranSurah.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuranSurah(
      number: serializer.fromJson<int>(json['number']),
      nameArabic: serializer.fromJson<String>(json['nameArabic']),
      nameEnglish: serializer.fromJson<String>(json['nameEnglish']),
      nameTransliteration: serializer.fromJson<String>(
        json['nameTransliteration'],
      ),
      ayahCount: serializer.fromJson<int>(json['ayahCount']),
      revelationType: serializer.fromJson<String>(json['revelationType']),
      revelationOrder: serializer.fromJson<int>(json['revelationOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'number': serializer.toJson<int>(number),
      'nameArabic': serializer.toJson<String>(nameArabic),
      'nameEnglish': serializer.toJson<String>(nameEnglish),
      'nameTransliteration': serializer.toJson<String>(nameTransliteration),
      'ayahCount': serializer.toJson<int>(ayahCount),
      'revelationType': serializer.toJson<String>(revelationType),
      'revelationOrder': serializer.toJson<int>(revelationOrder),
    };
  }

  QuranSurah copyWith({
    int? number,
    String? nameArabic,
    String? nameEnglish,
    String? nameTransliteration,
    int? ayahCount,
    String? revelationType,
    int? revelationOrder,
  }) => QuranSurah(
    number: number ?? this.number,
    nameArabic: nameArabic ?? this.nameArabic,
    nameEnglish: nameEnglish ?? this.nameEnglish,
    nameTransliteration: nameTransliteration ?? this.nameTransliteration,
    ayahCount: ayahCount ?? this.ayahCount,
    revelationType: revelationType ?? this.revelationType,
    revelationOrder: revelationOrder ?? this.revelationOrder,
  );
  QuranSurah copyWithCompanion(QuranSurahsCompanion data) {
    return QuranSurah(
      number: data.number.present ? data.number.value : this.number,
      nameArabic: data.nameArabic.present
          ? data.nameArabic.value
          : this.nameArabic,
      nameEnglish: data.nameEnglish.present
          ? data.nameEnglish.value
          : this.nameEnglish,
      nameTransliteration: data.nameTransliteration.present
          ? data.nameTransliteration.value
          : this.nameTransliteration,
      ayahCount: data.ayahCount.present ? data.ayahCount.value : this.ayahCount,
      revelationType: data.revelationType.present
          ? data.revelationType.value
          : this.revelationType,
      revelationOrder: data.revelationOrder.present
          ? data.revelationOrder.value
          : this.revelationOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuranSurah(')
          ..write('number: $number, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('nameEnglish: $nameEnglish, ')
          ..write('nameTransliteration: $nameTransliteration, ')
          ..write('ayahCount: $ayahCount, ')
          ..write('revelationType: $revelationType, ')
          ..write('revelationOrder: $revelationOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    number,
    nameArabic,
    nameEnglish,
    nameTransliteration,
    ayahCount,
    revelationType,
    revelationOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuranSurah &&
          other.number == this.number &&
          other.nameArabic == this.nameArabic &&
          other.nameEnglish == this.nameEnglish &&
          other.nameTransliteration == this.nameTransliteration &&
          other.ayahCount == this.ayahCount &&
          other.revelationType == this.revelationType &&
          other.revelationOrder == this.revelationOrder);
}

class QuranSurahsCompanion extends UpdateCompanion<QuranSurah> {
  final Value<int> number;
  final Value<String> nameArabic;
  final Value<String> nameEnglish;
  final Value<String> nameTransliteration;
  final Value<int> ayahCount;
  final Value<String> revelationType;
  final Value<int> revelationOrder;
  const QuranSurahsCompanion({
    this.number = const Value.absent(),
    this.nameArabic = const Value.absent(),
    this.nameEnglish = const Value.absent(),
    this.nameTransliteration = const Value.absent(),
    this.ayahCount = const Value.absent(),
    this.revelationType = const Value.absent(),
    this.revelationOrder = const Value.absent(),
  });
  QuranSurahsCompanion.insert({
    this.number = const Value.absent(),
    required String nameArabic,
    required String nameEnglish,
    required String nameTransliteration,
    required int ayahCount,
    required String revelationType,
    required int revelationOrder,
  }) : nameArabic = Value(nameArabic),
       nameEnglish = Value(nameEnglish),
       nameTransliteration = Value(nameTransliteration),
       ayahCount = Value(ayahCount),
       revelationType = Value(revelationType),
       revelationOrder = Value(revelationOrder);
  static Insertable<QuranSurah> custom({
    Expression<int>? number,
    Expression<String>? nameArabic,
    Expression<String>? nameEnglish,
    Expression<String>? nameTransliteration,
    Expression<int>? ayahCount,
    Expression<String>? revelationType,
    Expression<int>? revelationOrder,
  }) {
    return RawValuesInsertable({
      if (number != null) 'number': number,
      if (nameArabic != null) 'name_arabic': nameArabic,
      if (nameEnglish != null) 'name_english': nameEnglish,
      if (nameTransliteration != null)
        'name_transliteration': nameTransliteration,
      if (ayahCount != null) 'ayah_count': ayahCount,
      if (revelationType != null) 'revelation_type': revelationType,
      if (revelationOrder != null) 'revelation_order': revelationOrder,
    });
  }

  QuranSurahsCompanion copyWith({
    Value<int>? number,
    Value<String>? nameArabic,
    Value<String>? nameEnglish,
    Value<String>? nameTransliteration,
    Value<int>? ayahCount,
    Value<String>? revelationType,
    Value<int>? revelationOrder,
  }) {
    return QuranSurahsCompanion(
      number: number ?? this.number,
      nameArabic: nameArabic ?? this.nameArabic,
      nameEnglish: nameEnglish ?? this.nameEnglish,
      nameTransliteration: nameTransliteration ?? this.nameTransliteration,
      ayahCount: ayahCount ?? this.ayahCount,
      revelationType: revelationType ?? this.revelationType,
      revelationOrder: revelationOrder ?? this.revelationOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (nameArabic.present) {
      map['name_arabic'] = Variable<String>(nameArabic.value);
    }
    if (nameEnglish.present) {
      map['name_english'] = Variable<String>(nameEnglish.value);
    }
    if (nameTransliteration.present) {
      map['name_transliteration'] = Variable<String>(nameTransliteration.value);
    }
    if (ayahCount.present) {
      map['ayah_count'] = Variable<int>(ayahCount.value);
    }
    if (revelationType.present) {
      map['revelation_type'] = Variable<String>(revelationType.value);
    }
    if (revelationOrder.present) {
      map['revelation_order'] = Variable<int>(revelationOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuranSurahsCompanion(')
          ..write('number: $number, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('nameEnglish: $nameEnglish, ')
          ..write('nameTransliteration: $nameTransliteration, ')
          ..write('ayahCount: $ayahCount, ')
          ..write('revelationType: $revelationType, ')
          ..write('revelationOrder: $revelationOrder')
          ..write(')'))
        .toString();
  }
}

class $DuasTable extends Duas with TableInfo<$DuasTable, Dua> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DuasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleArabicMeta = const VerificationMeta(
    'titleArabic',
  );
  @override
  late final GeneratedColumn<String> titleArabic = GeneratedColumn<String>(
    'title_arabic',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleEnglishMeta = const VerificationMeta(
    'titleEnglish',
  );
  @override
  late final GeneratedColumn<String> titleEnglish = GeneratedColumn<String>(
    'title_english',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textArabicMeta = const VerificationMeta(
    'textArabic',
  );
  @override
  late final GeneratedColumn<String> textArabic = GeneratedColumn<String>(
    'text_arabic',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textTranslationEnMeta = const VerificationMeta(
    'textTranslationEn',
  );
  @override
  late final GeneratedColumn<String> textTranslationEn =
      GeneratedColumn<String>(
        'text_translation_en',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFromQuranMeta = const VerificationMeta(
    'isFromQuran',
  );
  @override
  late final GeneratedColumn<bool> isFromQuran = GeneratedColumn<bool>(
    'is_from_quran',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_from_quran" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    titleArabic,
    titleEnglish,
    textArabic,
    textTranslationEn,
    source,
    category,
    isFromQuran,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'duas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Dua> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title_arabic')) {
      context.handle(
        _titleArabicMeta,
        titleArabic.isAcceptableOrUnknown(
          data['title_arabic']!,
          _titleArabicMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_titleArabicMeta);
    }
    if (data.containsKey('title_english')) {
      context.handle(
        _titleEnglishMeta,
        titleEnglish.isAcceptableOrUnknown(
          data['title_english']!,
          _titleEnglishMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_titleEnglishMeta);
    }
    if (data.containsKey('text_arabic')) {
      context.handle(
        _textArabicMeta,
        textArabic.isAcceptableOrUnknown(data['text_arabic']!, _textArabicMeta),
      );
    } else if (isInserting) {
      context.missing(_textArabicMeta);
    }
    if (data.containsKey('text_translation_en')) {
      context.handle(
        _textTranslationEnMeta,
        textTranslationEn.isAcceptableOrUnknown(
          data['text_translation_en']!,
          _textTranslationEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_textTranslationEnMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('is_from_quran')) {
      context.handle(
        _isFromQuranMeta,
        isFromQuran.isAcceptableOrUnknown(
          data['is_from_quran']!,
          _isFromQuranMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Dua map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Dua(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      titleArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_arabic'],
      )!,
      titleEnglish: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_english'],
      )!,
      textArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_arabic'],
      )!,
      textTranslationEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_translation_en'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      isFromQuran: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_from_quran'],
      )!,
    );
  }

  @override
  $DuasTable createAlias(String alias) {
    return $DuasTable(attachedDatabase, alias);
  }
}

class Dua extends DataClass implements Insertable<Dua> {
  final int id;
  final String titleArabic;
  final String titleEnglish;
  final String textArabic;
  final String textTranslationEn;
  final String source;
  final String category;
  final bool isFromQuran;
  const Dua({
    required this.id,
    required this.titleArabic,
    required this.titleEnglish,
    required this.textArabic,
    required this.textTranslationEn,
    required this.source,
    required this.category,
    required this.isFromQuran,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title_arabic'] = Variable<String>(titleArabic);
    map['title_english'] = Variable<String>(titleEnglish);
    map['text_arabic'] = Variable<String>(textArabic);
    map['text_translation_en'] = Variable<String>(textTranslationEn);
    map['source'] = Variable<String>(source);
    map['category'] = Variable<String>(category);
    map['is_from_quran'] = Variable<bool>(isFromQuran);
    return map;
  }

  DuasCompanion toCompanion(bool nullToAbsent) {
    return DuasCompanion(
      id: Value(id),
      titleArabic: Value(titleArabic),
      titleEnglish: Value(titleEnglish),
      textArabic: Value(textArabic),
      textTranslationEn: Value(textTranslationEn),
      source: Value(source),
      category: Value(category),
      isFromQuran: Value(isFromQuran),
    );
  }

  factory Dua.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Dua(
      id: serializer.fromJson<int>(json['id']),
      titleArabic: serializer.fromJson<String>(json['titleArabic']),
      titleEnglish: serializer.fromJson<String>(json['titleEnglish']),
      textArabic: serializer.fromJson<String>(json['textArabic']),
      textTranslationEn: serializer.fromJson<String>(json['textTranslationEn']),
      source: serializer.fromJson<String>(json['source']),
      category: serializer.fromJson<String>(json['category']),
      isFromQuran: serializer.fromJson<bool>(json['isFromQuran']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'titleArabic': serializer.toJson<String>(titleArabic),
      'titleEnglish': serializer.toJson<String>(titleEnglish),
      'textArabic': serializer.toJson<String>(textArabic),
      'textTranslationEn': serializer.toJson<String>(textTranslationEn),
      'source': serializer.toJson<String>(source),
      'category': serializer.toJson<String>(category),
      'isFromQuran': serializer.toJson<bool>(isFromQuran),
    };
  }

  Dua copyWith({
    int? id,
    String? titleArabic,
    String? titleEnglish,
    String? textArabic,
    String? textTranslationEn,
    String? source,
    String? category,
    bool? isFromQuran,
  }) => Dua(
    id: id ?? this.id,
    titleArabic: titleArabic ?? this.titleArabic,
    titleEnglish: titleEnglish ?? this.titleEnglish,
    textArabic: textArabic ?? this.textArabic,
    textTranslationEn: textTranslationEn ?? this.textTranslationEn,
    source: source ?? this.source,
    category: category ?? this.category,
    isFromQuran: isFromQuran ?? this.isFromQuran,
  );
  Dua copyWithCompanion(DuasCompanion data) {
    return Dua(
      id: data.id.present ? data.id.value : this.id,
      titleArabic: data.titleArabic.present
          ? data.titleArabic.value
          : this.titleArabic,
      titleEnglish: data.titleEnglish.present
          ? data.titleEnglish.value
          : this.titleEnglish,
      textArabic: data.textArabic.present
          ? data.textArabic.value
          : this.textArabic,
      textTranslationEn: data.textTranslationEn.present
          ? data.textTranslationEn.value
          : this.textTranslationEn,
      source: data.source.present ? data.source.value : this.source,
      category: data.category.present ? data.category.value : this.category,
      isFromQuran: data.isFromQuran.present
          ? data.isFromQuran.value
          : this.isFromQuran,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Dua(')
          ..write('id: $id, ')
          ..write('titleArabic: $titleArabic, ')
          ..write('titleEnglish: $titleEnglish, ')
          ..write('textArabic: $textArabic, ')
          ..write('textTranslationEn: $textTranslationEn, ')
          ..write('source: $source, ')
          ..write('category: $category, ')
          ..write('isFromQuran: $isFromQuran')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    titleArabic,
    titleEnglish,
    textArabic,
    textTranslationEn,
    source,
    category,
    isFromQuran,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Dua &&
          other.id == this.id &&
          other.titleArabic == this.titleArabic &&
          other.titleEnglish == this.titleEnglish &&
          other.textArabic == this.textArabic &&
          other.textTranslationEn == this.textTranslationEn &&
          other.source == this.source &&
          other.category == this.category &&
          other.isFromQuran == this.isFromQuran);
}

class DuasCompanion extends UpdateCompanion<Dua> {
  final Value<int> id;
  final Value<String> titleArabic;
  final Value<String> titleEnglish;
  final Value<String> textArabic;
  final Value<String> textTranslationEn;
  final Value<String> source;
  final Value<String> category;
  final Value<bool> isFromQuran;
  const DuasCompanion({
    this.id = const Value.absent(),
    this.titleArabic = const Value.absent(),
    this.titleEnglish = const Value.absent(),
    this.textArabic = const Value.absent(),
    this.textTranslationEn = const Value.absent(),
    this.source = const Value.absent(),
    this.category = const Value.absent(),
    this.isFromQuran = const Value.absent(),
  });
  DuasCompanion.insert({
    this.id = const Value.absent(),
    required String titleArabic,
    required String titleEnglish,
    required String textArabic,
    required String textTranslationEn,
    required String source,
    required String category,
    this.isFromQuran = const Value.absent(),
  }) : titleArabic = Value(titleArabic),
       titleEnglish = Value(titleEnglish),
       textArabic = Value(textArabic),
       textTranslationEn = Value(textTranslationEn),
       source = Value(source),
       category = Value(category);
  static Insertable<Dua> custom({
    Expression<int>? id,
    Expression<String>? titleArabic,
    Expression<String>? titleEnglish,
    Expression<String>? textArabic,
    Expression<String>? textTranslationEn,
    Expression<String>? source,
    Expression<String>? category,
    Expression<bool>? isFromQuran,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (titleArabic != null) 'title_arabic': titleArabic,
      if (titleEnglish != null) 'title_english': titleEnglish,
      if (textArabic != null) 'text_arabic': textArabic,
      if (textTranslationEn != null) 'text_translation_en': textTranslationEn,
      if (source != null) 'source': source,
      if (category != null) 'category': category,
      if (isFromQuran != null) 'is_from_quran': isFromQuran,
    });
  }

  DuasCompanion copyWith({
    Value<int>? id,
    Value<String>? titleArabic,
    Value<String>? titleEnglish,
    Value<String>? textArabic,
    Value<String>? textTranslationEn,
    Value<String>? source,
    Value<String>? category,
    Value<bool>? isFromQuran,
  }) {
    return DuasCompanion(
      id: id ?? this.id,
      titleArabic: titleArabic ?? this.titleArabic,
      titleEnglish: titleEnglish ?? this.titleEnglish,
      textArabic: textArabic ?? this.textArabic,
      textTranslationEn: textTranslationEn ?? this.textTranslationEn,
      source: source ?? this.source,
      category: category ?? this.category,
      isFromQuran: isFromQuran ?? this.isFromQuran,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (titleArabic.present) {
      map['title_arabic'] = Variable<String>(titleArabic.value);
    }
    if (titleEnglish.present) {
      map['title_english'] = Variable<String>(titleEnglish.value);
    }
    if (textArabic.present) {
      map['text_arabic'] = Variable<String>(textArabic.value);
    }
    if (textTranslationEn.present) {
      map['text_translation_en'] = Variable<String>(textTranslationEn.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isFromQuran.present) {
      map['is_from_quran'] = Variable<bool>(isFromQuran.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DuasCompanion(')
          ..write('id: $id, ')
          ..write('titleArabic: $titleArabic, ')
          ..write('titleEnglish: $titleEnglish, ')
          ..write('textArabic: $textArabic, ')
          ..write('textTranslationEn: $textTranslationEn, ')
          ..write('source: $source, ')
          ..write('category: $category, ')
          ..write('isFromQuran: $isFromQuran')
          ..write(')'))
        .toString();
  }
}

class $IslamicTeachingsTable extends IslamicTeachings
    with TableInfo<$IslamicTeachingsTable, IslamicTeaching> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IslamicTeachingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hadithArabicMeta = const VerificationMeta(
    'hadithArabic',
  );
  @override
  late final GeneratedColumn<String> hadithArabic = GeneratedColumn<String>(
    'hadith_arabic',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hadithTranslationMeta = const VerificationMeta(
    'hadithTranslation',
  );
  @override
  late final GeneratedColumn<String> hadithTranslation =
      GeneratedColumn<String>(
        'hadith_translation',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _explanationMeta = const VerificationMeta(
    'explanation',
  );
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
    'explanation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceReferenceMeta = const VerificationMeta(
    'sourceReference',
  );
  @override
  late final GeneratedColumn<String> sourceReference = GeneratedColumn<String>(
    'source_reference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPremiumMeta = const VerificationMeta(
    'isPremium',
  );
  @override
  late final GeneratedColumn<bool> isPremium = GeneratedColumn<bool>(
    'is_premium',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_premium" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    hadithArabic,
    hadithTranslation,
    explanation,
    sourceReference,
    category,
    isPremium,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'islamic_teachings';
  @override
  VerificationContext validateIntegrity(
    Insertable<IslamicTeaching> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('hadith_arabic')) {
      context.handle(
        _hadithArabicMeta,
        hadithArabic.isAcceptableOrUnknown(
          data['hadith_arabic']!,
          _hadithArabicMeta,
        ),
      );
    }
    if (data.containsKey('hadith_translation')) {
      context.handle(
        _hadithTranslationMeta,
        hadithTranslation.isAcceptableOrUnknown(
          data['hadith_translation']!,
          _hadithTranslationMeta,
        ),
      );
    }
    if (data.containsKey('explanation')) {
      context.handle(
        _explanationMeta,
        explanation.isAcceptableOrUnknown(
          data['explanation']!,
          _explanationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_explanationMeta);
    }
    if (data.containsKey('source_reference')) {
      context.handle(
        _sourceReferenceMeta,
        sourceReference.isAcceptableOrUnknown(
          data['source_reference']!,
          _sourceReferenceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceReferenceMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('is_premium')) {
      context.handle(
        _isPremiumMeta,
        isPremium.isAcceptableOrUnknown(data['is_premium']!, _isPremiumMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IslamicTeaching map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IslamicTeaching(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      hadithArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hadith_arabic'],
      ),
      hadithTranslation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hadith_translation'],
      ),
      explanation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}explanation'],
      )!,
      sourceReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_reference'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      isPremium: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_premium'],
      )!,
    );
  }

  @override
  $IslamicTeachingsTable createAlias(String alias) {
    return $IslamicTeachingsTable(attachedDatabase, alias);
  }
}

class IslamicTeaching extends DataClass implements Insertable<IslamicTeaching> {
  final int id;
  final String title;
  final String? hadithArabic;
  final String? hadithTranslation;
  final String explanation;
  final String sourceReference;
  final String category;
  final bool isPremium;
  const IslamicTeaching({
    required this.id,
    required this.title,
    this.hadithArabic,
    this.hadithTranslation,
    required this.explanation,
    required this.sourceReference,
    required this.category,
    required this.isPremium,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || hadithArabic != null) {
      map['hadith_arabic'] = Variable<String>(hadithArabic);
    }
    if (!nullToAbsent || hadithTranslation != null) {
      map['hadith_translation'] = Variable<String>(hadithTranslation);
    }
    map['explanation'] = Variable<String>(explanation);
    map['source_reference'] = Variable<String>(sourceReference);
    map['category'] = Variable<String>(category);
    map['is_premium'] = Variable<bool>(isPremium);
    return map;
  }

  IslamicTeachingsCompanion toCompanion(bool nullToAbsent) {
    return IslamicTeachingsCompanion(
      id: Value(id),
      title: Value(title),
      hadithArabic: hadithArabic == null && nullToAbsent
          ? const Value.absent()
          : Value(hadithArabic),
      hadithTranslation: hadithTranslation == null && nullToAbsent
          ? const Value.absent()
          : Value(hadithTranslation),
      explanation: Value(explanation),
      sourceReference: Value(sourceReference),
      category: Value(category),
      isPremium: Value(isPremium),
    );
  }

  factory IslamicTeaching.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IslamicTeaching(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      hadithArabic: serializer.fromJson<String?>(json['hadithArabic']),
      hadithTranslation: serializer.fromJson<String?>(
        json['hadithTranslation'],
      ),
      explanation: serializer.fromJson<String>(json['explanation']),
      sourceReference: serializer.fromJson<String>(json['sourceReference']),
      category: serializer.fromJson<String>(json['category']),
      isPremium: serializer.fromJson<bool>(json['isPremium']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'hadithArabic': serializer.toJson<String?>(hadithArabic),
      'hadithTranslation': serializer.toJson<String?>(hadithTranslation),
      'explanation': serializer.toJson<String>(explanation),
      'sourceReference': serializer.toJson<String>(sourceReference),
      'category': serializer.toJson<String>(category),
      'isPremium': serializer.toJson<bool>(isPremium),
    };
  }

  IslamicTeaching copyWith({
    int? id,
    String? title,
    Value<String?> hadithArabic = const Value.absent(),
    Value<String?> hadithTranslation = const Value.absent(),
    String? explanation,
    String? sourceReference,
    String? category,
    bool? isPremium,
  }) => IslamicTeaching(
    id: id ?? this.id,
    title: title ?? this.title,
    hadithArabic: hadithArabic.present ? hadithArabic.value : this.hadithArabic,
    hadithTranslation: hadithTranslation.present
        ? hadithTranslation.value
        : this.hadithTranslation,
    explanation: explanation ?? this.explanation,
    sourceReference: sourceReference ?? this.sourceReference,
    category: category ?? this.category,
    isPremium: isPremium ?? this.isPremium,
  );
  IslamicTeaching copyWithCompanion(IslamicTeachingsCompanion data) {
    return IslamicTeaching(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      hadithArabic: data.hadithArabic.present
          ? data.hadithArabic.value
          : this.hadithArabic,
      hadithTranslation: data.hadithTranslation.present
          ? data.hadithTranslation.value
          : this.hadithTranslation,
      explanation: data.explanation.present
          ? data.explanation.value
          : this.explanation,
      sourceReference: data.sourceReference.present
          ? data.sourceReference.value
          : this.sourceReference,
      category: data.category.present ? data.category.value : this.category,
      isPremium: data.isPremium.present ? data.isPremium.value : this.isPremium,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IslamicTeaching(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('hadithArabic: $hadithArabic, ')
          ..write('hadithTranslation: $hadithTranslation, ')
          ..write('explanation: $explanation, ')
          ..write('sourceReference: $sourceReference, ')
          ..write('category: $category, ')
          ..write('isPremium: $isPremium')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    hadithArabic,
    hadithTranslation,
    explanation,
    sourceReference,
    category,
    isPremium,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IslamicTeaching &&
          other.id == this.id &&
          other.title == this.title &&
          other.hadithArabic == this.hadithArabic &&
          other.hadithTranslation == this.hadithTranslation &&
          other.explanation == this.explanation &&
          other.sourceReference == this.sourceReference &&
          other.category == this.category &&
          other.isPremium == this.isPremium);
}

class IslamicTeachingsCompanion extends UpdateCompanion<IslamicTeaching> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> hadithArabic;
  final Value<String?> hadithTranslation;
  final Value<String> explanation;
  final Value<String> sourceReference;
  final Value<String> category;
  final Value<bool> isPremium;
  const IslamicTeachingsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.hadithArabic = const Value.absent(),
    this.hadithTranslation = const Value.absent(),
    this.explanation = const Value.absent(),
    this.sourceReference = const Value.absent(),
    this.category = const Value.absent(),
    this.isPremium = const Value.absent(),
  });
  IslamicTeachingsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.hadithArabic = const Value.absent(),
    this.hadithTranslation = const Value.absent(),
    required String explanation,
    required String sourceReference,
    required String category,
    this.isPremium = const Value.absent(),
  }) : title = Value(title),
       explanation = Value(explanation),
       sourceReference = Value(sourceReference),
       category = Value(category);
  static Insertable<IslamicTeaching> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? hadithArabic,
    Expression<String>? hadithTranslation,
    Expression<String>? explanation,
    Expression<String>? sourceReference,
    Expression<String>? category,
    Expression<bool>? isPremium,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (hadithArabic != null) 'hadith_arabic': hadithArabic,
      if (hadithTranslation != null) 'hadith_translation': hadithTranslation,
      if (explanation != null) 'explanation': explanation,
      if (sourceReference != null) 'source_reference': sourceReference,
      if (category != null) 'category': category,
      if (isPremium != null) 'is_premium': isPremium,
    });
  }

  IslamicTeachingsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? hadithArabic,
    Value<String?>? hadithTranslation,
    Value<String>? explanation,
    Value<String>? sourceReference,
    Value<String>? category,
    Value<bool>? isPremium,
  }) {
    return IslamicTeachingsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      hadithArabic: hadithArabic ?? this.hadithArabic,
      hadithTranslation: hadithTranslation ?? this.hadithTranslation,
      explanation: explanation ?? this.explanation,
      sourceReference: sourceReference ?? this.sourceReference,
      category: category ?? this.category,
      isPremium: isPremium ?? this.isPremium,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (hadithArabic.present) {
      map['hadith_arabic'] = Variable<String>(hadithArabic.value);
    }
    if (hadithTranslation.present) {
      map['hadith_translation'] = Variable<String>(hadithTranslation.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (sourceReference.present) {
      map['source_reference'] = Variable<String>(sourceReference.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isPremium.present) {
      map['is_premium'] = Variable<bool>(isPremium.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IslamicTeachingsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('hadithArabic: $hadithArabic, ')
          ..write('hadithTranslation: $hadithTranslation, ')
          ..write('explanation: $explanation, ')
          ..write('sourceReference: $sourceReference, ')
          ..write('category: $category, ')
          ..write('isPremium: $isPremium')
          ..write(')'))
        .toString();
  }
}

class $ProphetStoriesTable extends ProphetStories
    with TableInfo<$ProphetStoriesTable, ProphetStory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProphetStoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _prophetNameArabicMeta = const VerificationMeta(
    'prophetNameArabic',
  );
  @override
  late final GeneratedColumn<String> prophetNameArabic =
      GeneratedColumn<String>(
        'prophet_name_arabic',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _prophetNameEnglishMeta =
      const VerificationMeta('prophetNameEnglish');
  @override
  late final GeneratedColumn<String> prophetNameEnglish =
      GeneratedColumn<String>(
        'prophet_name_english',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _segmentNumberMeta = const VerificationMeta(
    'segmentNumber',
  );
  @override
  late final GeneratedColumn<int> segmentNumber = GeneratedColumn<int>(
    'segment_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalSegmentsMeta = const VerificationMeta(
    'totalSegments',
  );
  @override
  late final GeneratedColumn<int> totalSegments = GeneratedColumn<int>(
    'total_segments',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyTextMeta = const VerificationMeta(
    'bodyText',
  );
  @override
  late final GeneratedColumn<String> bodyText = GeneratedColumn<String>(
    'body_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceReferenceMeta = const VerificationMeta(
    'sourceReference',
  );
  @override
  late final GeneratedColumn<String> sourceReference = GeneratedColumn<String>(
    'source_reference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPremiumMeta = const VerificationMeta(
    'isPremium',
  );
  @override
  late final GeneratedColumn<bool> isPremium = GeneratedColumn<bool>(
    'is_premium',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_premium" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    prophetNameArabic,
    prophetNameEnglish,
    segmentNumber,
    totalSegments,
    title,
    bodyText,
    sourceReference,
    isPremium,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prophet_stories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProphetStory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('prophet_name_arabic')) {
      context.handle(
        _prophetNameArabicMeta,
        prophetNameArabic.isAcceptableOrUnknown(
          data['prophet_name_arabic']!,
          _prophetNameArabicMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_prophetNameArabicMeta);
    }
    if (data.containsKey('prophet_name_english')) {
      context.handle(
        _prophetNameEnglishMeta,
        prophetNameEnglish.isAcceptableOrUnknown(
          data['prophet_name_english']!,
          _prophetNameEnglishMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_prophetNameEnglishMeta);
    }
    if (data.containsKey('segment_number')) {
      context.handle(
        _segmentNumberMeta,
        segmentNumber.isAcceptableOrUnknown(
          data['segment_number']!,
          _segmentNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_segmentNumberMeta);
    }
    if (data.containsKey('total_segments')) {
      context.handle(
        _totalSegmentsMeta,
        totalSegments.isAcceptableOrUnknown(
          data['total_segments']!,
          _totalSegmentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalSegmentsMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body_text')) {
      context.handle(
        _bodyTextMeta,
        bodyText.isAcceptableOrUnknown(data['body_text']!, _bodyTextMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyTextMeta);
    }
    if (data.containsKey('source_reference')) {
      context.handle(
        _sourceReferenceMeta,
        sourceReference.isAcceptableOrUnknown(
          data['source_reference']!,
          _sourceReferenceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceReferenceMeta);
    }
    if (data.containsKey('is_premium')) {
      context.handle(
        _isPremiumMeta,
        isPremium.isAcceptableOrUnknown(data['is_premium']!, _isPremiumMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProphetStory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProphetStory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      prophetNameArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prophet_name_arabic'],
      )!,
      prophetNameEnglish: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prophet_name_english'],
      )!,
      segmentNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}segment_number'],
      )!,
      totalSegments: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_segments'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      bodyText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_text'],
      )!,
      sourceReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_reference'],
      )!,
      isPremium: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_premium'],
      )!,
    );
  }

  @override
  $ProphetStoriesTable createAlias(String alias) {
    return $ProphetStoriesTable(attachedDatabase, alias);
  }
}

class ProphetStory extends DataClass implements Insertable<ProphetStory> {
  final int id;
  final String prophetNameArabic;
  final String prophetNameEnglish;
  final int segmentNumber;
  final int totalSegments;
  final String title;
  final String bodyText;
  final String sourceReference;
  final bool isPremium;
  const ProphetStory({
    required this.id,
    required this.prophetNameArabic,
    required this.prophetNameEnglish,
    required this.segmentNumber,
    required this.totalSegments,
    required this.title,
    required this.bodyText,
    required this.sourceReference,
    required this.isPremium,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['prophet_name_arabic'] = Variable<String>(prophetNameArabic);
    map['prophet_name_english'] = Variable<String>(prophetNameEnglish);
    map['segment_number'] = Variable<int>(segmentNumber);
    map['total_segments'] = Variable<int>(totalSegments);
    map['title'] = Variable<String>(title);
    map['body_text'] = Variable<String>(bodyText);
    map['source_reference'] = Variable<String>(sourceReference);
    map['is_premium'] = Variable<bool>(isPremium);
    return map;
  }

  ProphetStoriesCompanion toCompanion(bool nullToAbsent) {
    return ProphetStoriesCompanion(
      id: Value(id),
      prophetNameArabic: Value(prophetNameArabic),
      prophetNameEnglish: Value(prophetNameEnglish),
      segmentNumber: Value(segmentNumber),
      totalSegments: Value(totalSegments),
      title: Value(title),
      bodyText: Value(bodyText),
      sourceReference: Value(sourceReference),
      isPremium: Value(isPremium),
    );
  }

  factory ProphetStory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProphetStory(
      id: serializer.fromJson<int>(json['id']),
      prophetNameArabic: serializer.fromJson<String>(json['prophetNameArabic']),
      prophetNameEnglish: serializer.fromJson<String>(
        json['prophetNameEnglish'],
      ),
      segmentNumber: serializer.fromJson<int>(json['segmentNumber']),
      totalSegments: serializer.fromJson<int>(json['totalSegments']),
      title: serializer.fromJson<String>(json['title']),
      bodyText: serializer.fromJson<String>(json['bodyText']),
      sourceReference: serializer.fromJson<String>(json['sourceReference']),
      isPremium: serializer.fromJson<bool>(json['isPremium']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'prophetNameArabic': serializer.toJson<String>(prophetNameArabic),
      'prophetNameEnglish': serializer.toJson<String>(prophetNameEnglish),
      'segmentNumber': serializer.toJson<int>(segmentNumber),
      'totalSegments': serializer.toJson<int>(totalSegments),
      'title': serializer.toJson<String>(title),
      'bodyText': serializer.toJson<String>(bodyText),
      'sourceReference': serializer.toJson<String>(sourceReference),
      'isPremium': serializer.toJson<bool>(isPremium),
    };
  }

  ProphetStory copyWith({
    int? id,
    String? prophetNameArabic,
    String? prophetNameEnglish,
    int? segmentNumber,
    int? totalSegments,
    String? title,
    String? bodyText,
    String? sourceReference,
    bool? isPremium,
  }) => ProphetStory(
    id: id ?? this.id,
    prophetNameArabic: prophetNameArabic ?? this.prophetNameArabic,
    prophetNameEnglish: prophetNameEnglish ?? this.prophetNameEnglish,
    segmentNumber: segmentNumber ?? this.segmentNumber,
    totalSegments: totalSegments ?? this.totalSegments,
    title: title ?? this.title,
    bodyText: bodyText ?? this.bodyText,
    sourceReference: sourceReference ?? this.sourceReference,
    isPremium: isPremium ?? this.isPremium,
  );
  ProphetStory copyWithCompanion(ProphetStoriesCompanion data) {
    return ProphetStory(
      id: data.id.present ? data.id.value : this.id,
      prophetNameArabic: data.prophetNameArabic.present
          ? data.prophetNameArabic.value
          : this.prophetNameArabic,
      prophetNameEnglish: data.prophetNameEnglish.present
          ? data.prophetNameEnglish.value
          : this.prophetNameEnglish,
      segmentNumber: data.segmentNumber.present
          ? data.segmentNumber.value
          : this.segmentNumber,
      totalSegments: data.totalSegments.present
          ? data.totalSegments.value
          : this.totalSegments,
      title: data.title.present ? data.title.value : this.title,
      bodyText: data.bodyText.present ? data.bodyText.value : this.bodyText,
      sourceReference: data.sourceReference.present
          ? data.sourceReference.value
          : this.sourceReference,
      isPremium: data.isPremium.present ? data.isPremium.value : this.isPremium,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProphetStory(')
          ..write('id: $id, ')
          ..write('prophetNameArabic: $prophetNameArabic, ')
          ..write('prophetNameEnglish: $prophetNameEnglish, ')
          ..write('segmentNumber: $segmentNumber, ')
          ..write('totalSegments: $totalSegments, ')
          ..write('title: $title, ')
          ..write('bodyText: $bodyText, ')
          ..write('sourceReference: $sourceReference, ')
          ..write('isPremium: $isPremium')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    prophetNameArabic,
    prophetNameEnglish,
    segmentNumber,
    totalSegments,
    title,
    bodyText,
    sourceReference,
    isPremium,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProphetStory &&
          other.id == this.id &&
          other.prophetNameArabic == this.prophetNameArabic &&
          other.prophetNameEnglish == this.prophetNameEnglish &&
          other.segmentNumber == this.segmentNumber &&
          other.totalSegments == this.totalSegments &&
          other.title == this.title &&
          other.bodyText == this.bodyText &&
          other.sourceReference == this.sourceReference &&
          other.isPremium == this.isPremium);
}

class ProphetStoriesCompanion extends UpdateCompanion<ProphetStory> {
  final Value<int> id;
  final Value<String> prophetNameArabic;
  final Value<String> prophetNameEnglish;
  final Value<int> segmentNumber;
  final Value<int> totalSegments;
  final Value<String> title;
  final Value<String> bodyText;
  final Value<String> sourceReference;
  final Value<bool> isPremium;
  const ProphetStoriesCompanion({
    this.id = const Value.absent(),
    this.prophetNameArabic = const Value.absent(),
    this.prophetNameEnglish = const Value.absent(),
    this.segmentNumber = const Value.absent(),
    this.totalSegments = const Value.absent(),
    this.title = const Value.absent(),
    this.bodyText = const Value.absent(),
    this.sourceReference = const Value.absent(),
    this.isPremium = const Value.absent(),
  });
  ProphetStoriesCompanion.insert({
    this.id = const Value.absent(),
    required String prophetNameArabic,
    required String prophetNameEnglish,
    required int segmentNumber,
    required int totalSegments,
    required String title,
    required String bodyText,
    required String sourceReference,
    this.isPremium = const Value.absent(),
  }) : prophetNameArabic = Value(prophetNameArabic),
       prophetNameEnglish = Value(prophetNameEnglish),
       segmentNumber = Value(segmentNumber),
       totalSegments = Value(totalSegments),
       title = Value(title),
       bodyText = Value(bodyText),
       sourceReference = Value(sourceReference);
  static Insertable<ProphetStory> custom({
    Expression<int>? id,
    Expression<String>? prophetNameArabic,
    Expression<String>? prophetNameEnglish,
    Expression<int>? segmentNumber,
    Expression<int>? totalSegments,
    Expression<String>? title,
    Expression<String>? bodyText,
    Expression<String>? sourceReference,
    Expression<bool>? isPremium,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (prophetNameArabic != null) 'prophet_name_arabic': prophetNameArabic,
      if (prophetNameEnglish != null)
        'prophet_name_english': prophetNameEnglish,
      if (segmentNumber != null) 'segment_number': segmentNumber,
      if (totalSegments != null) 'total_segments': totalSegments,
      if (title != null) 'title': title,
      if (bodyText != null) 'body_text': bodyText,
      if (sourceReference != null) 'source_reference': sourceReference,
      if (isPremium != null) 'is_premium': isPremium,
    });
  }

  ProphetStoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? prophetNameArabic,
    Value<String>? prophetNameEnglish,
    Value<int>? segmentNumber,
    Value<int>? totalSegments,
    Value<String>? title,
    Value<String>? bodyText,
    Value<String>? sourceReference,
    Value<bool>? isPremium,
  }) {
    return ProphetStoriesCompanion(
      id: id ?? this.id,
      prophetNameArabic: prophetNameArabic ?? this.prophetNameArabic,
      prophetNameEnglish: prophetNameEnglish ?? this.prophetNameEnglish,
      segmentNumber: segmentNumber ?? this.segmentNumber,
      totalSegments: totalSegments ?? this.totalSegments,
      title: title ?? this.title,
      bodyText: bodyText ?? this.bodyText,
      sourceReference: sourceReference ?? this.sourceReference,
      isPremium: isPremium ?? this.isPremium,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (prophetNameArabic.present) {
      map['prophet_name_arabic'] = Variable<String>(prophetNameArabic.value);
    }
    if (prophetNameEnglish.present) {
      map['prophet_name_english'] = Variable<String>(prophetNameEnglish.value);
    }
    if (segmentNumber.present) {
      map['segment_number'] = Variable<int>(segmentNumber.value);
    }
    if (totalSegments.present) {
      map['total_segments'] = Variable<int>(totalSegments.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (bodyText.present) {
      map['body_text'] = Variable<String>(bodyText.value);
    }
    if (sourceReference.present) {
      map['source_reference'] = Variable<String>(sourceReference.value);
    }
    if (isPremium.present) {
      map['is_premium'] = Variable<bool>(isPremium.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProphetStoriesCompanion(')
          ..write('id: $id, ')
          ..write('prophetNameArabic: $prophetNameArabic, ')
          ..write('prophetNameEnglish: $prophetNameEnglish, ')
          ..write('segmentNumber: $segmentNumber, ')
          ..write('totalSegments: $totalSegments, ')
          ..write('title: $title, ')
          ..write('bodyText: $bodyText, ')
          ..write('sourceReference: $sourceReference, ')
          ..write('isPremium: $isPremium')
          ..write(')'))
        .toString();
  }
}

class $QuranTranslationsTable extends QuranTranslations
    with TableInfo<$QuranTranslationsTable, QuranTranslation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuranTranslationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ayahIdMeta = const VerificationMeta('ayahId');
  @override
  late final GeneratedColumn<int> ayahId = GeneratedColumn<int>(
    'ayah_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translationTextMeta = const VerificationMeta(
    'translationText',
  );
  @override
  late final GeneratedColumn<String> translationText = GeneratedColumn<String>(
    'translation_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ayahId,
    languageCode,
    translationText,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quran_translations';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuranTranslation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ayah_id')) {
      context.handle(
        _ayahIdMeta,
        ayahId.isAcceptableOrUnknown(data['ayah_id']!, _ayahIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahIdMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('translation_text')) {
      context.handle(
        _translationTextMeta,
        translationText.isAcceptableOrUnknown(
          data['translation_text']!,
          _translationTextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuranTranslation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuranTranslation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ayahId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_id'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      )!,
      translationText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation_text'],
      )!,
    );
  }

  @override
  $QuranTranslationsTable createAlias(String alias) {
    return $QuranTranslationsTable(attachedDatabase, alias);
  }
}

class QuranTranslation extends DataClass
    implements Insertable<QuranTranslation> {
  final int id;
  final int ayahId;
  final String languageCode;
  final String translationText;
  const QuranTranslation({
    required this.id,
    required this.ayahId,
    required this.languageCode,
    required this.translationText,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ayah_id'] = Variable<int>(ayahId);
    map['language_code'] = Variable<String>(languageCode);
    map['translation_text'] = Variable<String>(translationText);
    return map;
  }

  QuranTranslationsCompanion toCompanion(bool nullToAbsent) {
    return QuranTranslationsCompanion(
      id: Value(id),
      ayahId: Value(ayahId),
      languageCode: Value(languageCode),
      translationText: Value(translationText),
    );
  }

  factory QuranTranslation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuranTranslation(
      id: serializer.fromJson<int>(json['id']),
      ayahId: serializer.fromJson<int>(json['ayahId']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      translationText: serializer.fromJson<String>(json['translationText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ayahId': serializer.toJson<int>(ayahId),
      'languageCode': serializer.toJson<String>(languageCode),
      'translationText': serializer.toJson<String>(translationText),
    };
  }

  QuranTranslation copyWith({
    int? id,
    int? ayahId,
    String? languageCode,
    String? translationText,
  }) => QuranTranslation(
    id: id ?? this.id,
    ayahId: ayahId ?? this.ayahId,
    languageCode: languageCode ?? this.languageCode,
    translationText: translationText ?? this.translationText,
  );
  QuranTranslation copyWithCompanion(QuranTranslationsCompanion data) {
    return QuranTranslation(
      id: data.id.present ? data.id.value : this.id,
      ayahId: data.ayahId.present ? data.ayahId.value : this.ayahId,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      translationText: data.translationText.present
          ? data.translationText.value
          : this.translationText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuranTranslation(')
          ..write('id: $id, ')
          ..write('ayahId: $ayahId, ')
          ..write('languageCode: $languageCode, ')
          ..write('translationText: $translationText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ayahId, languageCode, translationText);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuranTranslation &&
          other.id == this.id &&
          other.ayahId == this.ayahId &&
          other.languageCode == this.languageCode &&
          other.translationText == this.translationText);
}

class QuranTranslationsCompanion extends UpdateCompanion<QuranTranslation> {
  final Value<int> id;
  final Value<int> ayahId;
  final Value<String> languageCode;
  final Value<String> translationText;
  const QuranTranslationsCompanion({
    this.id = const Value.absent(),
    this.ayahId = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.translationText = const Value.absent(),
  });
  QuranTranslationsCompanion.insert({
    this.id = const Value.absent(),
    required int ayahId,
    required String languageCode,
    required String translationText,
  }) : ayahId = Value(ayahId),
       languageCode = Value(languageCode),
       translationText = Value(translationText);
  static Insertable<QuranTranslation> custom({
    Expression<int>? id,
    Expression<int>? ayahId,
    Expression<String>? languageCode,
    Expression<String>? translationText,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ayahId != null) 'ayah_id': ayahId,
      if (languageCode != null) 'language_code': languageCode,
      if (translationText != null) 'translation_text': translationText,
    });
  }

  QuranTranslationsCompanion copyWith({
    Value<int>? id,
    Value<int>? ayahId,
    Value<String>? languageCode,
    Value<String>? translationText,
  }) {
    return QuranTranslationsCompanion(
      id: id ?? this.id,
      ayahId: ayahId ?? this.ayahId,
      languageCode: languageCode ?? this.languageCode,
      translationText: translationText ?? this.translationText,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ayahId.present) {
      map['ayah_id'] = Variable<int>(ayahId.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (translationText.present) {
      map['translation_text'] = Variable<String>(translationText.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuranTranslationsCompanion(')
          ..write('id: $id, ')
          ..write('ayahId: $ayahId, ')
          ..write('languageCode: $languageCode, ')
          ..write('translationText: $translationText')
          ..write(')'))
        .toString();
  }
}

class $AvailableLanguagesTable extends AvailableLanguages
    with TableInfo<$AvailableLanguagesTable, AvailableLanguage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AvailableLanguagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDownloadedMeta = const VerificationMeta(
    'isDownloaded',
  );
  @override
  late final GeneratedColumn<bool> isDownloaded = GeneratedColumn<bool>(
    'is_downloaded',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_downloaded" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [code, displayName, isDownloaded];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'available_languages';
  @override
  VerificationContext validateIntegrity(
    Insertable<AvailableLanguage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('is_downloaded')) {
      context.handle(
        _isDownloadedMeta,
        isDownloaded.isAcceptableOrUnknown(
          data['is_downloaded']!,
          _isDownloadedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  AvailableLanguage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AvailableLanguage(
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      isDownloaded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_downloaded'],
      )!,
    );
  }

  @override
  $AvailableLanguagesTable createAlias(String alias) {
    return $AvailableLanguagesTable(attachedDatabase, alias);
  }
}

class AvailableLanguage extends DataClass
    implements Insertable<AvailableLanguage> {
  final String code;
  final String displayName;
  final bool isDownloaded;
  const AvailableLanguage({
    required this.code,
    required this.displayName,
    required this.isDownloaded,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['display_name'] = Variable<String>(displayName);
    map['is_downloaded'] = Variable<bool>(isDownloaded);
    return map;
  }

  AvailableLanguagesCompanion toCompanion(bool nullToAbsent) {
    return AvailableLanguagesCompanion(
      code: Value(code),
      displayName: Value(displayName),
      isDownloaded: Value(isDownloaded),
    );
  }

  factory AvailableLanguage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AvailableLanguage(
      code: serializer.fromJson<String>(json['code']),
      displayName: serializer.fromJson<String>(json['displayName']),
      isDownloaded: serializer.fromJson<bool>(json['isDownloaded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'displayName': serializer.toJson<String>(displayName),
      'isDownloaded': serializer.toJson<bool>(isDownloaded),
    };
  }

  AvailableLanguage copyWith({
    String? code,
    String? displayName,
    bool? isDownloaded,
  }) => AvailableLanguage(
    code: code ?? this.code,
    displayName: displayName ?? this.displayName,
    isDownloaded: isDownloaded ?? this.isDownloaded,
  );
  AvailableLanguage copyWithCompanion(AvailableLanguagesCompanion data) {
    return AvailableLanguage(
      code: data.code.present ? data.code.value : this.code,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      isDownloaded: data.isDownloaded.present
          ? data.isDownloaded.value
          : this.isDownloaded,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AvailableLanguage(')
          ..write('code: $code, ')
          ..write('displayName: $displayName, ')
          ..write('isDownloaded: $isDownloaded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, displayName, isDownloaded);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AvailableLanguage &&
          other.code == this.code &&
          other.displayName == this.displayName &&
          other.isDownloaded == this.isDownloaded);
}

class AvailableLanguagesCompanion extends UpdateCompanion<AvailableLanguage> {
  final Value<String> code;
  final Value<String> displayName;
  final Value<bool> isDownloaded;
  final Value<int> rowid;
  const AvailableLanguagesCompanion({
    this.code = const Value.absent(),
    this.displayName = const Value.absent(),
    this.isDownloaded = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AvailableLanguagesCompanion.insert({
    required String code,
    required String displayName,
    this.isDownloaded = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       displayName = Value(displayName);
  static Insertable<AvailableLanguage> custom({
    Expression<String>? code,
    Expression<String>? displayName,
    Expression<bool>? isDownloaded,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (displayName != null) 'display_name': displayName,
      if (isDownloaded != null) 'is_downloaded': isDownloaded,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AvailableLanguagesCompanion copyWith({
    Value<String>? code,
    Value<String>? displayName,
    Value<bool>? isDownloaded,
    Value<int>? rowid,
  }) {
    return AvailableLanguagesCompanion(
      code: code ?? this.code,
      displayName: displayName ?? this.displayName,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (isDownloaded.present) {
      map['is_downloaded'] = Variable<bool>(isDownloaded.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AvailableLanguagesCompanion(')
          ..write('code: $code, ')
          ..write('displayName: $displayName, ')
          ..write('isDownloaded: $isDownloaded, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$QuranDatabase extends GeneratedDatabase {
  _$QuranDatabase(QueryExecutor e) : super(e);
  $QuranDatabaseManager get managers => $QuranDatabaseManager(this);
  late final $QuranAyahsTable quranAyahs = $QuranAyahsTable(this);
  late final $QuranSurahsTable quranSurahs = $QuranSurahsTable(this);
  late final $DuasTable duas = $DuasTable(this);
  late final $IslamicTeachingsTable islamicTeachings = $IslamicTeachingsTable(
    this,
  );
  late final $ProphetStoriesTable prophetStories = $ProphetStoriesTable(this);
  late final $QuranTranslationsTable quranTranslations =
      $QuranTranslationsTable(this);
  late final $AvailableLanguagesTable availableLanguages =
      $AvailableLanguagesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    quranAyahs,
    quranSurahs,
    duas,
    islamicTeachings,
    prophetStories,
    quranTranslations,
    availableLanguages,
  ];
}

typedef $$QuranAyahsTableCreateCompanionBuilder =
    QuranAyahsCompanion Function({
      Value<int> id,
      required int surah,
      required int ayah,
      required String textUthmani,
      Value<String?> textTranslationEn,
    });
typedef $$QuranAyahsTableUpdateCompanionBuilder =
    QuranAyahsCompanion Function({
      Value<int> id,
      Value<int> surah,
      Value<int> ayah,
      Value<String> textUthmani,
      Value<String?> textTranslationEn,
    });

class $$QuranAyahsTableFilterComposer
    extends Composer<_$QuranDatabase, $QuranAyahsTable> {
  $$QuranAyahsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surah => $composableBuilder(
    column: $table.surah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayah => $composableBuilder(
    column: $table.ayah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textUthmani => $composableBuilder(
    column: $table.textUthmani,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textTranslationEn => $composableBuilder(
    column: $table.textTranslationEn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QuranAyahsTableOrderingComposer
    extends Composer<_$QuranDatabase, $QuranAyahsTable> {
  $$QuranAyahsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surah => $composableBuilder(
    column: $table.surah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayah => $composableBuilder(
    column: $table.ayah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textUthmani => $composableBuilder(
    column: $table.textUthmani,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textTranslationEn => $composableBuilder(
    column: $table.textTranslationEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuranAyahsTableAnnotationComposer
    extends Composer<_$QuranDatabase, $QuranAyahsTable> {
  $$QuranAyahsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get surah =>
      $composableBuilder(column: $table.surah, builder: (column) => column);

  GeneratedColumn<int> get ayah =>
      $composableBuilder(column: $table.ayah, builder: (column) => column);

  GeneratedColumn<String> get textUthmani => $composableBuilder(
    column: $table.textUthmani,
    builder: (column) => column,
  );

  GeneratedColumn<String> get textTranslationEn => $composableBuilder(
    column: $table.textTranslationEn,
    builder: (column) => column,
  );
}

class $$QuranAyahsTableTableManager
    extends
        RootTableManager<
          _$QuranDatabase,
          $QuranAyahsTable,
          QuranAyah,
          $$QuranAyahsTableFilterComposer,
          $$QuranAyahsTableOrderingComposer,
          $$QuranAyahsTableAnnotationComposer,
          $$QuranAyahsTableCreateCompanionBuilder,
          $$QuranAyahsTableUpdateCompanionBuilder,
          (
            QuranAyah,
            BaseReferences<_$QuranDatabase, $QuranAyahsTable, QuranAyah>,
          ),
          QuranAyah,
          PrefetchHooks Function()
        > {
  $$QuranAyahsTableTableManager(_$QuranDatabase db, $QuranAyahsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuranAyahsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuranAyahsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuranAyahsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> surah = const Value.absent(),
                Value<int> ayah = const Value.absent(),
                Value<String> textUthmani = const Value.absent(),
                Value<String?> textTranslationEn = const Value.absent(),
              }) => QuranAyahsCompanion(
                id: id,
                surah: surah,
                ayah: ayah,
                textUthmani: textUthmani,
                textTranslationEn: textTranslationEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int surah,
                required int ayah,
                required String textUthmani,
                Value<String?> textTranslationEn = const Value.absent(),
              }) => QuranAyahsCompanion.insert(
                id: id,
                surah: surah,
                ayah: ayah,
                textUthmani: textUthmani,
                textTranslationEn: textTranslationEn,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QuranAyahsTableProcessedTableManager =
    ProcessedTableManager<
      _$QuranDatabase,
      $QuranAyahsTable,
      QuranAyah,
      $$QuranAyahsTableFilterComposer,
      $$QuranAyahsTableOrderingComposer,
      $$QuranAyahsTableAnnotationComposer,
      $$QuranAyahsTableCreateCompanionBuilder,
      $$QuranAyahsTableUpdateCompanionBuilder,
      (QuranAyah, BaseReferences<_$QuranDatabase, $QuranAyahsTable, QuranAyah>),
      QuranAyah,
      PrefetchHooks Function()
    >;
typedef $$QuranSurahsTableCreateCompanionBuilder =
    QuranSurahsCompanion Function({
      Value<int> number,
      required String nameArabic,
      required String nameEnglish,
      required String nameTransliteration,
      required int ayahCount,
      required String revelationType,
      required int revelationOrder,
    });
typedef $$QuranSurahsTableUpdateCompanionBuilder =
    QuranSurahsCompanion Function({
      Value<int> number,
      Value<String> nameArabic,
      Value<String> nameEnglish,
      Value<String> nameTransliteration,
      Value<int> ayahCount,
      Value<String> revelationType,
      Value<int> revelationOrder,
    });

class $$QuranSurahsTableFilterComposer
    extends Composer<_$QuranDatabase, $QuranSurahsTable> {
  $$QuranSurahsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEnglish => $composableBuilder(
    column: $table.nameEnglish,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameTransliteration => $composableBuilder(
    column: $table.nameTransliteration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahCount => $composableBuilder(
    column: $table.ayahCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get revelationType => $composableBuilder(
    column: $table.revelationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revelationOrder => $composableBuilder(
    column: $table.revelationOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QuranSurahsTableOrderingComposer
    extends Composer<_$QuranDatabase, $QuranSurahsTable> {
  $$QuranSurahsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEnglish => $composableBuilder(
    column: $table.nameEnglish,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameTransliteration => $composableBuilder(
    column: $table.nameTransliteration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahCount => $composableBuilder(
    column: $table.ayahCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get revelationType => $composableBuilder(
    column: $table.revelationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revelationOrder => $composableBuilder(
    column: $table.revelationOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuranSurahsTableAnnotationComposer
    extends Composer<_$QuranDatabase, $QuranSurahsTable> {
  $$QuranSurahsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameEnglish => $composableBuilder(
    column: $table.nameEnglish,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameTransliteration => $composableBuilder(
    column: $table.nameTransliteration,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahCount =>
      $composableBuilder(column: $table.ayahCount, builder: (column) => column);

  GeneratedColumn<String> get revelationType => $composableBuilder(
    column: $table.revelationType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get revelationOrder => $composableBuilder(
    column: $table.revelationOrder,
    builder: (column) => column,
  );
}

class $$QuranSurahsTableTableManager
    extends
        RootTableManager<
          _$QuranDatabase,
          $QuranSurahsTable,
          QuranSurah,
          $$QuranSurahsTableFilterComposer,
          $$QuranSurahsTableOrderingComposer,
          $$QuranSurahsTableAnnotationComposer,
          $$QuranSurahsTableCreateCompanionBuilder,
          $$QuranSurahsTableUpdateCompanionBuilder,
          (
            QuranSurah,
            BaseReferences<_$QuranDatabase, $QuranSurahsTable, QuranSurah>,
          ),
          QuranSurah,
          PrefetchHooks Function()
        > {
  $$QuranSurahsTableTableManager(_$QuranDatabase db, $QuranSurahsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuranSurahsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuranSurahsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuranSurahsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> number = const Value.absent(),
                Value<String> nameArabic = const Value.absent(),
                Value<String> nameEnglish = const Value.absent(),
                Value<String> nameTransliteration = const Value.absent(),
                Value<int> ayahCount = const Value.absent(),
                Value<String> revelationType = const Value.absent(),
                Value<int> revelationOrder = const Value.absent(),
              }) => QuranSurahsCompanion(
                number: number,
                nameArabic: nameArabic,
                nameEnglish: nameEnglish,
                nameTransliteration: nameTransliteration,
                ayahCount: ayahCount,
                revelationType: revelationType,
                revelationOrder: revelationOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> number = const Value.absent(),
                required String nameArabic,
                required String nameEnglish,
                required String nameTransliteration,
                required int ayahCount,
                required String revelationType,
                required int revelationOrder,
              }) => QuranSurahsCompanion.insert(
                number: number,
                nameArabic: nameArabic,
                nameEnglish: nameEnglish,
                nameTransliteration: nameTransliteration,
                ayahCount: ayahCount,
                revelationType: revelationType,
                revelationOrder: revelationOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QuranSurahsTableProcessedTableManager =
    ProcessedTableManager<
      _$QuranDatabase,
      $QuranSurahsTable,
      QuranSurah,
      $$QuranSurahsTableFilterComposer,
      $$QuranSurahsTableOrderingComposer,
      $$QuranSurahsTableAnnotationComposer,
      $$QuranSurahsTableCreateCompanionBuilder,
      $$QuranSurahsTableUpdateCompanionBuilder,
      (
        QuranSurah,
        BaseReferences<_$QuranDatabase, $QuranSurahsTable, QuranSurah>,
      ),
      QuranSurah,
      PrefetchHooks Function()
    >;
typedef $$DuasTableCreateCompanionBuilder =
    DuasCompanion Function({
      Value<int> id,
      required String titleArabic,
      required String titleEnglish,
      required String textArabic,
      required String textTranslationEn,
      required String source,
      required String category,
      Value<bool> isFromQuran,
    });
typedef $$DuasTableUpdateCompanionBuilder =
    DuasCompanion Function({
      Value<int> id,
      Value<String> titleArabic,
      Value<String> titleEnglish,
      Value<String> textArabic,
      Value<String> textTranslationEn,
      Value<String> source,
      Value<String> category,
      Value<bool> isFromQuran,
    });

class $$DuasTableFilterComposer extends Composer<_$QuranDatabase, $DuasTable> {
  $$DuasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleArabic => $composableBuilder(
    column: $table.titleArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleEnglish => $composableBuilder(
    column: $table.titleEnglish,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textArabic => $composableBuilder(
    column: $table.textArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textTranslationEn => $composableBuilder(
    column: $table.textTranslationEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFromQuran => $composableBuilder(
    column: $table.isFromQuran,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DuasTableOrderingComposer
    extends Composer<_$QuranDatabase, $DuasTable> {
  $$DuasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleArabic => $composableBuilder(
    column: $table.titleArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleEnglish => $composableBuilder(
    column: $table.titleEnglish,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textArabic => $composableBuilder(
    column: $table.textArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textTranslationEn => $composableBuilder(
    column: $table.textTranslationEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFromQuran => $composableBuilder(
    column: $table.isFromQuran,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DuasTableAnnotationComposer
    extends Composer<_$QuranDatabase, $DuasTable> {
  $$DuasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titleArabic => $composableBuilder(
    column: $table.titleArabic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get titleEnglish => $composableBuilder(
    column: $table.titleEnglish,
    builder: (column) => column,
  );

  GeneratedColumn<String> get textArabic => $composableBuilder(
    column: $table.textArabic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get textTranslationEn => $composableBuilder(
    column: $table.textTranslationEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isFromQuran => $composableBuilder(
    column: $table.isFromQuran,
    builder: (column) => column,
  );
}

class $$DuasTableTableManager
    extends
        RootTableManager<
          _$QuranDatabase,
          $DuasTable,
          Dua,
          $$DuasTableFilterComposer,
          $$DuasTableOrderingComposer,
          $$DuasTableAnnotationComposer,
          $$DuasTableCreateCompanionBuilder,
          $$DuasTableUpdateCompanionBuilder,
          (Dua, BaseReferences<_$QuranDatabase, $DuasTable, Dua>),
          Dua,
          PrefetchHooks Function()
        > {
  $$DuasTableTableManager(_$QuranDatabase db, $DuasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DuasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DuasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DuasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> titleArabic = const Value.absent(),
                Value<String> titleEnglish = const Value.absent(),
                Value<String> textArabic = const Value.absent(),
                Value<String> textTranslationEn = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isFromQuran = const Value.absent(),
              }) => DuasCompanion(
                id: id,
                titleArabic: titleArabic,
                titleEnglish: titleEnglish,
                textArabic: textArabic,
                textTranslationEn: textTranslationEn,
                source: source,
                category: category,
                isFromQuran: isFromQuran,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String titleArabic,
                required String titleEnglish,
                required String textArabic,
                required String textTranslationEn,
                required String source,
                required String category,
                Value<bool> isFromQuran = const Value.absent(),
              }) => DuasCompanion.insert(
                id: id,
                titleArabic: titleArabic,
                titleEnglish: titleEnglish,
                textArabic: textArabic,
                textTranslationEn: textTranslationEn,
                source: source,
                category: category,
                isFromQuran: isFromQuran,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DuasTableProcessedTableManager =
    ProcessedTableManager<
      _$QuranDatabase,
      $DuasTable,
      Dua,
      $$DuasTableFilterComposer,
      $$DuasTableOrderingComposer,
      $$DuasTableAnnotationComposer,
      $$DuasTableCreateCompanionBuilder,
      $$DuasTableUpdateCompanionBuilder,
      (Dua, BaseReferences<_$QuranDatabase, $DuasTable, Dua>),
      Dua,
      PrefetchHooks Function()
    >;
typedef $$IslamicTeachingsTableCreateCompanionBuilder =
    IslamicTeachingsCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> hadithArabic,
      Value<String?> hadithTranslation,
      required String explanation,
      required String sourceReference,
      required String category,
      Value<bool> isPremium,
    });
typedef $$IslamicTeachingsTableUpdateCompanionBuilder =
    IslamicTeachingsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> hadithArabic,
      Value<String?> hadithTranslation,
      Value<String> explanation,
      Value<String> sourceReference,
      Value<String> category,
      Value<bool> isPremium,
    });

class $$IslamicTeachingsTableFilterComposer
    extends Composer<_$QuranDatabase, $IslamicTeachingsTable> {
  $$IslamicTeachingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hadithArabic => $composableBuilder(
    column: $table.hadithArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hadithTranslation => $composableBuilder(
    column: $table.hadithTranslation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceReference => $composableBuilder(
    column: $table.sourceReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPremium => $composableBuilder(
    column: $table.isPremium,
    builder: (column) => ColumnFilters(column),
  );
}

class $$IslamicTeachingsTableOrderingComposer
    extends Composer<_$QuranDatabase, $IslamicTeachingsTable> {
  $$IslamicTeachingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hadithArabic => $composableBuilder(
    column: $table.hadithArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hadithTranslation => $composableBuilder(
    column: $table.hadithTranslation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceReference => $composableBuilder(
    column: $table.sourceReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPremium => $composableBuilder(
    column: $table.isPremium,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IslamicTeachingsTableAnnotationComposer
    extends Composer<_$QuranDatabase, $IslamicTeachingsTable> {
  $$IslamicTeachingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get hadithArabic => $composableBuilder(
    column: $table.hadithArabic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hadithTranslation => $composableBuilder(
    column: $table.hadithTranslation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceReference => $composableBuilder(
    column: $table.sourceReference,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isPremium =>
      $composableBuilder(column: $table.isPremium, builder: (column) => column);
}

class $$IslamicTeachingsTableTableManager
    extends
        RootTableManager<
          _$QuranDatabase,
          $IslamicTeachingsTable,
          IslamicTeaching,
          $$IslamicTeachingsTableFilterComposer,
          $$IslamicTeachingsTableOrderingComposer,
          $$IslamicTeachingsTableAnnotationComposer,
          $$IslamicTeachingsTableCreateCompanionBuilder,
          $$IslamicTeachingsTableUpdateCompanionBuilder,
          (
            IslamicTeaching,
            BaseReferences<
              _$QuranDatabase,
              $IslamicTeachingsTable,
              IslamicTeaching
            >,
          ),
          IslamicTeaching,
          PrefetchHooks Function()
        > {
  $$IslamicTeachingsTableTableManager(
    _$QuranDatabase db,
    $IslamicTeachingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IslamicTeachingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IslamicTeachingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IslamicTeachingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> hadithArabic = const Value.absent(),
                Value<String?> hadithTranslation = const Value.absent(),
                Value<String> explanation = const Value.absent(),
                Value<String> sourceReference = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isPremium = const Value.absent(),
              }) => IslamicTeachingsCompanion(
                id: id,
                title: title,
                hadithArabic: hadithArabic,
                hadithTranslation: hadithTranslation,
                explanation: explanation,
                sourceReference: sourceReference,
                category: category,
                isPremium: isPremium,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> hadithArabic = const Value.absent(),
                Value<String?> hadithTranslation = const Value.absent(),
                required String explanation,
                required String sourceReference,
                required String category,
                Value<bool> isPremium = const Value.absent(),
              }) => IslamicTeachingsCompanion.insert(
                id: id,
                title: title,
                hadithArabic: hadithArabic,
                hadithTranslation: hadithTranslation,
                explanation: explanation,
                sourceReference: sourceReference,
                category: category,
                isPremium: isPremium,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IslamicTeachingsTableProcessedTableManager =
    ProcessedTableManager<
      _$QuranDatabase,
      $IslamicTeachingsTable,
      IslamicTeaching,
      $$IslamicTeachingsTableFilterComposer,
      $$IslamicTeachingsTableOrderingComposer,
      $$IslamicTeachingsTableAnnotationComposer,
      $$IslamicTeachingsTableCreateCompanionBuilder,
      $$IslamicTeachingsTableUpdateCompanionBuilder,
      (
        IslamicTeaching,
        BaseReferences<
          _$QuranDatabase,
          $IslamicTeachingsTable,
          IslamicTeaching
        >,
      ),
      IslamicTeaching,
      PrefetchHooks Function()
    >;
typedef $$ProphetStoriesTableCreateCompanionBuilder =
    ProphetStoriesCompanion Function({
      Value<int> id,
      required String prophetNameArabic,
      required String prophetNameEnglish,
      required int segmentNumber,
      required int totalSegments,
      required String title,
      required String bodyText,
      required String sourceReference,
      Value<bool> isPremium,
    });
typedef $$ProphetStoriesTableUpdateCompanionBuilder =
    ProphetStoriesCompanion Function({
      Value<int> id,
      Value<String> prophetNameArabic,
      Value<String> prophetNameEnglish,
      Value<int> segmentNumber,
      Value<int> totalSegments,
      Value<String> title,
      Value<String> bodyText,
      Value<String> sourceReference,
      Value<bool> isPremium,
    });

class $$ProphetStoriesTableFilterComposer
    extends Composer<_$QuranDatabase, $ProphetStoriesTable> {
  $$ProphetStoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prophetNameArabic => $composableBuilder(
    column: $table.prophetNameArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prophetNameEnglish => $composableBuilder(
    column: $table.prophetNameEnglish,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get segmentNumber => $composableBuilder(
    column: $table.segmentNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalSegments => $composableBuilder(
    column: $table.totalSegments,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyText => $composableBuilder(
    column: $table.bodyText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceReference => $composableBuilder(
    column: $table.sourceReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPremium => $composableBuilder(
    column: $table.isPremium,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProphetStoriesTableOrderingComposer
    extends Composer<_$QuranDatabase, $ProphetStoriesTable> {
  $$ProphetStoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prophetNameArabic => $composableBuilder(
    column: $table.prophetNameArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prophetNameEnglish => $composableBuilder(
    column: $table.prophetNameEnglish,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get segmentNumber => $composableBuilder(
    column: $table.segmentNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalSegments => $composableBuilder(
    column: $table.totalSegments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyText => $composableBuilder(
    column: $table.bodyText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceReference => $composableBuilder(
    column: $table.sourceReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPremium => $composableBuilder(
    column: $table.isPremium,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProphetStoriesTableAnnotationComposer
    extends Composer<_$QuranDatabase, $ProphetStoriesTable> {
  $$ProphetStoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get prophetNameArabic => $composableBuilder(
    column: $table.prophetNameArabic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get prophetNameEnglish => $composableBuilder(
    column: $table.prophetNameEnglish,
    builder: (column) => column,
  );

  GeneratedColumn<int> get segmentNumber => $composableBuilder(
    column: $table.segmentNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalSegments => $composableBuilder(
    column: $table.totalSegments,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get bodyText =>
      $composableBuilder(column: $table.bodyText, builder: (column) => column);

  GeneratedColumn<String> get sourceReference => $composableBuilder(
    column: $table.sourceReference,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPremium =>
      $composableBuilder(column: $table.isPremium, builder: (column) => column);
}

class $$ProphetStoriesTableTableManager
    extends
        RootTableManager<
          _$QuranDatabase,
          $ProphetStoriesTable,
          ProphetStory,
          $$ProphetStoriesTableFilterComposer,
          $$ProphetStoriesTableOrderingComposer,
          $$ProphetStoriesTableAnnotationComposer,
          $$ProphetStoriesTableCreateCompanionBuilder,
          $$ProphetStoriesTableUpdateCompanionBuilder,
          (
            ProphetStory,
            BaseReferences<_$QuranDatabase, $ProphetStoriesTable, ProphetStory>,
          ),
          ProphetStory,
          PrefetchHooks Function()
        > {
  $$ProphetStoriesTableTableManager(
    _$QuranDatabase db,
    $ProphetStoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProphetStoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProphetStoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProphetStoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> prophetNameArabic = const Value.absent(),
                Value<String> prophetNameEnglish = const Value.absent(),
                Value<int> segmentNumber = const Value.absent(),
                Value<int> totalSegments = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> bodyText = const Value.absent(),
                Value<String> sourceReference = const Value.absent(),
                Value<bool> isPremium = const Value.absent(),
              }) => ProphetStoriesCompanion(
                id: id,
                prophetNameArabic: prophetNameArabic,
                prophetNameEnglish: prophetNameEnglish,
                segmentNumber: segmentNumber,
                totalSegments: totalSegments,
                title: title,
                bodyText: bodyText,
                sourceReference: sourceReference,
                isPremium: isPremium,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String prophetNameArabic,
                required String prophetNameEnglish,
                required int segmentNumber,
                required int totalSegments,
                required String title,
                required String bodyText,
                required String sourceReference,
                Value<bool> isPremium = const Value.absent(),
              }) => ProphetStoriesCompanion.insert(
                id: id,
                prophetNameArabic: prophetNameArabic,
                prophetNameEnglish: prophetNameEnglish,
                segmentNumber: segmentNumber,
                totalSegments: totalSegments,
                title: title,
                bodyText: bodyText,
                sourceReference: sourceReference,
                isPremium: isPremium,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProphetStoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$QuranDatabase,
      $ProphetStoriesTable,
      ProphetStory,
      $$ProphetStoriesTableFilterComposer,
      $$ProphetStoriesTableOrderingComposer,
      $$ProphetStoriesTableAnnotationComposer,
      $$ProphetStoriesTableCreateCompanionBuilder,
      $$ProphetStoriesTableUpdateCompanionBuilder,
      (
        ProphetStory,
        BaseReferences<_$QuranDatabase, $ProphetStoriesTable, ProphetStory>,
      ),
      ProphetStory,
      PrefetchHooks Function()
    >;
typedef $$QuranTranslationsTableCreateCompanionBuilder =
    QuranTranslationsCompanion Function({
      Value<int> id,
      required int ayahId,
      required String languageCode,
      required String translationText,
    });
typedef $$QuranTranslationsTableUpdateCompanionBuilder =
    QuranTranslationsCompanion Function({
      Value<int> id,
      Value<int> ayahId,
      Value<String> languageCode,
      Value<String> translationText,
    });

class $$QuranTranslationsTableFilterComposer
    extends Composer<_$QuranDatabase, $QuranTranslationsTable> {
  $$QuranTranslationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahId => $composableBuilder(
    column: $table.ayahId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translationText => $composableBuilder(
    column: $table.translationText,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QuranTranslationsTableOrderingComposer
    extends Composer<_$QuranDatabase, $QuranTranslationsTable> {
  $$QuranTranslationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahId => $composableBuilder(
    column: $table.ayahId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translationText => $composableBuilder(
    column: $table.translationText,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuranTranslationsTableAnnotationComposer
    extends Composer<_$QuranDatabase, $QuranTranslationsTable> {
  $$QuranTranslationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ayahId =>
      $composableBuilder(column: $table.ayahId, builder: (column) => column);

  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get translationText => $composableBuilder(
    column: $table.translationText,
    builder: (column) => column,
  );
}

class $$QuranTranslationsTableTableManager
    extends
        RootTableManager<
          _$QuranDatabase,
          $QuranTranslationsTable,
          QuranTranslation,
          $$QuranTranslationsTableFilterComposer,
          $$QuranTranslationsTableOrderingComposer,
          $$QuranTranslationsTableAnnotationComposer,
          $$QuranTranslationsTableCreateCompanionBuilder,
          $$QuranTranslationsTableUpdateCompanionBuilder,
          (
            QuranTranslation,
            BaseReferences<
              _$QuranDatabase,
              $QuranTranslationsTable,
              QuranTranslation
            >,
          ),
          QuranTranslation,
          PrefetchHooks Function()
        > {
  $$QuranTranslationsTableTableManager(
    _$QuranDatabase db,
    $QuranTranslationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuranTranslationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuranTranslationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuranTranslationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ayahId = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<String> translationText = const Value.absent(),
              }) => QuranTranslationsCompanion(
                id: id,
                ayahId: ayahId,
                languageCode: languageCode,
                translationText: translationText,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int ayahId,
                required String languageCode,
                required String translationText,
              }) => QuranTranslationsCompanion.insert(
                id: id,
                ayahId: ayahId,
                languageCode: languageCode,
                translationText: translationText,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QuranTranslationsTableProcessedTableManager =
    ProcessedTableManager<
      _$QuranDatabase,
      $QuranTranslationsTable,
      QuranTranslation,
      $$QuranTranslationsTableFilterComposer,
      $$QuranTranslationsTableOrderingComposer,
      $$QuranTranslationsTableAnnotationComposer,
      $$QuranTranslationsTableCreateCompanionBuilder,
      $$QuranTranslationsTableUpdateCompanionBuilder,
      (
        QuranTranslation,
        BaseReferences<
          _$QuranDatabase,
          $QuranTranslationsTable,
          QuranTranslation
        >,
      ),
      QuranTranslation,
      PrefetchHooks Function()
    >;
typedef $$AvailableLanguagesTableCreateCompanionBuilder =
    AvailableLanguagesCompanion Function({
      required String code,
      required String displayName,
      Value<bool> isDownloaded,
      Value<int> rowid,
    });
typedef $$AvailableLanguagesTableUpdateCompanionBuilder =
    AvailableLanguagesCompanion Function({
      Value<String> code,
      Value<String> displayName,
      Value<bool> isDownloaded,
      Value<int> rowid,
    });

class $$AvailableLanguagesTableFilterComposer
    extends Composer<_$QuranDatabase, $AvailableLanguagesTable> {
  $$AvailableLanguagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDownloaded => $composableBuilder(
    column: $table.isDownloaded,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AvailableLanguagesTableOrderingComposer
    extends Composer<_$QuranDatabase, $AvailableLanguagesTable> {
  $$AvailableLanguagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDownloaded => $composableBuilder(
    column: $table.isDownloaded,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AvailableLanguagesTableAnnotationComposer
    extends Composer<_$QuranDatabase, $AvailableLanguagesTable> {
  $$AvailableLanguagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDownloaded => $composableBuilder(
    column: $table.isDownloaded,
    builder: (column) => column,
  );
}

class $$AvailableLanguagesTableTableManager
    extends
        RootTableManager<
          _$QuranDatabase,
          $AvailableLanguagesTable,
          AvailableLanguage,
          $$AvailableLanguagesTableFilterComposer,
          $$AvailableLanguagesTableOrderingComposer,
          $$AvailableLanguagesTableAnnotationComposer,
          $$AvailableLanguagesTableCreateCompanionBuilder,
          $$AvailableLanguagesTableUpdateCompanionBuilder,
          (
            AvailableLanguage,
            BaseReferences<
              _$QuranDatabase,
              $AvailableLanguagesTable,
              AvailableLanguage
            >,
          ),
          AvailableLanguage,
          PrefetchHooks Function()
        > {
  $$AvailableLanguagesTableTableManager(
    _$QuranDatabase db,
    $AvailableLanguagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AvailableLanguagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AvailableLanguagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AvailableLanguagesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> code = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<bool> isDownloaded = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AvailableLanguagesCompanion(
                code: code,
                displayName: displayName,
                isDownloaded: isDownloaded,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String code,
                required String displayName,
                Value<bool> isDownloaded = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AvailableLanguagesCompanion.insert(
                code: code,
                displayName: displayName,
                isDownloaded: isDownloaded,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AvailableLanguagesTableProcessedTableManager =
    ProcessedTableManager<
      _$QuranDatabase,
      $AvailableLanguagesTable,
      AvailableLanguage,
      $$AvailableLanguagesTableFilterComposer,
      $$AvailableLanguagesTableOrderingComposer,
      $$AvailableLanguagesTableAnnotationComposer,
      $$AvailableLanguagesTableCreateCompanionBuilder,
      $$AvailableLanguagesTableUpdateCompanionBuilder,
      (
        AvailableLanguage,
        BaseReferences<
          _$QuranDatabase,
          $AvailableLanguagesTable,
          AvailableLanguage
        >,
      ),
      AvailableLanguage,
      PrefetchHooks Function()
    >;

class $QuranDatabaseManager {
  final _$QuranDatabase _db;
  $QuranDatabaseManager(this._db);
  $$QuranAyahsTableTableManager get quranAyahs =>
      $$QuranAyahsTableTableManager(_db, _db.quranAyahs);
  $$QuranSurahsTableTableManager get quranSurahs =>
      $$QuranSurahsTableTableManager(_db, _db.quranSurahs);
  $$DuasTableTableManager get duas => $$DuasTableTableManager(_db, _db.duas);
  $$IslamicTeachingsTableTableManager get islamicTeachings =>
      $$IslamicTeachingsTableTableManager(_db, _db.islamicTeachings);
  $$ProphetStoriesTableTableManager get prophetStories =>
      $$ProphetStoriesTableTableManager(_db, _db.prophetStories);
  $$QuranTranslationsTableTableManager get quranTranslations =>
      $$QuranTranslationsTableTableManager(_db, _db.quranTranslations);
  $$AvailableLanguagesTableTableManager get availableLanguages =>
      $$AvailableLanguagesTableTableManager(_db, _db.availableLanguages);
}
