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

abstract class _$QuranDatabase extends GeneratedDatabase {
  _$QuranDatabase(QueryExecutor e) : super(e);
  $QuranDatabaseManager get managers => $QuranDatabaseManager(this);
  late final $QuranAyahsTable quranAyahs = $QuranAyahsTable(this);
  late final $QuranSurahsTable quranSurahs = $QuranSurahsTable(this);
  late final $DuasTable duas = $DuasTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    quranAyahs,
    quranSurahs,
    duas,
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

class $QuranDatabaseManager {
  final _$QuranDatabase _db;
  $QuranDatabaseManager(this._db);
  $$QuranAyahsTableTableManager get quranAyahs =>
      $$QuranAyahsTableTableManager(_db, _db.quranAyahs);
  $$QuranSurahsTableTableManager get quranSurahs =>
      $$QuranSurahsTableTableManager(_db, _db.quranSurahs);
  $$DuasTableTableManager get duas => $$DuasTableTableManager(_db, _db.duas);
}
