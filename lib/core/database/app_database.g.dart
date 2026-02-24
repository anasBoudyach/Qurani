// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SurahsTable extends Surahs with TableInfo<$SurahsTable, Surah> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurahsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
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
  static const VerificationMeta _juzStartMeta = const VerificationMeta(
    'juzStart',
  );
  @override
  late final GeneratedColumn<int> juzStart = GeneratedColumn<int>(
    'juz_start',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameArabic,
    nameEnglish,
    nameTransliteration,
    ayahCount,
    revelationType,
    revelationOrder,
    juzStart,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'surahs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Surah> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    if (data.containsKey('juz_start')) {
      context.handle(
        _juzStartMeta,
        juzStart.isAcceptableOrUnknown(data['juz_start']!, _juzStartMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Surah map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Surah(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      nameArabic:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name_arabic'],
          )!,
      nameEnglish:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name_english'],
          )!,
      nameTransliteration:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name_transliteration'],
          )!,
      ayahCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}ayah_count'],
          )!,
      revelationType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}revelation_type'],
          )!,
      revelationOrder:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}revelation_order'],
          )!,
      juzStart:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}juz_start'],
          )!,
    );
  }

  @override
  $SurahsTable createAlias(String alias) {
    return $SurahsTable(attachedDatabase, alias);
  }
}

class Surah extends DataClass implements Insertable<Surah> {
  final int id;
  final String nameArabic;
  final String nameEnglish;
  final String nameTransliteration;
  final int ayahCount;
  final String revelationType;
  final int revelationOrder;
  final int juzStart;
  const Surah({
    required this.id,
    required this.nameArabic,
    required this.nameEnglish,
    required this.nameTransliteration,
    required this.ayahCount,
    required this.revelationType,
    required this.revelationOrder,
    required this.juzStart,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_arabic'] = Variable<String>(nameArabic);
    map['name_english'] = Variable<String>(nameEnglish);
    map['name_transliteration'] = Variable<String>(nameTransliteration);
    map['ayah_count'] = Variable<int>(ayahCount);
    map['revelation_type'] = Variable<String>(revelationType);
    map['revelation_order'] = Variable<int>(revelationOrder);
    map['juz_start'] = Variable<int>(juzStart);
    return map;
  }

  SurahsCompanion toCompanion(bool nullToAbsent) {
    return SurahsCompanion(
      id: Value(id),
      nameArabic: Value(nameArabic),
      nameEnglish: Value(nameEnglish),
      nameTransliteration: Value(nameTransliteration),
      ayahCount: Value(ayahCount),
      revelationType: Value(revelationType),
      revelationOrder: Value(revelationOrder),
      juzStart: Value(juzStart),
    );
  }

  factory Surah.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Surah(
      id: serializer.fromJson<int>(json['id']),
      nameArabic: serializer.fromJson<String>(json['nameArabic']),
      nameEnglish: serializer.fromJson<String>(json['nameEnglish']),
      nameTransliteration: serializer.fromJson<String>(
        json['nameTransliteration'],
      ),
      ayahCount: serializer.fromJson<int>(json['ayahCount']),
      revelationType: serializer.fromJson<String>(json['revelationType']),
      revelationOrder: serializer.fromJson<int>(json['revelationOrder']),
      juzStart: serializer.fromJson<int>(json['juzStart']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameArabic': serializer.toJson<String>(nameArabic),
      'nameEnglish': serializer.toJson<String>(nameEnglish),
      'nameTransliteration': serializer.toJson<String>(nameTransliteration),
      'ayahCount': serializer.toJson<int>(ayahCount),
      'revelationType': serializer.toJson<String>(revelationType),
      'revelationOrder': serializer.toJson<int>(revelationOrder),
      'juzStart': serializer.toJson<int>(juzStart),
    };
  }

  Surah copyWith({
    int? id,
    String? nameArabic,
    String? nameEnglish,
    String? nameTransliteration,
    int? ayahCount,
    String? revelationType,
    int? revelationOrder,
    int? juzStart,
  }) => Surah(
    id: id ?? this.id,
    nameArabic: nameArabic ?? this.nameArabic,
    nameEnglish: nameEnglish ?? this.nameEnglish,
    nameTransliteration: nameTransliteration ?? this.nameTransliteration,
    ayahCount: ayahCount ?? this.ayahCount,
    revelationType: revelationType ?? this.revelationType,
    revelationOrder: revelationOrder ?? this.revelationOrder,
    juzStart: juzStart ?? this.juzStart,
  );
  Surah copyWithCompanion(SurahsCompanion data) {
    return Surah(
      id: data.id.present ? data.id.value : this.id,
      nameArabic:
          data.nameArabic.present ? data.nameArabic.value : this.nameArabic,
      nameEnglish:
          data.nameEnglish.present ? data.nameEnglish.value : this.nameEnglish,
      nameTransliteration:
          data.nameTransliteration.present
              ? data.nameTransliteration.value
              : this.nameTransliteration,
      ayahCount: data.ayahCount.present ? data.ayahCount.value : this.ayahCount,
      revelationType:
          data.revelationType.present
              ? data.revelationType.value
              : this.revelationType,
      revelationOrder:
          data.revelationOrder.present
              ? data.revelationOrder.value
              : this.revelationOrder,
      juzStart: data.juzStart.present ? data.juzStart.value : this.juzStart,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Surah(')
          ..write('id: $id, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('nameEnglish: $nameEnglish, ')
          ..write('nameTransliteration: $nameTransliteration, ')
          ..write('ayahCount: $ayahCount, ')
          ..write('revelationType: $revelationType, ')
          ..write('revelationOrder: $revelationOrder, ')
          ..write('juzStart: $juzStart')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nameArabic,
    nameEnglish,
    nameTransliteration,
    ayahCount,
    revelationType,
    revelationOrder,
    juzStart,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Surah &&
          other.id == this.id &&
          other.nameArabic == this.nameArabic &&
          other.nameEnglish == this.nameEnglish &&
          other.nameTransliteration == this.nameTransliteration &&
          other.ayahCount == this.ayahCount &&
          other.revelationType == this.revelationType &&
          other.revelationOrder == this.revelationOrder &&
          other.juzStart == this.juzStart);
}

class SurahsCompanion extends UpdateCompanion<Surah> {
  final Value<int> id;
  final Value<String> nameArabic;
  final Value<String> nameEnglish;
  final Value<String> nameTransliteration;
  final Value<int> ayahCount;
  final Value<String> revelationType;
  final Value<int> revelationOrder;
  final Value<int> juzStart;
  const SurahsCompanion({
    this.id = const Value.absent(),
    this.nameArabic = const Value.absent(),
    this.nameEnglish = const Value.absent(),
    this.nameTransliteration = const Value.absent(),
    this.ayahCount = const Value.absent(),
    this.revelationType = const Value.absent(),
    this.revelationOrder = const Value.absent(),
    this.juzStart = const Value.absent(),
  });
  SurahsCompanion.insert({
    this.id = const Value.absent(),
    required String nameArabic,
    required String nameEnglish,
    required String nameTransliteration,
    required int ayahCount,
    required String revelationType,
    required int revelationOrder,
    this.juzStart = const Value.absent(),
  }) : nameArabic = Value(nameArabic),
       nameEnglish = Value(nameEnglish),
       nameTransliteration = Value(nameTransliteration),
       ayahCount = Value(ayahCount),
       revelationType = Value(revelationType),
       revelationOrder = Value(revelationOrder);
  static Insertable<Surah> custom({
    Expression<int>? id,
    Expression<String>? nameArabic,
    Expression<String>? nameEnglish,
    Expression<String>? nameTransliteration,
    Expression<int>? ayahCount,
    Expression<String>? revelationType,
    Expression<int>? revelationOrder,
    Expression<int>? juzStart,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameArabic != null) 'name_arabic': nameArabic,
      if (nameEnglish != null) 'name_english': nameEnglish,
      if (nameTransliteration != null)
        'name_transliteration': nameTransliteration,
      if (ayahCount != null) 'ayah_count': ayahCount,
      if (revelationType != null) 'revelation_type': revelationType,
      if (revelationOrder != null) 'revelation_order': revelationOrder,
      if (juzStart != null) 'juz_start': juzStart,
    });
  }

  SurahsCompanion copyWith({
    Value<int>? id,
    Value<String>? nameArabic,
    Value<String>? nameEnglish,
    Value<String>? nameTransliteration,
    Value<int>? ayahCount,
    Value<String>? revelationType,
    Value<int>? revelationOrder,
    Value<int>? juzStart,
  }) {
    return SurahsCompanion(
      id: id ?? this.id,
      nameArabic: nameArabic ?? this.nameArabic,
      nameEnglish: nameEnglish ?? this.nameEnglish,
      nameTransliteration: nameTransliteration ?? this.nameTransliteration,
      ayahCount: ayahCount ?? this.ayahCount,
      revelationType: revelationType ?? this.revelationType,
      revelationOrder: revelationOrder ?? this.revelationOrder,
      juzStart: juzStart ?? this.juzStart,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
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
    if (juzStart.present) {
      map['juz_start'] = Variable<int>(juzStart.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurahsCompanion(')
          ..write('id: $id, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('nameEnglish: $nameEnglish, ')
          ..write('nameTransliteration: $nameTransliteration, ')
          ..write('ayahCount: $ayahCount, ')
          ..write('revelationType: $revelationType, ')
          ..write('revelationOrder: $revelationOrder, ')
          ..write('juzStart: $juzStart')
          ..write(')'))
        .toString();
  }
}

class $AyahsTable extends Ayahs with TableInfo<$AyahsTable, Ayah> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AyahsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _surahIdMeta = const VerificationMeta(
    'surahId',
  );
  @override
  late final GeneratedColumn<int> surahId = GeneratedColumn<int>(
    'surah_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES surahs (id)',
    ),
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
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
  static const VerificationMeta _textUthmaniTajweedMeta =
      const VerificationMeta('textUthmaniTajweed');
  @override
  late final GeneratedColumn<String> textUthmaniTajweed =
      GeneratedColumn<String>(
        'text_uthmani_tajweed',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _juzNumberMeta = const VerificationMeta(
    'juzNumber',
  );
  @override
  late final GeneratedColumn<int> juzNumber = GeneratedColumn<int>(
    'juz_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hizbQuarterMeta = const VerificationMeta(
    'hizbQuarter',
  );
  @override
  late final GeneratedColumn<int> hizbQuarter = GeneratedColumn<int>(
    'hizb_quarter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pageNumberMeta = const VerificationMeta(
    'pageNumber',
  );
  @override
  late final GeneratedColumn<int> pageNumber = GeneratedColumn<int>(
    'page_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    surahId,
    ayahNumber,
    textUthmani,
    textUthmaniTajweed,
    juzNumber,
    hizbQuarter,
    pageNumber,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ayahs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ayah> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_id')) {
      context.handle(
        _surahIdMeta,
        surahId.isAcceptableOrUnknown(data['surah_id']!, _surahIdMeta),
      );
    } else if (isInserting) {
      context.missing(_surahIdMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
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
    if (data.containsKey('text_uthmani_tajweed')) {
      context.handle(
        _textUthmaniTajweedMeta,
        textUthmaniTajweed.isAcceptableOrUnknown(
          data['text_uthmani_tajweed']!,
          _textUthmaniTajweedMeta,
        ),
      );
    }
    if (data.containsKey('juz_number')) {
      context.handle(
        _juzNumberMeta,
        juzNumber.isAcceptableOrUnknown(data['juz_number']!, _juzNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_juzNumberMeta);
    }
    if (data.containsKey('hizb_quarter')) {
      context.handle(
        _hizbQuarterMeta,
        hizbQuarter.isAcceptableOrUnknown(
          data['hizb_quarter']!,
          _hizbQuarterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hizbQuarterMeta);
    }
    if (data.containsKey('page_number')) {
      context.handle(
        _pageNumberMeta,
        pageNumber.isAcceptableOrUnknown(data['page_number']!, _pageNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_pageNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {surahId, ayahNumber},
  ];
  @override
  Ayah map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ayah(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      surahId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}surah_id'],
          )!,
      ayahNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}ayah_number'],
          )!,
      textUthmani:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}text_uthmani'],
          )!,
      textUthmaniTajweed: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_uthmani_tajweed'],
      ),
      juzNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}juz_number'],
          )!,
      hizbQuarter:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}hizb_quarter'],
          )!,
      pageNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}page_number'],
          )!,
    );
  }

  @override
  $AyahsTable createAlias(String alias) {
    return $AyahsTable(attachedDatabase, alias);
  }
}

class Ayah extends DataClass implements Insertable<Ayah> {
  final int id;
  final int surahId;
  final int ayahNumber;
  final String textUthmani;
  final String? textUthmaniTajweed;
  final int juzNumber;
  final int hizbQuarter;
  final int pageNumber;
  const Ayah({
    required this.id,
    required this.surahId,
    required this.ayahNumber,
    required this.textUthmani,
    this.textUthmaniTajweed,
    required this.juzNumber,
    required this.hizbQuarter,
    required this.pageNumber,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_id'] = Variable<int>(surahId);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['text_uthmani'] = Variable<String>(textUthmani);
    if (!nullToAbsent || textUthmaniTajweed != null) {
      map['text_uthmani_tajweed'] = Variable<String>(textUthmaniTajweed);
    }
    map['juz_number'] = Variable<int>(juzNumber);
    map['hizb_quarter'] = Variable<int>(hizbQuarter);
    map['page_number'] = Variable<int>(pageNumber);
    return map;
  }

  AyahsCompanion toCompanion(bool nullToAbsent) {
    return AyahsCompanion(
      id: Value(id),
      surahId: Value(surahId),
      ayahNumber: Value(ayahNumber),
      textUthmani: Value(textUthmani),
      textUthmaniTajweed:
          textUthmaniTajweed == null && nullToAbsent
              ? const Value.absent()
              : Value(textUthmaniTajweed),
      juzNumber: Value(juzNumber),
      hizbQuarter: Value(hizbQuarter),
      pageNumber: Value(pageNumber),
    );
  }

  factory Ayah.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ayah(
      id: serializer.fromJson<int>(json['id']),
      surahId: serializer.fromJson<int>(json['surahId']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      textUthmani: serializer.fromJson<String>(json['textUthmani']),
      textUthmaniTajweed: serializer.fromJson<String?>(
        json['textUthmaniTajweed'],
      ),
      juzNumber: serializer.fromJson<int>(json['juzNumber']),
      hizbQuarter: serializer.fromJson<int>(json['hizbQuarter']),
      pageNumber: serializer.fromJson<int>(json['pageNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahId': serializer.toJson<int>(surahId),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'textUthmani': serializer.toJson<String>(textUthmani),
      'textUthmaniTajweed': serializer.toJson<String?>(textUthmaniTajweed),
      'juzNumber': serializer.toJson<int>(juzNumber),
      'hizbQuarter': serializer.toJson<int>(hizbQuarter),
      'pageNumber': serializer.toJson<int>(pageNumber),
    };
  }

  Ayah copyWith({
    int? id,
    int? surahId,
    int? ayahNumber,
    String? textUthmani,
    Value<String?> textUthmaniTajweed = const Value.absent(),
    int? juzNumber,
    int? hizbQuarter,
    int? pageNumber,
  }) => Ayah(
    id: id ?? this.id,
    surahId: surahId ?? this.surahId,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    textUthmani: textUthmani ?? this.textUthmani,
    textUthmaniTajweed:
        textUthmaniTajweed.present
            ? textUthmaniTajweed.value
            : this.textUthmaniTajweed,
    juzNumber: juzNumber ?? this.juzNumber,
    hizbQuarter: hizbQuarter ?? this.hizbQuarter,
    pageNumber: pageNumber ?? this.pageNumber,
  );
  Ayah copyWithCompanion(AyahsCompanion data) {
    return Ayah(
      id: data.id.present ? data.id.value : this.id,
      surahId: data.surahId.present ? data.surahId.value : this.surahId,
      ayahNumber:
          data.ayahNumber.present ? data.ayahNumber.value : this.ayahNumber,
      textUthmani:
          data.textUthmani.present ? data.textUthmani.value : this.textUthmani,
      textUthmaniTajweed:
          data.textUthmaniTajweed.present
              ? data.textUthmaniTajweed.value
              : this.textUthmaniTajweed,
      juzNumber: data.juzNumber.present ? data.juzNumber.value : this.juzNumber,
      hizbQuarter:
          data.hizbQuarter.present ? data.hizbQuarter.value : this.hizbQuarter,
      pageNumber:
          data.pageNumber.present ? data.pageNumber.value : this.pageNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ayah(')
          ..write('id: $id, ')
          ..write('surahId: $surahId, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('textUthmani: $textUthmani, ')
          ..write('textUthmaniTajweed: $textUthmaniTajweed, ')
          ..write('juzNumber: $juzNumber, ')
          ..write('hizbQuarter: $hizbQuarter, ')
          ..write('pageNumber: $pageNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    surahId,
    ayahNumber,
    textUthmani,
    textUthmaniTajweed,
    juzNumber,
    hizbQuarter,
    pageNumber,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ayah &&
          other.id == this.id &&
          other.surahId == this.surahId &&
          other.ayahNumber == this.ayahNumber &&
          other.textUthmani == this.textUthmani &&
          other.textUthmaniTajweed == this.textUthmaniTajweed &&
          other.juzNumber == this.juzNumber &&
          other.hizbQuarter == this.hizbQuarter &&
          other.pageNumber == this.pageNumber);
}

class AyahsCompanion extends UpdateCompanion<Ayah> {
  final Value<int> id;
  final Value<int> surahId;
  final Value<int> ayahNumber;
  final Value<String> textUthmani;
  final Value<String?> textUthmaniTajweed;
  final Value<int> juzNumber;
  final Value<int> hizbQuarter;
  final Value<int> pageNumber;
  const AyahsCompanion({
    this.id = const Value.absent(),
    this.surahId = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.textUthmani = const Value.absent(),
    this.textUthmaniTajweed = const Value.absent(),
    this.juzNumber = const Value.absent(),
    this.hizbQuarter = const Value.absent(),
    this.pageNumber = const Value.absent(),
  });
  AyahsCompanion.insert({
    this.id = const Value.absent(),
    required int surahId,
    required int ayahNumber,
    required String textUthmani,
    this.textUthmaniTajweed = const Value.absent(),
    required int juzNumber,
    required int hizbQuarter,
    required int pageNumber,
  }) : surahId = Value(surahId),
       ayahNumber = Value(ayahNumber),
       textUthmani = Value(textUthmani),
       juzNumber = Value(juzNumber),
       hizbQuarter = Value(hizbQuarter),
       pageNumber = Value(pageNumber);
  static Insertable<Ayah> custom({
    Expression<int>? id,
    Expression<int>? surahId,
    Expression<int>? ayahNumber,
    Expression<String>? textUthmani,
    Expression<String>? textUthmaniTajweed,
    Expression<int>? juzNumber,
    Expression<int>? hizbQuarter,
    Expression<int>? pageNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahId != null) 'surah_id': surahId,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (textUthmani != null) 'text_uthmani': textUthmani,
      if (textUthmaniTajweed != null)
        'text_uthmani_tajweed': textUthmaniTajweed,
      if (juzNumber != null) 'juz_number': juzNumber,
      if (hizbQuarter != null) 'hizb_quarter': hizbQuarter,
      if (pageNumber != null) 'page_number': pageNumber,
    });
  }

  AyahsCompanion copyWith({
    Value<int>? id,
    Value<int>? surahId,
    Value<int>? ayahNumber,
    Value<String>? textUthmani,
    Value<String?>? textUthmaniTajweed,
    Value<int>? juzNumber,
    Value<int>? hizbQuarter,
    Value<int>? pageNumber,
  }) {
    return AyahsCompanion(
      id: id ?? this.id,
      surahId: surahId ?? this.surahId,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      textUthmani: textUthmani ?? this.textUthmani,
      textUthmaniTajweed: textUthmaniTajweed ?? this.textUthmaniTajweed,
      juzNumber: juzNumber ?? this.juzNumber,
      hizbQuarter: hizbQuarter ?? this.hizbQuarter,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahId.present) {
      map['surah_id'] = Variable<int>(surahId.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (textUthmani.present) {
      map['text_uthmani'] = Variable<String>(textUthmani.value);
    }
    if (textUthmaniTajweed.present) {
      map['text_uthmani_tajweed'] = Variable<String>(textUthmaniTajweed.value);
    }
    if (juzNumber.present) {
      map['juz_number'] = Variable<int>(juzNumber.value);
    }
    if (hizbQuarter.present) {
      map['hizb_quarter'] = Variable<int>(hizbQuarter.value);
    }
    if (pageNumber.present) {
      map['page_number'] = Variable<int>(pageNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AyahsCompanion(')
          ..write('id: $id, ')
          ..write('surahId: $surahId, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('textUthmani: $textUthmani, ')
          ..write('textUthmaniTajweed: $textUthmaniTajweed, ')
          ..write('juzNumber: $juzNumber, ')
          ..write('hizbQuarter: $hizbQuarter, ')
          ..write('pageNumber: $pageNumber')
          ..write(')'))
        .toString();
  }
}

class $AyahTranslationsTable extends AyahTranslations
    with TableInfo<$AyahTranslationsTable, AyahTranslation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AyahTranslationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _surahIdMeta = const VerificationMeta(
    'surahId',
  );
  @override
  late final GeneratedColumn<int> surahId = GeneratedColumn<int>(
    'surah_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES surahs (id)',
    ),
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  static const VerificationMeta _translatorNameMeta = const VerificationMeta(
    'translatorName',
  );
  @override
  late final GeneratedColumn<String> translatorName = GeneratedColumn<String>(
    'translator_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resourceIdMeta = const VerificationMeta(
    'resourceId',
  );
  @override
  late final GeneratedColumn<int> resourceId = GeneratedColumn<int>(
    'resource_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    surahId,
    ayahNumber,
    translationText,
    languageCode,
    translatorName,
    resourceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ayah_translations';
  @override
  VerificationContext validateIntegrity(
    Insertable<AyahTranslation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_id')) {
      context.handle(
        _surahIdMeta,
        surahId.isAcceptableOrUnknown(data['surah_id']!, _surahIdMeta),
      );
    } else if (isInserting) {
      context.missing(_surahIdMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
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
    if (data.containsKey('translator_name')) {
      context.handle(
        _translatorNameMeta,
        translatorName.isAcceptableOrUnknown(
          data['translator_name']!,
          _translatorNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translatorNameMeta);
    }
    if (data.containsKey('resource_id')) {
      context.handle(
        _resourceIdMeta,
        resourceId.isAcceptableOrUnknown(data['resource_id']!, _resourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_resourceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AyahTranslation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AyahTranslation(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      surahId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}surah_id'],
          )!,
      ayahNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}ayah_number'],
          )!,
      translationText:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}translation_text'],
          )!,
      languageCode:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}language_code'],
          )!,
      translatorName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}translator_name'],
          )!,
      resourceId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}resource_id'],
          )!,
    );
  }

  @override
  $AyahTranslationsTable createAlias(String alias) {
    return $AyahTranslationsTable(attachedDatabase, alias);
  }
}

class AyahTranslation extends DataClass implements Insertable<AyahTranslation> {
  final int id;
  final int surahId;
  final int ayahNumber;
  final String translationText;
  final String languageCode;
  final String translatorName;
  final int resourceId;
  const AyahTranslation({
    required this.id,
    required this.surahId,
    required this.ayahNumber,
    required this.translationText,
    required this.languageCode,
    required this.translatorName,
    required this.resourceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_id'] = Variable<int>(surahId);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['translation_text'] = Variable<String>(translationText);
    map['language_code'] = Variable<String>(languageCode);
    map['translator_name'] = Variable<String>(translatorName);
    map['resource_id'] = Variable<int>(resourceId);
    return map;
  }

  AyahTranslationsCompanion toCompanion(bool nullToAbsent) {
    return AyahTranslationsCompanion(
      id: Value(id),
      surahId: Value(surahId),
      ayahNumber: Value(ayahNumber),
      translationText: Value(translationText),
      languageCode: Value(languageCode),
      translatorName: Value(translatorName),
      resourceId: Value(resourceId),
    );
  }

  factory AyahTranslation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AyahTranslation(
      id: serializer.fromJson<int>(json['id']),
      surahId: serializer.fromJson<int>(json['surahId']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      translationText: serializer.fromJson<String>(json['translationText']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      translatorName: serializer.fromJson<String>(json['translatorName']),
      resourceId: serializer.fromJson<int>(json['resourceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahId': serializer.toJson<int>(surahId),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'translationText': serializer.toJson<String>(translationText),
      'languageCode': serializer.toJson<String>(languageCode),
      'translatorName': serializer.toJson<String>(translatorName),
      'resourceId': serializer.toJson<int>(resourceId),
    };
  }

  AyahTranslation copyWith({
    int? id,
    int? surahId,
    int? ayahNumber,
    String? translationText,
    String? languageCode,
    String? translatorName,
    int? resourceId,
  }) => AyahTranslation(
    id: id ?? this.id,
    surahId: surahId ?? this.surahId,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    translationText: translationText ?? this.translationText,
    languageCode: languageCode ?? this.languageCode,
    translatorName: translatorName ?? this.translatorName,
    resourceId: resourceId ?? this.resourceId,
  );
  AyahTranslation copyWithCompanion(AyahTranslationsCompanion data) {
    return AyahTranslation(
      id: data.id.present ? data.id.value : this.id,
      surahId: data.surahId.present ? data.surahId.value : this.surahId,
      ayahNumber:
          data.ayahNumber.present ? data.ayahNumber.value : this.ayahNumber,
      translationText:
          data.translationText.present
              ? data.translationText.value
              : this.translationText,
      languageCode:
          data.languageCode.present
              ? data.languageCode.value
              : this.languageCode,
      translatorName:
          data.translatorName.present
              ? data.translatorName.value
              : this.translatorName,
      resourceId:
          data.resourceId.present ? data.resourceId.value : this.resourceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AyahTranslation(')
          ..write('id: $id, ')
          ..write('surahId: $surahId, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('translationText: $translationText, ')
          ..write('languageCode: $languageCode, ')
          ..write('translatorName: $translatorName, ')
          ..write('resourceId: $resourceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    surahId,
    ayahNumber,
    translationText,
    languageCode,
    translatorName,
    resourceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AyahTranslation &&
          other.id == this.id &&
          other.surahId == this.surahId &&
          other.ayahNumber == this.ayahNumber &&
          other.translationText == this.translationText &&
          other.languageCode == this.languageCode &&
          other.translatorName == this.translatorName &&
          other.resourceId == this.resourceId);
}

class AyahTranslationsCompanion extends UpdateCompanion<AyahTranslation> {
  final Value<int> id;
  final Value<int> surahId;
  final Value<int> ayahNumber;
  final Value<String> translationText;
  final Value<String> languageCode;
  final Value<String> translatorName;
  final Value<int> resourceId;
  const AyahTranslationsCompanion({
    this.id = const Value.absent(),
    this.surahId = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.translationText = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.translatorName = const Value.absent(),
    this.resourceId = const Value.absent(),
  });
  AyahTranslationsCompanion.insert({
    this.id = const Value.absent(),
    required int surahId,
    required int ayahNumber,
    required String translationText,
    required String languageCode,
    required String translatorName,
    required int resourceId,
  }) : surahId = Value(surahId),
       ayahNumber = Value(ayahNumber),
       translationText = Value(translationText),
       languageCode = Value(languageCode),
       translatorName = Value(translatorName),
       resourceId = Value(resourceId);
  static Insertable<AyahTranslation> custom({
    Expression<int>? id,
    Expression<int>? surahId,
    Expression<int>? ayahNumber,
    Expression<String>? translationText,
    Expression<String>? languageCode,
    Expression<String>? translatorName,
    Expression<int>? resourceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahId != null) 'surah_id': surahId,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (translationText != null) 'translation_text': translationText,
      if (languageCode != null) 'language_code': languageCode,
      if (translatorName != null) 'translator_name': translatorName,
      if (resourceId != null) 'resource_id': resourceId,
    });
  }

  AyahTranslationsCompanion copyWith({
    Value<int>? id,
    Value<int>? surahId,
    Value<int>? ayahNumber,
    Value<String>? translationText,
    Value<String>? languageCode,
    Value<String>? translatorName,
    Value<int>? resourceId,
  }) {
    return AyahTranslationsCompanion(
      id: id ?? this.id,
      surahId: surahId ?? this.surahId,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      translationText: translationText ?? this.translationText,
      languageCode: languageCode ?? this.languageCode,
      translatorName: translatorName ?? this.translatorName,
      resourceId: resourceId ?? this.resourceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahId.present) {
      map['surah_id'] = Variable<int>(surahId.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (translationText.present) {
      map['translation_text'] = Variable<String>(translationText.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (translatorName.present) {
      map['translator_name'] = Variable<String>(translatorName.value);
    }
    if (resourceId.present) {
      map['resource_id'] = Variable<int>(resourceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AyahTranslationsCompanion(')
          ..write('id: $id, ')
          ..write('surahId: $surahId, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('translationText: $translationText, ')
          ..write('languageCode: $languageCode, ')
          ..write('translatorName: $translatorName, ')
          ..write('resourceId: $resourceId')
          ..write(')'))
        .toString();
  }
}

class $RecitersTable extends Reciters with TableInfo<$RecitersTable, Reciter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecitersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
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
  static const VerificationMeta _styleMeta = const VerificationMeta('style');
  @override
  late final GeneratedColumn<String> style = GeneratedColumn<String>(
    'style',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('murattal'),
  );
  static const VerificationMeta _serverUrlMeta = const VerificationMeta(
    'serverUrl',
  );
  @override
  late final GeneratedColumn<String> serverUrl = GeneratedColumn<String>(
    'server_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameArabic,
    nameEnglish,
    style,
    serverUrl,
    photoUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reciters';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reciter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    if (data.containsKey('style')) {
      context.handle(
        _styleMeta,
        style.isAcceptableOrUnknown(data['style']!, _styleMeta),
      );
    }
    if (data.containsKey('server_url')) {
      context.handle(
        _serverUrlMeta,
        serverUrl.isAcceptableOrUnknown(data['server_url']!, _serverUrlMeta),
      );
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reciter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reciter(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      nameArabic:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name_arabic'],
          )!,
      nameEnglish:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name_english'],
          )!,
      style:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}style'],
          )!,
      serverUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_url'],
      ),
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
    );
  }

  @override
  $RecitersTable createAlias(String alias) {
    return $RecitersTable(attachedDatabase, alias);
  }
}

class Reciter extends DataClass implements Insertable<Reciter> {
  final int id;
  final String nameArabic;
  final String nameEnglish;
  final String style;
  final String? serverUrl;
  final String? photoUrl;
  const Reciter({
    required this.id,
    required this.nameArabic,
    required this.nameEnglish,
    required this.style,
    this.serverUrl,
    this.photoUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_arabic'] = Variable<String>(nameArabic);
    map['name_english'] = Variable<String>(nameEnglish);
    map['style'] = Variable<String>(style);
    if (!nullToAbsent || serverUrl != null) {
      map['server_url'] = Variable<String>(serverUrl);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    return map;
  }

  RecitersCompanion toCompanion(bool nullToAbsent) {
    return RecitersCompanion(
      id: Value(id),
      nameArabic: Value(nameArabic),
      nameEnglish: Value(nameEnglish),
      style: Value(style),
      serverUrl:
          serverUrl == null && nullToAbsent
              ? const Value.absent()
              : Value(serverUrl),
      photoUrl:
          photoUrl == null && nullToAbsent
              ? const Value.absent()
              : Value(photoUrl),
    );
  }

  factory Reciter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reciter(
      id: serializer.fromJson<int>(json['id']),
      nameArabic: serializer.fromJson<String>(json['nameArabic']),
      nameEnglish: serializer.fromJson<String>(json['nameEnglish']),
      style: serializer.fromJson<String>(json['style']),
      serverUrl: serializer.fromJson<String?>(json['serverUrl']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameArabic': serializer.toJson<String>(nameArabic),
      'nameEnglish': serializer.toJson<String>(nameEnglish),
      'style': serializer.toJson<String>(style),
      'serverUrl': serializer.toJson<String?>(serverUrl),
      'photoUrl': serializer.toJson<String?>(photoUrl),
    };
  }

  Reciter copyWith({
    int? id,
    String? nameArabic,
    String? nameEnglish,
    String? style,
    Value<String?> serverUrl = const Value.absent(),
    Value<String?> photoUrl = const Value.absent(),
  }) => Reciter(
    id: id ?? this.id,
    nameArabic: nameArabic ?? this.nameArabic,
    nameEnglish: nameEnglish ?? this.nameEnglish,
    style: style ?? this.style,
    serverUrl: serverUrl.present ? serverUrl.value : this.serverUrl,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
  );
  Reciter copyWithCompanion(RecitersCompanion data) {
    return Reciter(
      id: data.id.present ? data.id.value : this.id,
      nameArabic:
          data.nameArabic.present ? data.nameArabic.value : this.nameArabic,
      nameEnglish:
          data.nameEnglish.present ? data.nameEnglish.value : this.nameEnglish,
      style: data.style.present ? data.style.value : this.style,
      serverUrl: data.serverUrl.present ? data.serverUrl.value : this.serverUrl,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reciter(')
          ..write('id: $id, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('nameEnglish: $nameEnglish, ')
          ..write('style: $style, ')
          ..write('serverUrl: $serverUrl, ')
          ..write('photoUrl: $photoUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nameArabic, nameEnglish, style, serverUrl, photoUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reciter &&
          other.id == this.id &&
          other.nameArabic == this.nameArabic &&
          other.nameEnglish == this.nameEnglish &&
          other.style == this.style &&
          other.serverUrl == this.serverUrl &&
          other.photoUrl == this.photoUrl);
}

class RecitersCompanion extends UpdateCompanion<Reciter> {
  final Value<int> id;
  final Value<String> nameArabic;
  final Value<String> nameEnglish;
  final Value<String> style;
  final Value<String?> serverUrl;
  final Value<String?> photoUrl;
  const RecitersCompanion({
    this.id = const Value.absent(),
    this.nameArabic = const Value.absent(),
    this.nameEnglish = const Value.absent(),
    this.style = const Value.absent(),
    this.serverUrl = const Value.absent(),
    this.photoUrl = const Value.absent(),
  });
  RecitersCompanion.insert({
    this.id = const Value.absent(),
    required String nameArabic,
    required String nameEnglish,
    this.style = const Value.absent(),
    this.serverUrl = const Value.absent(),
    this.photoUrl = const Value.absent(),
  }) : nameArabic = Value(nameArabic),
       nameEnglish = Value(nameEnglish);
  static Insertable<Reciter> custom({
    Expression<int>? id,
    Expression<String>? nameArabic,
    Expression<String>? nameEnglish,
    Expression<String>? style,
    Expression<String>? serverUrl,
    Expression<String>? photoUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameArabic != null) 'name_arabic': nameArabic,
      if (nameEnglish != null) 'name_english': nameEnglish,
      if (style != null) 'style': style,
      if (serverUrl != null) 'server_url': serverUrl,
      if (photoUrl != null) 'photo_url': photoUrl,
    });
  }

  RecitersCompanion copyWith({
    Value<int>? id,
    Value<String>? nameArabic,
    Value<String>? nameEnglish,
    Value<String>? style,
    Value<String?>? serverUrl,
    Value<String?>? photoUrl,
  }) {
    return RecitersCompanion(
      id: id ?? this.id,
      nameArabic: nameArabic ?? this.nameArabic,
      nameEnglish: nameEnglish ?? this.nameEnglish,
      style: style ?? this.style,
      serverUrl: serverUrl ?? this.serverUrl,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameArabic.present) {
      map['name_arabic'] = Variable<String>(nameArabic.value);
    }
    if (nameEnglish.present) {
      map['name_english'] = Variable<String>(nameEnglish.value);
    }
    if (style.present) {
      map['style'] = Variable<String>(style.value);
    }
    if (serverUrl.present) {
      map['server_url'] = Variable<String>(serverUrl.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecitersCompanion(')
          ..write('id: $id, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('nameEnglish: $nameEnglish, ')
          ..write('style: $style, ')
          ..write('serverUrl: $serverUrl, ')
          ..write('photoUrl: $photoUrl')
          ..write(')'))
        .toString();
  }
}

class $DownloadedAudioTable extends DownloadedAudio
    with TableInfo<$DownloadedAudioTable, DownloadedAudioData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DownloadedAudioTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _reciterIdMeta = const VerificationMeta(
    'reciterId',
  );
  @override
  late final GeneratedColumn<int> reciterId = GeneratedColumn<int>(
    'reciter_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES reciters (id)',
    ),
  );
  static const VerificationMeta _surahIdMeta = const VerificationMeta(
    'surahId',
  );
  @override
  late final GeneratedColumn<int> surahId = GeneratedColumn<int>(
    'surah_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES surahs (id)',
    ),
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileSizeMeta = const VerificationMeta(
    'fileSize',
  );
  @override
  late final GeneratedColumn<int> fileSize = GeneratedColumn<int>(
    'file_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _downloadedAtMeta = const VerificationMeta(
    'downloadedAt',
  );
  @override
  late final GeneratedColumn<DateTime> downloadedAt = GeneratedColumn<DateTime>(
    'downloaded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    reciterId,
    surahId,
    filePath,
    fileSize,
    downloadedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'downloaded_audio';
  @override
  VerificationContext validateIntegrity(
    Insertable<DownloadedAudioData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('reciter_id')) {
      context.handle(
        _reciterIdMeta,
        reciterId.isAcceptableOrUnknown(data['reciter_id']!, _reciterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_reciterIdMeta);
    }
    if (data.containsKey('surah_id')) {
      context.handle(
        _surahIdMeta,
        surahId.isAcceptableOrUnknown(data['surah_id']!, _surahIdMeta),
      );
    } else if (isInserting) {
      context.missing(_surahIdMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('file_size')) {
      context.handle(
        _fileSizeMeta,
        fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_fileSizeMeta);
    }
    if (data.containsKey('downloaded_at')) {
      context.handle(
        _downloadedAtMeta,
        downloadedAt.isAcceptableOrUnknown(
          data['downloaded_at']!,
          _downloadedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_downloadedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DownloadedAudioData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DownloadedAudioData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      reciterId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}reciter_id'],
          )!,
      surahId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}surah_id'],
          )!,
      filePath:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}file_path'],
          )!,
      fileSize:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}file_size'],
          )!,
      downloadedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}downloaded_at'],
          )!,
    );
  }

  @override
  $DownloadedAudioTable createAlias(String alias) {
    return $DownloadedAudioTable(attachedDatabase, alias);
  }
}

class DownloadedAudioData extends DataClass
    implements Insertable<DownloadedAudioData> {
  final int id;
  final int reciterId;
  final int surahId;
  final String filePath;
  final int fileSize;
  final DateTime downloadedAt;
  const DownloadedAudioData({
    required this.id,
    required this.reciterId,
    required this.surahId,
    required this.filePath,
    required this.fileSize,
    required this.downloadedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['reciter_id'] = Variable<int>(reciterId);
    map['surah_id'] = Variable<int>(surahId);
    map['file_path'] = Variable<String>(filePath);
    map['file_size'] = Variable<int>(fileSize);
    map['downloaded_at'] = Variable<DateTime>(downloadedAt);
    return map;
  }

  DownloadedAudioCompanion toCompanion(bool nullToAbsent) {
    return DownloadedAudioCompanion(
      id: Value(id),
      reciterId: Value(reciterId),
      surahId: Value(surahId),
      filePath: Value(filePath),
      fileSize: Value(fileSize),
      downloadedAt: Value(downloadedAt),
    );
  }

  factory DownloadedAudioData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DownloadedAudioData(
      id: serializer.fromJson<int>(json['id']),
      reciterId: serializer.fromJson<int>(json['reciterId']),
      surahId: serializer.fromJson<int>(json['surahId']),
      filePath: serializer.fromJson<String>(json['filePath']),
      fileSize: serializer.fromJson<int>(json['fileSize']),
      downloadedAt: serializer.fromJson<DateTime>(json['downloadedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reciterId': serializer.toJson<int>(reciterId),
      'surahId': serializer.toJson<int>(surahId),
      'filePath': serializer.toJson<String>(filePath),
      'fileSize': serializer.toJson<int>(fileSize),
      'downloadedAt': serializer.toJson<DateTime>(downloadedAt),
    };
  }

  DownloadedAudioData copyWith({
    int? id,
    int? reciterId,
    int? surahId,
    String? filePath,
    int? fileSize,
    DateTime? downloadedAt,
  }) => DownloadedAudioData(
    id: id ?? this.id,
    reciterId: reciterId ?? this.reciterId,
    surahId: surahId ?? this.surahId,
    filePath: filePath ?? this.filePath,
    fileSize: fileSize ?? this.fileSize,
    downloadedAt: downloadedAt ?? this.downloadedAt,
  );
  DownloadedAudioData copyWithCompanion(DownloadedAudioCompanion data) {
    return DownloadedAudioData(
      id: data.id.present ? data.id.value : this.id,
      reciterId: data.reciterId.present ? data.reciterId.value : this.reciterId,
      surahId: data.surahId.present ? data.surahId.value : this.surahId,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
      downloadedAt:
          data.downloadedAt.present
              ? data.downloadedAt.value
              : this.downloadedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DownloadedAudioData(')
          ..write('id: $id, ')
          ..write('reciterId: $reciterId, ')
          ..write('surahId: $surahId, ')
          ..write('filePath: $filePath, ')
          ..write('fileSize: $fileSize, ')
          ..write('downloadedAt: $downloadedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, reciterId, surahId, filePath, fileSize, downloadedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DownloadedAudioData &&
          other.id == this.id &&
          other.reciterId == this.reciterId &&
          other.surahId == this.surahId &&
          other.filePath == this.filePath &&
          other.fileSize == this.fileSize &&
          other.downloadedAt == this.downloadedAt);
}

class DownloadedAudioCompanion extends UpdateCompanion<DownloadedAudioData> {
  final Value<int> id;
  final Value<int> reciterId;
  final Value<int> surahId;
  final Value<String> filePath;
  final Value<int> fileSize;
  final Value<DateTime> downloadedAt;
  const DownloadedAudioCompanion({
    this.id = const Value.absent(),
    this.reciterId = const Value.absent(),
    this.surahId = const Value.absent(),
    this.filePath = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.downloadedAt = const Value.absent(),
  });
  DownloadedAudioCompanion.insert({
    this.id = const Value.absent(),
    required int reciterId,
    required int surahId,
    required String filePath,
    required int fileSize,
    required DateTime downloadedAt,
  }) : reciterId = Value(reciterId),
       surahId = Value(surahId),
       filePath = Value(filePath),
       fileSize = Value(fileSize),
       downloadedAt = Value(downloadedAt);
  static Insertable<DownloadedAudioData> custom({
    Expression<int>? id,
    Expression<int>? reciterId,
    Expression<int>? surahId,
    Expression<String>? filePath,
    Expression<int>? fileSize,
    Expression<DateTime>? downloadedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reciterId != null) 'reciter_id': reciterId,
      if (surahId != null) 'surah_id': surahId,
      if (filePath != null) 'file_path': filePath,
      if (fileSize != null) 'file_size': fileSize,
      if (downloadedAt != null) 'downloaded_at': downloadedAt,
    });
  }

  DownloadedAudioCompanion copyWith({
    Value<int>? id,
    Value<int>? reciterId,
    Value<int>? surahId,
    Value<String>? filePath,
    Value<int>? fileSize,
    Value<DateTime>? downloadedAt,
  }) {
    return DownloadedAudioCompanion(
      id: id ?? this.id,
      reciterId: reciterId ?? this.reciterId,
      surahId: surahId ?? this.surahId,
      filePath: filePath ?? this.filePath,
      fileSize: fileSize ?? this.fileSize,
      downloadedAt: downloadedAt ?? this.downloadedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reciterId.present) {
      map['reciter_id'] = Variable<int>(reciterId.value);
    }
    if (surahId.present) {
      map['surah_id'] = Variable<int>(surahId.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
    }
    if (downloadedAt.present) {
      map['downloaded_at'] = Variable<DateTime>(downloadedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DownloadedAudioCompanion(')
          ..write('id: $id, ')
          ..write('reciterId: $reciterId, ')
          ..write('surahId: $surahId, ')
          ..write('filePath: $filePath, ')
          ..write('fileSize: $fileSize, ')
          ..write('downloadedAt: $downloadedAt')
          ..write(')'))
        .toString();
  }
}

class $UserNotesTable extends UserNotes
    with TableInfo<$UserNotesTable, UserNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserNotesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _surahIdMeta = const VerificationMeta(
    'surahId',
  );
  @override
  late final GeneratedColumn<int> surahId = GeneratedColumn<int>(
    'surah_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES surahs (id)',
    ),
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    surahId,
    ayahNumber,
    content,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserNote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_id')) {
      context.handle(
        _surahIdMeta,
        surahId.isAcceptableOrUnknown(data['surah_id']!, _surahIdMeta),
      );
    } else if (isInserting) {
      context.missing(_surahIdMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserNote(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      surahId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}surah_id'],
          )!,
      ayahNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}ayah_number'],
          )!,
      content:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}content'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $UserNotesTable createAlias(String alias) {
    return $UserNotesTable(attachedDatabase, alias);
  }
}

class UserNote extends DataClass implements Insertable<UserNote> {
  final int id;
  final int surahId;
  final int ayahNumber;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserNote({
    required this.id,
    required this.surahId,
    required this.ayahNumber,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_id'] = Variable<int>(surahId);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserNotesCompanion toCompanion(bool nullToAbsent) {
    return UserNotesCompanion(
      id: Value(id),
      surahId: Value(surahId),
      ayahNumber: Value(ayahNumber),
      content: Value(content),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserNote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserNote(
      id: serializer.fromJson<int>(json['id']),
      surahId: serializer.fromJson<int>(json['surahId']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahId': serializer.toJson<int>(surahId),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserNote copyWith({
    int? id,
    int? surahId,
    int? ayahNumber,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserNote(
    id: id ?? this.id,
    surahId: surahId ?? this.surahId,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserNote copyWithCompanion(UserNotesCompanion data) {
    return UserNote(
      id: data.id.present ? data.id.value : this.id,
      surahId: data.surahId.present ? data.surahId.value : this.surahId,
      ayahNumber:
          data.ayahNumber.present ? data.ayahNumber.value : this.ayahNumber,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserNote(')
          ..write('id: $id, ')
          ..write('surahId: $surahId, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, surahId, ayahNumber, content, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserNote &&
          other.id == this.id &&
          other.surahId == this.surahId &&
          other.ayahNumber == this.ayahNumber &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserNotesCompanion extends UpdateCompanion<UserNote> {
  final Value<int> id;
  final Value<int> surahId;
  final Value<int> ayahNumber;
  final Value<String> content;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserNotesCompanion({
    this.id = const Value.absent(),
    this.surahId = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserNotesCompanion.insert({
    this.id = const Value.absent(),
    required int surahId,
    required int ayahNumber,
    required String content,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : surahId = Value(surahId),
       ayahNumber = Value(ayahNumber),
       content = Value(content),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserNote> custom({
    Expression<int>? id,
    Expression<int>? surahId,
    Expression<int>? ayahNumber,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahId != null) 'surah_id': surahId,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserNotesCompanion copyWith({
    Value<int>? id,
    Value<int>? surahId,
    Value<int>? ayahNumber,
    Value<String>? content,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserNotesCompanion(
      id: id ?? this.id,
      surahId: surahId ?? this.surahId,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahId.present) {
      map['surah_id'] = Variable<int>(surahId.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserNotesCompanion(')
          ..write('id: $id, ')
          ..write('surahId: $surahId, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ReadingProgressTable extends ReadingProgress
    with TableInfo<$ReadingProgressTable, ReadingProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingProgressTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _surahIdMeta = const VerificationMeta(
    'surahId',
  );
  @override
  late final GeneratedColumn<int> surahId = GeneratedColumn<int>(
    'surah_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES surahs (id)',
    ),
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pageNumberMeta = const VerificationMeta(
    'pageNumber',
  );
  @override
  late final GeneratedColumn<int> pageNumber = GeneratedColumn<int>(
    'page_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastReadAtMeta = const VerificationMeta(
    'lastReadAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastReadAt = GeneratedColumn<DateTime>(
    'last_read_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    surahId,
    ayahNumber,
    pageNumber,
    lastReadAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadingProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_id')) {
      context.handle(
        _surahIdMeta,
        surahId.isAcceptableOrUnknown(data['surah_id']!, _surahIdMeta),
      );
    } else if (isInserting) {
      context.missing(_surahIdMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('page_number')) {
      context.handle(
        _pageNumberMeta,
        pageNumber.isAcceptableOrUnknown(data['page_number']!, _pageNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_pageNumberMeta);
    }
    if (data.containsKey('last_read_at')) {
      context.handle(
        _lastReadAtMeta,
        lastReadAt.isAcceptableOrUnknown(
          data['last_read_at']!,
          _lastReadAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastReadAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReadingProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingProgressData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      surahId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}surah_id'],
          )!,
      ayahNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}ayah_number'],
          )!,
      pageNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}page_number'],
          )!,
      lastReadAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}last_read_at'],
          )!,
    );
  }

  @override
  $ReadingProgressTable createAlias(String alias) {
    return $ReadingProgressTable(attachedDatabase, alias);
  }
}

class ReadingProgressData extends DataClass
    implements Insertable<ReadingProgressData> {
  final int id;
  final int surahId;
  final int ayahNumber;
  final int pageNumber;
  final DateTime lastReadAt;
  const ReadingProgressData({
    required this.id,
    required this.surahId,
    required this.ayahNumber,
    required this.pageNumber,
    required this.lastReadAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_id'] = Variable<int>(surahId);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['page_number'] = Variable<int>(pageNumber);
    map['last_read_at'] = Variable<DateTime>(lastReadAt);
    return map;
  }

  ReadingProgressCompanion toCompanion(bool nullToAbsent) {
    return ReadingProgressCompanion(
      id: Value(id),
      surahId: Value(surahId),
      ayahNumber: Value(ayahNumber),
      pageNumber: Value(pageNumber),
      lastReadAt: Value(lastReadAt),
    );
  }

  factory ReadingProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingProgressData(
      id: serializer.fromJson<int>(json['id']),
      surahId: serializer.fromJson<int>(json['surahId']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      pageNumber: serializer.fromJson<int>(json['pageNumber']),
      lastReadAt: serializer.fromJson<DateTime>(json['lastReadAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahId': serializer.toJson<int>(surahId),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'pageNumber': serializer.toJson<int>(pageNumber),
      'lastReadAt': serializer.toJson<DateTime>(lastReadAt),
    };
  }

  ReadingProgressData copyWith({
    int? id,
    int? surahId,
    int? ayahNumber,
    int? pageNumber,
    DateTime? lastReadAt,
  }) => ReadingProgressData(
    id: id ?? this.id,
    surahId: surahId ?? this.surahId,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    pageNumber: pageNumber ?? this.pageNumber,
    lastReadAt: lastReadAt ?? this.lastReadAt,
  );
  ReadingProgressData copyWithCompanion(ReadingProgressCompanion data) {
    return ReadingProgressData(
      id: data.id.present ? data.id.value : this.id,
      surahId: data.surahId.present ? data.surahId.value : this.surahId,
      ayahNumber:
          data.ayahNumber.present ? data.ayahNumber.value : this.ayahNumber,
      pageNumber:
          data.pageNumber.present ? data.pageNumber.value : this.pageNumber,
      lastReadAt:
          data.lastReadAt.present ? data.lastReadAt.value : this.lastReadAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingProgressData(')
          ..write('id: $id, ')
          ..write('surahId: $surahId, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('lastReadAt: $lastReadAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, surahId, ayahNumber, pageNumber, lastReadAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingProgressData &&
          other.id == this.id &&
          other.surahId == this.surahId &&
          other.ayahNumber == this.ayahNumber &&
          other.pageNumber == this.pageNumber &&
          other.lastReadAt == this.lastReadAt);
}

class ReadingProgressCompanion extends UpdateCompanion<ReadingProgressData> {
  final Value<int> id;
  final Value<int> surahId;
  final Value<int> ayahNumber;
  final Value<int> pageNumber;
  final Value<DateTime> lastReadAt;
  const ReadingProgressCompanion({
    this.id = const Value.absent(),
    this.surahId = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.pageNumber = const Value.absent(),
    this.lastReadAt = const Value.absent(),
  });
  ReadingProgressCompanion.insert({
    this.id = const Value.absent(),
    required int surahId,
    required int ayahNumber,
    required int pageNumber,
    required DateTime lastReadAt,
  }) : surahId = Value(surahId),
       ayahNumber = Value(ayahNumber),
       pageNumber = Value(pageNumber),
       lastReadAt = Value(lastReadAt);
  static Insertable<ReadingProgressData> custom({
    Expression<int>? id,
    Expression<int>? surahId,
    Expression<int>? ayahNumber,
    Expression<int>? pageNumber,
    Expression<DateTime>? lastReadAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahId != null) 'surah_id': surahId,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (pageNumber != null) 'page_number': pageNumber,
      if (lastReadAt != null) 'last_read_at': lastReadAt,
    });
  }

  ReadingProgressCompanion copyWith({
    Value<int>? id,
    Value<int>? surahId,
    Value<int>? ayahNumber,
    Value<int>? pageNumber,
    Value<DateTime>? lastReadAt,
  }) {
    return ReadingProgressCompanion(
      id: id ?? this.id,
      surahId: surahId ?? this.surahId,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      pageNumber: pageNumber ?? this.pageNumber,
      lastReadAt: lastReadAt ?? this.lastReadAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahId.present) {
      map['surah_id'] = Variable<int>(surahId.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (pageNumber.present) {
      map['page_number'] = Variable<int>(pageNumber.value);
    }
    if (lastReadAt.present) {
      map['last_read_at'] = Variable<DateTime>(lastReadAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingProgressCompanion(')
          ..write('id: $id, ')
          ..write('surahId: $surahId, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('lastReadAt: $lastReadAt')
          ..write(')'))
        .toString();
  }
}

class $LessonProgressTable extends LessonProgress
    with TableInfo<$LessonProgressTable, LessonProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LessonProgressTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _lessonIdMeta = const VerificationMeta(
    'lessonId',
  );
  @override
  late final GeneratedColumn<int> lessonId = GeneratedColumn<int>(
    'lesson_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _bestQuizScoreMeta = const VerificationMeta(
    'bestQuizScore',
  );
  @override
  late final GeneratedColumn<int> bestQuizScore = GeneratedColumn<int>(
    'best_quiz_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _attemptCountMeta = const VerificationMeta(
    'attemptCount',
  );
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
    'attempt_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lessonId,
    isCompleted,
    bestQuizScore,
    attemptCount,
    completedAt,
    lastAttemptAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lesson_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<LessonProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lesson_id')) {
      context.handle(
        _lessonIdMeta,
        lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('best_quiz_score')) {
      context.handle(
        _bestQuizScoreMeta,
        bestQuizScore.isAcceptableOrUnknown(
          data['best_quiz_score']!,
          _bestQuizScoreMeta,
        ),
      );
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
        _attemptCountMeta,
        attemptCount.isAcceptableOrUnknown(
          data['attempt_count']!,
          _attemptCountMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LessonProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LessonProgressData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      lessonId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}lesson_id'],
          )!,
      isCompleted:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_completed'],
          )!,
      bestQuizScore:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}best_quiz_score'],
          )!,
      attemptCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}attempt_count'],
          )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
    );
  }

  @override
  $LessonProgressTable createAlias(String alias) {
    return $LessonProgressTable(attachedDatabase, alias);
  }
}

class LessonProgressData extends DataClass
    implements Insertable<LessonProgressData> {
  final int id;
  final int lessonId;
  final bool isCompleted;
  final int bestQuizScore;
  final int attemptCount;
  final DateTime? completedAt;
  final DateTime? lastAttemptAt;
  const LessonProgressData({
    required this.id,
    required this.lessonId,
    required this.isCompleted,
    required this.bestQuizScore,
    required this.attemptCount,
    this.completedAt,
    this.lastAttemptAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lesson_id'] = Variable<int>(lessonId);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['best_quiz_score'] = Variable<int>(bestQuizScore);
    map['attempt_count'] = Variable<int>(attemptCount);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    return map;
  }

  LessonProgressCompanion toCompanion(bool nullToAbsent) {
    return LessonProgressCompanion(
      id: Value(id),
      lessonId: Value(lessonId),
      isCompleted: Value(isCompleted),
      bestQuizScore: Value(bestQuizScore),
      attemptCount: Value(attemptCount),
      completedAt:
          completedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(completedAt),
      lastAttemptAt:
          lastAttemptAt == null && nullToAbsent
              ? const Value.absent()
              : Value(lastAttemptAt),
    );
  }

  factory LessonProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LessonProgressData(
      id: serializer.fromJson<int>(json['id']),
      lessonId: serializer.fromJson<int>(json['lessonId']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      bestQuizScore: serializer.fromJson<int>(json['bestQuizScore']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lessonId': serializer.toJson<int>(lessonId),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'bestQuizScore': serializer.toJson<int>(bestQuizScore),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
    };
  }

  LessonProgressData copyWith({
    int? id,
    int? lessonId,
    bool? isCompleted,
    int? bestQuizScore,
    int? attemptCount,
    Value<DateTime?> completedAt = const Value.absent(),
    Value<DateTime?> lastAttemptAt = const Value.absent(),
  }) => LessonProgressData(
    id: id ?? this.id,
    lessonId: lessonId ?? this.lessonId,
    isCompleted: isCompleted ?? this.isCompleted,
    bestQuizScore: bestQuizScore ?? this.bestQuizScore,
    attemptCount: attemptCount ?? this.attemptCount,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    lastAttemptAt:
        lastAttemptAt.present ? lastAttemptAt.value : this.lastAttemptAt,
  );
  LessonProgressData copyWithCompanion(LessonProgressCompanion data) {
    return LessonProgressData(
      id: data.id.present ? data.id.value : this.id,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      bestQuizScore:
          data.bestQuizScore.present
              ? data.bestQuizScore.value
              : this.bestQuizScore,
      attemptCount:
          data.attemptCount.present
              ? data.attemptCount.value
              : this.attemptCount,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      lastAttemptAt:
          data.lastAttemptAt.present
              ? data.lastAttemptAt.value
              : this.lastAttemptAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LessonProgressData(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('bestQuizScore: $bestQuizScore, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('completedAt: $completedAt, ')
          ..write('lastAttemptAt: $lastAttemptAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    lessonId,
    isCompleted,
    bestQuizScore,
    attemptCount,
    completedAt,
    lastAttemptAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LessonProgressData &&
          other.id == this.id &&
          other.lessonId == this.lessonId &&
          other.isCompleted == this.isCompleted &&
          other.bestQuizScore == this.bestQuizScore &&
          other.attemptCount == this.attemptCount &&
          other.completedAt == this.completedAt &&
          other.lastAttemptAt == this.lastAttemptAt);
}

class LessonProgressCompanion extends UpdateCompanion<LessonProgressData> {
  final Value<int> id;
  final Value<int> lessonId;
  final Value<bool> isCompleted;
  final Value<int> bestQuizScore;
  final Value<int> attemptCount;
  final Value<DateTime?> completedAt;
  final Value<DateTime?> lastAttemptAt;
  const LessonProgressCompanion({
    this.id = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.bestQuizScore = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
  });
  LessonProgressCompanion.insert({
    this.id = const Value.absent(),
    required int lessonId,
    this.isCompleted = const Value.absent(),
    this.bestQuizScore = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
  }) : lessonId = Value(lessonId);
  static Insertable<LessonProgressData> custom({
    Expression<int>? id,
    Expression<int>? lessonId,
    Expression<bool>? isCompleted,
    Expression<int>? bestQuizScore,
    Expression<int>? attemptCount,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? lastAttemptAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lessonId != null) 'lesson_id': lessonId,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (bestQuizScore != null) 'best_quiz_score': bestQuizScore,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (completedAt != null) 'completed_at': completedAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
    });
  }

  LessonProgressCompanion copyWith({
    Value<int>? id,
    Value<int>? lessonId,
    Value<bool>? isCompleted,
    Value<int>? bestQuizScore,
    Value<int>? attemptCount,
    Value<DateTime?>? completedAt,
    Value<DateTime?>? lastAttemptAt,
  }) {
    return LessonProgressCompanion(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      isCompleted: isCompleted ?? this.isCompleted,
      bestQuizScore: bestQuizScore ?? this.bestQuizScore,
      attemptCount: attemptCount ?? this.attemptCount,
      completedAt: completedAt ?? this.completedAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<int>(lessonId.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (bestQuizScore.present) {
      map['best_quiz_score'] = Variable<int>(bestQuizScore.value);
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonProgressCompanion(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('bestQuizScore: $bestQuizScore, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('completedAt: $completedAt, ')
          ..write('lastAttemptAt: $lastAttemptAt')
          ..write(')'))
        .toString();
  }
}

class $UserStreaksTable extends UserStreaks
    with TableInfo<$UserStreaksTable, UserStreak> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserStreaksTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _currentStreakMeta = const VerificationMeta(
    'currentStreak',
  );
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
    'current_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _longestStreakMeta = const VerificationMeta(
    'longestStreak',
  );
  @override
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
    'longest_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastActivityDateMeta = const VerificationMeta(
    'lastActivityDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastActivityDate =
      GeneratedColumn<DateTime>(
        'last_activity_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _totalRecordingsMeta = const VerificationMeta(
    'totalRecordings',
  );
  @override
  late final GeneratedColumn<int> totalRecordings = GeneratedColumn<int>(
    'total_recordings',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalPracticeSecondsMeta =
      const VerificationMeta('totalPracticeSeconds');
  @override
  late final GeneratedColumn<int> totalPracticeSeconds = GeneratedColumn<int>(
    'total_practice_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    currentStreak,
    longestStreak,
    lastActivityDate,
    totalRecordings,
    totalPracticeSeconds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_streaks';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserStreak> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('current_streak')) {
      context.handle(
        _currentStreakMeta,
        currentStreak.isAcceptableOrUnknown(
          data['current_streak']!,
          _currentStreakMeta,
        ),
      );
    }
    if (data.containsKey('longest_streak')) {
      context.handle(
        _longestStreakMeta,
        longestStreak.isAcceptableOrUnknown(
          data['longest_streak']!,
          _longestStreakMeta,
        ),
      );
    }
    if (data.containsKey('last_activity_date')) {
      context.handle(
        _lastActivityDateMeta,
        lastActivityDate.isAcceptableOrUnknown(
          data['last_activity_date']!,
          _lastActivityDateMeta,
        ),
      );
    }
    if (data.containsKey('total_recordings')) {
      context.handle(
        _totalRecordingsMeta,
        totalRecordings.isAcceptableOrUnknown(
          data['total_recordings']!,
          _totalRecordingsMeta,
        ),
      );
    }
    if (data.containsKey('total_practice_seconds')) {
      context.handle(
        _totalPracticeSecondsMeta,
        totalPracticeSeconds.isAcceptableOrUnknown(
          data['total_practice_seconds']!,
          _totalPracticeSecondsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserStreak map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserStreak(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      currentStreak:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}current_streak'],
          )!,
      longestStreak:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}longest_streak'],
          )!,
      lastActivityDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_activity_date'],
      ),
      totalRecordings:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}total_recordings'],
          )!,
      totalPracticeSeconds:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}total_practice_seconds'],
          )!,
    );
  }

  @override
  $UserStreaksTable createAlias(String alias) {
    return $UserStreaksTable(attachedDatabase, alias);
  }
}

class UserStreak extends DataClass implements Insertable<UserStreak> {
  final int id;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastActivityDate;
  final int totalRecordings;
  final int totalPracticeSeconds;
  const UserStreak({
    required this.id,
    required this.currentStreak,
    required this.longestStreak,
    this.lastActivityDate,
    required this.totalRecordings,
    required this.totalPracticeSeconds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['current_streak'] = Variable<int>(currentStreak);
    map['longest_streak'] = Variable<int>(longestStreak);
    if (!nullToAbsent || lastActivityDate != null) {
      map['last_activity_date'] = Variable<DateTime>(lastActivityDate);
    }
    map['total_recordings'] = Variable<int>(totalRecordings);
    map['total_practice_seconds'] = Variable<int>(totalPracticeSeconds);
    return map;
  }

  UserStreaksCompanion toCompanion(bool nullToAbsent) {
    return UserStreaksCompanion(
      id: Value(id),
      currentStreak: Value(currentStreak),
      longestStreak: Value(longestStreak),
      lastActivityDate:
          lastActivityDate == null && nullToAbsent
              ? const Value.absent()
              : Value(lastActivityDate),
      totalRecordings: Value(totalRecordings),
      totalPracticeSeconds: Value(totalPracticeSeconds),
    );
  }

  factory UserStreak.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserStreak(
      id: serializer.fromJson<int>(json['id']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      lastActivityDate: serializer.fromJson<DateTime?>(
        json['lastActivityDate'],
      ),
      totalRecordings: serializer.fromJson<int>(json['totalRecordings']),
      totalPracticeSeconds: serializer.fromJson<int>(
        json['totalPracticeSeconds'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'lastActivityDate': serializer.toJson<DateTime?>(lastActivityDate),
      'totalRecordings': serializer.toJson<int>(totalRecordings),
      'totalPracticeSeconds': serializer.toJson<int>(totalPracticeSeconds),
    };
  }

  UserStreak copyWith({
    int? id,
    int? currentStreak,
    int? longestStreak,
    Value<DateTime?> lastActivityDate = const Value.absent(),
    int? totalRecordings,
    int? totalPracticeSeconds,
  }) => UserStreak(
    id: id ?? this.id,
    currentStreak: currentStreak ?? this.currentStreak,
    longestStreak: longestStreak ?? this.longestStreak,
    lastActivityDate:
        lastActivityDate.present
            ? lastActivityDate.value
            : this.lastActivityDate,
    totalRecordings: totalRecordings ?? this.totalRecordings,
    totalPracticeSeconds: totalPracticeSeconds ?? this.totalPracticeSeconds,
  );
  UserStreak copyWithCompanion(UserStreaksCompanion data) {
    return UserStreak(
      id: data.id.present ? data.id.value : this.id,
      currentStreak:
          data.currentStreak.present
              ? data.currentStreak.value
              : this.currentStreak,
      longestStreak:
          data.longestStreak.present
              ? data.longestStreak.value
              : this.longestStreak,
      lastActivityDate:
          data.lastActivityDate.present
              ? data.lastActivityDate.value
              : this.lastActivityDate,
      totalRecordings:
          data.totalRecordings.present
              ? data.totalRecordings.value
              : this.totalRecordings,
      totalPracticeSeconds:
          data.totalPracticeSeconds.present
              ? data.totalPracticeSeconds.value
              : this.totalPracticeSeconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserStreak(')
          ..write('id: $id, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('lastActivityDate: $lastActivityDate, ')
          ..write('totalRecordings: $totalRecordings, ')
          ..write('totalPracticeSeconds: $totalPracticeSeconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    currentStreak,
    longestStreak,
    lastActivityDate,
    totalRecordings,
    totalPracticeSeconds,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserStreak &&
          other.id == this.id &&
          other.currentStreak == this.currentStreak &&
          other.longestStreak == this.longestStreak &&
          other.lastActivityDate == this.lastActivityDate &&
          other.totalRecordings == this.totalRecordings &&
          other.totalPracticeSeconds == this.totalPracticeSeconds);
}

class UserStreaksCompanion extends UpdateCompanion<UserStreak> {
  final Value<int> id;
  final Value<int> currentStreak;
  final Value<int> longestStreak;
  final Value<DateTime?> lastActivityDate;
  final Value<int> totalRecordings;
  final Value<int> totalPracticeSeconds;
  const UserStreaksCompanion({
    this.id = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.lastActivityDate = const Value.absent(),
    this.totalRecordings = const Value.absent(),
    this.totalPracticeSeconds = const Value.absent(),
  });
  UserStreaksCompanion.insert({
    this.id = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.lastActivityDate = const Value.absent(),
    this.totalRecordings = const Value.absent(),
    this.totalPracticeSeconds = const Value.absent(),
  });
  static Insertable<UserStreak> custom({
    Expression<int>? id,
    Expression<int>? currentStreak,
    Expression<int>? longestStreak,
    Expression<DateTime>? lastActivityDate,
    Expression<int>? totalRecordings,
    Expression<int>? totalPracticeSeconds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (lastActivityDate != null) 'last_activity_date': lastActivityDate,
      if (totalRecordings != null) 'total_recordings': totalRecordings,
      if (totalPracticeSeconds != null)
        'total_practice_seconds': totalPracticeSeconds,
    });
  }

  UserStreaksCompanion copyWith({
    Value<int>? id,
    Value<int>? currentStreak,
    Value<int>? longestStreak,
    Value<DateTime?>? lastActivityDate,
    Value<int>? totalRecordings,
    Value<int>? totalPracticeSeconds,
  }) {
    return UserStreaksCompanion(
      id: id ?? this.id,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastActivityDate: lastActivityDate ?? this.lastActivityDate,
      totalRecordings: totalRecordings ?? this.totalRecordings,
      totalPracticeSeconds: totalPracticeSeconds ?? this.totalPracticeSeconds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (longestStreak.present) {
      map['longest_streak'] = Variable<int>(longestStreak.value);
    }
    if (lastActivityDate.present) {
      map['last_activity_date'] = Variable<DateTime>(lastActivityDate.value);
    }
    if (totalRecordings.present) {
      map['total_recordings'] = Variable<int>(totalRecordings.value);
    }
    if (totalPracticeSeconds.present) {
      map['total_practice_seconds'] = Variable<int>(totalPracticeSeconds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserStreaksCompanion(')
          ..write('id: $id, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('lastActivityDate: $lastActivityDate, ')
          ..write('totalRecordings: $totalRecordings, ')
          ..write('totalPracticeSeconds: $totalPracticeSeconds')
          ..write(')'))
        .toString();
  }
}

class $AchievementsTable extends Achievements
    with TableInfo<$AchievementsTable, Achievement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _achievementIdMeta = const VerificationMeta(
    'achievementId',
  );
  @override
  late final GeneratedColumn<String> achievementId = GeneratedColumn<String>(
    'achievement_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unlockedAtMeta = const VerificationMeta(
    'unlockedAt',
  );
  @override
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
    'unlocked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, achievementId, unlockedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievements';
  @override
  VerificationContext validateIntegrity(
    Insertable<Achievement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('achievement_id')) {
      context.handle(
        _achievementIdMeta,
        achievementId.isAcceptableOrUnknown(
          data['achievement_id']!,
          _achievementIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_achievementIdMeta);
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
        _unlockedAtMeta,
        unlockedAt.isAcceptableOrUnknown(data['unlocked_at']!, _unlockedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_unlockedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Achievement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Achievement(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      achievementId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}achievement_id'],
          )!,
      unlockedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}unlocked_at'],
          )!,
    );
  }

  @override
  $AchievementsTable createAlias(String alias) {
    return $AchievementsTable(attachedDatabase, alias);
  }
}

class Achievement extends DataClass implements Insertable<Achievement> {
  final int id;
  final String achievementId;
  final DateTime unlockedAt;
  const Achievement({
    required this.id,
    required this.achievementId,
    required this.unlockedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['achievement_id'] = Variable<String>(achievementId);
    map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    return map;
  }

  AchievementsCompanion toCompanion(bool nullToAbsent) {
    return AchievementsCompanion(
      id: Value(id),
      achievementId: Value(achievementId),
      unlockedAt: Value(unlockedAt),
    );
  }

  factory Achievement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Achievement(
      id: serializer.fromJson<int>(json['id']),
      achievementId: serializer.fromJson<String>(json['achievementId']),
      unlockedAt: serializer.fromJson<DateTime>(json['unlockedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'achievementId': serializer.toJson<String>(achievementId),
      'unlockedAt': serializer.toJson<DateTime>(unlockedAt),
    };
  }

  Achievement copyWith({
    int? id,
    String? achievementId,
    DateTime? unlockedAt,
  }) => Achievement(
    id: id ?? this.id,
    achievementId: achievementId ?? this.achievementId,
    unlockedAt: unlockedAt ?? this.unlockedAt,
  );
  Achievement copyWithCompanion(AchievementsCompanion data) {
    return Achievement(
      id: data.id.present ? data.id.value : this.id,
      achievementId:
          data.achievementId.present
              ? data.achievementId.value
              : this.achievementId,
      unlockedAt:
          data.unlockedAt.present ? data.unlockedAt.value : this.unlockedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Achievement(')
          ..write('id: $id, ')
          ..write('achievementId: $achievementId, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, achievementId, unlockedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Achievement &&
          other.id == this.id &&
          other.achievementId == this.achievementId &&
          other.unlockedAt == this.unlockedAt);
}

class AchievementsCompanion extends UpdateCompanion<Achievement> {
  final Value<int> id;
  final Value<String> achievementId;
  final Value<DateTime> unlockedAt;
  const AchievementsCompanion({
    this.id = const Value.absent(),
    this.achievementId = const Value.absent(),
    this.unlockedAt = const Value.absent(),
  });
  AchievementsCompanion.insert({
    this.id = const Value.absent(),
    required String achievementId,
    required DateTime unlockedAt,
  }) : achievementId = Value(achievementId),
       unlockedAt = Value(unlockedAt);
  static Insertable<Achievement> custom({
    Expression<int>? id,
    Expression<String>? achievementId,
    Expression<DateTime>? unlockedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (achievementId != null) 'achievement_id': achievementId,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
    });
  }

  AchievementsCompanion copyWith({
    Value<int>? id,
    Value<String>? achievementId,
    Value<DateTime>? unlockedAt,
  }) {
    return AchievementsCompanion(
      id: id ?? this.id,
      achievementId: achievementId ?? this.achievementId,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (achievementId.present) {
      map['achievement_id'] = Variable<String>(achievementId.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsCompanion(')
          ..write('id: $id, ')
          ..write('achievementId: $achievementId, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }
}

class $RecordingSessionsTable extends RecordingSessions
    with TableInfo<$RecordingSessionsTable, RecordingSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecordingSessionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _lessonIdMeta = const VerificationMeta(
    'lessonId',
  );
  @override
  late final GeneratedColumn<int> lessonId = GeneratedColumn<int>(
    'lesson_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _surahIdMeta = const VerificationMeta(
    'surahId',
  );
  @override
  late final GeneratedColumn<int> surahId = GeneratedColumn<int>(
    'surah_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userAudioPathMeta = const VerificationMeta(
    'userAudioPath',
  );
  @override
  late final GeneratedColumn<String> userAudioPath = GeneratedColumn<String>(
    'user_audio_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sheikhAudioUrlMeta = const VerificationMeta(
    'sheikhAudioUrl',
  );
  @override
  late final GeneratedColumn<String> sheikhAudioUrl = GeneratedColumn<String>(
    'sheikh_audio_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _selfRatingMeta = const VerificationMeta(
    'selfRating',
  );
  @override
  late final GeneratedColumn<int> selfRating = GeneratedColumn<int>(
    'self_rating',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lessonId,
    surahId,
    ayahNumber,
    userAudioPath,
    sheikhAudioUrl,
    recordedAt,
    durationMs,
    selfRating,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recording_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecordingSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lesson_id')) {
      context.handle(
        _lessonIdMeta,
        lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('surah_id')) {
      context.handle(
        _surahIdMeta,
        surahId.isAcceptableOrUnknown(data['surah_id']!, _surahIdMeta),
      );
    } else if (isInserting) {
      context.missing(_surahIdMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('user_audio_path')) {
      context.handle(
        _userAudioPathMeta,
        userAudioPath.isAcceptableOrUnknown(
          data['user_audio_path']!,
          _userAudioPathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userAudioPathMeta);
    }
    if (data.containsKey('sheikh_audio_url')) {
      context.handle(
        _sheikhAudioUrlMeta,
        sheikhAudioUrl.isAcceptableOrUnknown(
          data['sheikh_audio_url']!,
          _sheikhAudioUrlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sheikhAudioUrlMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMsMeta);
    }
    if (data.containsKey('self_rating')) {
      context.handle(
        _selfRatingMeta,
        selfRating.isAcceptableOrUnknown(data['self_rating']!, _selfRatingMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecordingSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecordingSession(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      lessonId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}lesson_id'],
          )!,
      surahId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}surah_id'],
          )!,
      ayahNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}ayah_number'],
          )!,
      userAudioPath:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}user_audio_path'],
          )!,
      sheikhAudioUrl:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}sheikh_audio_url'],
          )!,
      recordedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}recorded_at'],
          )!,
      durationMs:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}duration_ms'],
          )!,
      selfRating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}self_rating'],
      ),
    );
  }

  @override
  $RecordingSessionsTable createAlias(String alias) {
    return $RecordingSessionsTable(attachedDatabase, alias);
  }
}

class RecordingSession extends DataClass
    implements Insertable<RecordingSession> {
  final int id;
  final int lessonId;
  final int surahId;
  final int ayahNumber;
  final String userAudioPath;
  final String sheikhAudioUrl;
  final DateTime recordedAt;
  final int durationMs;
  final int? selfRating;
  const RecordingSession({
    required this.id,
    required this.lessonId,
    required this.surahId,
    required this.ayahNumber,
    required this.userAudioPath,
    required this.sheikhAudioUrl,
    required this.recordedAt,
    required this.durationMs,
    this.selfRating,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lesson_id'] = Variable<int>(lessonId);
    map['surah_id'] = Variable<int>(surahId);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['user_audio_path'] = Variable<String>(userAudioPath);
    map['sheikh_audio_url'] = Variable<String>(sheikhAudioUrl);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    map['duration_ms'] = Variable<int>(durationMs);
    if (!nullToAbsent || selfRating != null) {
      map['self_rating'] = Variable<int>(selfRating);
    }
    return map;
  }

  RecordingSessionsCompanion toCompanion(bool nullToAbsent) {
    return RecordingSessionsCompanion(
      id: Value(id),
      lessonId: Value(lessonId),
      surahId: Value(surahId),
      ayahNumber: Value(ayahNumber),
      userAudioPath: Value(userAudioPath),
      sheikhAudioUrl: Value(sheikhAudioUrl),
      recordedAt: Value(recordedAt),
      durationMs: Value(durationMs),
      selfRating:
          selfRating == null && nullToAbsent
              ? const Value.absent()
              : Value(selfRating),
    );
  }

  factory RecordingSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecordingSession(
      id: serializer.fromJson<int>(json['id']),
      lessonId: serializer.fromJson<int>(json['lessonId']),
      surahId: serializer.fromJson<int>(json['surahId']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      userAudioPath: serializer.fromJson<String>(json['userAudioPath']),
      sheikhAudioUrl: serializer.fromJson<String>(json['sheikhAudioUrl']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      durationMs: serializer.fromJson<int>(json['durationMs']),
      selfRating: serializer.fromJson<int?>(json['selfRating']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lessonId': serializer.toJson<int>(lessonId),
      'surahId': serializer.toJson<int>(surahId),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'userAudioPath': serializer.toJson<String>(userAudioPath),
      'sheikhAudioUrl': serializer.toJson<String>(sheikhAudioUrl),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'durationMs': serializer.toJson<int>(durationMs),
      'selfRating': serializer.toJson<int?>(selfRating),
    };
  }

  RecordingSession copyWith({
    int? id,
    int? lessonId,
    int? surahId,
    int? ayahNumber,
    String? userAudioPath,
    String? sheikhAudioUrl,
    DateTime? recordedAt,
    int? durationMs,
    Value<int?> selfRating = const Value.absent(),
  }) => RecordingSession(
    id: id ?? this.id,
    lessonId: lessonId ?? this.lessonId,
    surahId: surahId ?? this.surahId,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    userAudioPath: userAudioPath ?? this.userAudioPath,
    sheikhAudioUrl: sheikhAudioUrl ?? this.sheikhAudioUrl,
    recordedAt: recordedAt ?? this.recordedAt,
    durationMs: durationMs ?? this.durationMs,
    selfRating: selfRating.present ? selfRating.value : this.selfRating,
  );
  RecordingSession copyWithCompanion(RecordingSessionsCompanion data) {
    return RecordingSession(
      id: data.id.present ? data.id.value : this.id,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      surahId: data.surahId.present ? data.surahId.value : this.surahId,
      ayahNumber:
          data.ayahNumber.present ? data.ayahNumber.value : this.ayahNumber,
      userAudioPath:
          data.userAudioPath.present
              ? data.userAudioPath.value
              : this.userAudioPath,
      sheikhAudioUrl:
          data.sheikhAudioUrl.present
              ? data.sheikhAudioUrl.value
              : this.sheikhAudioUrl,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
      durationMs:
          data.durationMs.present ? data.durationMs.value : this.durationMs,
      selfRating:
          data.selfRating.present ? data.selfRating.value : this.selfRating,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecordingSession(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('surahId: $surahId, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('userAudioPath: $userAudioPath, ')
          ..write('sheikhAudioUrl: $sheikhAudioUrl, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('durationMs: $durationMs, ')
          ..write('selfRating: $selfRating')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    lessonId,
    surahId,
    ayahNumber,
    userAudioPath,
    sheikhAudioUrl,
    recordedAt,
    durationMs,
    selfRating,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecordingSession &&
          other.id == this.id &&
          other.lessonId == this.lessonId &&
          other.surahId == this.surahId &&
          other.ayahNumber == this.ayahNumber &&
          other.userAudioPath == this.userAudioPath &&
          other.sheikhAudioUrl == this.sheikhAudioUrl &&
          other.recordedAt == this.recordedAt &&
          other.durationMs == this.durationMs &&
          other.selfRating == this.selfRating);
}

class RecordingSessionsCompanion extends UpdateCompanion<RecordingSession> {
  final Value<int> id;
  final Value<int> lessonId;
  final Value<int> surahId;
  final Value<int> ayahNumber;
  final Value<String> userAudioPath;
  final Value<String> sheikhAudioUrl;
  final Value<DateTime> recordedAt;
  final Value<int> durationMs;
  final Value<int?> selfRating;
  const RecordingSessionsCompanion({
    this.id = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.surahId = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.userAudioPath = const Value.absent(),
    this.sheikhAudioUrl = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.selfRating = const Value.absent(),
  });
  RecordingSessionsCompanion.insert({
    this.id = const Value.absent(),
    required int lessonId,
    required int surahId,
    required int ayahNumber,
    required String userAudioPath,
    required String sheikhAudioUrl,
    required DateTime recordedAt,
    required int durationMs,
    this.selfRating = const Value.absent(),
  }) : lessonId = Value(lessonId),
       surahId = Value(surahId),
       ayahNumber = Value(ayahNumber),
       userAudioPath = Value(userAudioPath),
       sheikhAudioUrl = Value(sheikhAudioUrl),
       recordedAt = Value(recordedAt),
       durationMs = Value(durationMs);
  static Insertable<RecordingSession> custom({
    Expression<int>? id,
    Expression<int>? lessonId,
    Expression<int>? surahId,
    Expression<int>? ayahNumber,
    Expression<String>? userAudioPath,
    Expression<String>? sheikhAudioUrl,
    Expression<DateTime>? recordedAt,
    Expression<int>? durationMs,
    Expression<int>? selfRating,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lessonId != null) 'lesson_id': lessonId,
      if (surahId != null) 'surah_id': surahId,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (userAudioPath != null) 'user_audio_path': userAudioPath,
      if (sheikhAudioUrl != null) 'sheikh_audio_url': sheikhAudioUrl,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (durationMs != null) 'duration_ms': durationMs,
      if (selfRating != null) 'self_rating': selfRating,
    });
  }

  RecordingSessionsCompanion copyWith({
    Value<int>? id,
    Value<int>? lessonId,
    Value<int>? surahId,
    Value<int>? ayahNumber,
    Value<String>? userAudioPath,
    Value<String>? sheikhAudioUrl,
    Value<DateTime>? recordedAt,
    Value<int>? durationMs,
    Value<int?>? selfRating,
  }) {
    return RecordingSessionsCompanion(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      surahId: surahId ?? this.surahId,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      userAudioPath: userAudioPath ?? this.userAudioPath,
      sheikhAudioUrl: sheikhAudioUrl ?? this.sheikhAudioUrl,
      recordedAt: recordedAt ?? this.recordedAt,
      durationMs: durationMs ?? this.durationMs,
      selfRating: selfRating ?? this.selfRating,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<int>(lessonId.value);
    }
    if (surahId.present) {
      map['surah_id'] = Variable<int>(surahId.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (userAudioPath.present) {
      map['user_audio_path'] = Variable<String>(userAudioPath.value);
    }
    if (sheikhAudioUrl.present) {
      map['sheikh_audio_url'] = Variable<String>(sheikhAudioUrl.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (selfRating.present) {
      map['self_rating'] = Variable<int>(selfRating.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecordingSessionsCompanion(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('surahId: $surahId, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('userAudioPath: $userAudioPath, ')
          ..write('sheikhAudioUrl: $sheikhAudioUrl, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('durationMs: $durationMs, ')
          ..write('selfRating: $selfRating')
          ..write(')'))
        .toString();
  }
}

class $DailyActivityLogTable extends DailyActivityLog
    with TableInfo<$DailyActivityLogTable, DailyActivityLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyActivityLogTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _activityTypeMeta = const VerificationMeta(
    'activityType',
  );
  @override
  late final GeneratedColumn<String> activityType = GeneratedColumn<String>(
    'activity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, activityType, completedAt, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_activity_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyActivityLogData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('activity_type')) {
      context.handle(
        _activityTypeMeta,
        activityType.isAcceptableOrUnknown(
          data['activity_type']!,
          _activityTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activityTypeMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedAtMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyActivityLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyActivityLogData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      activityType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}activity_type'],
          )!,
      completedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}completed_at'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}date'],
          )!,
    );
  }

  @override
  $DailyActivityLogTable createAlias(String alias) {
    return $DailyActivityLogTable(attachedDatabase, alias);
  }
}

class DailyActivityLogData extends DataClass
    implements Insertable<DailyActivityLogData> {
  final int id;
  final String activityType;
  final DateTime completedAt;
  final String date;
  const DailyActivityLogData({
    required this.id,
    required this.activityType,
    required this.completedAt,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['activity_type'] = Variable<String>(activityType);
    map['completed_at'] = Variable<DateTime>(completedAt);
    map['date'] = Variable<String>(date);
    return map;
  }

  DailyActivityLogCompanion toCompanion(bool nullToAbsent) {
    return DailyActivityLogCompanion(
      id: Value(id),
      activityType: Value(activityType),
      completedAt: Value(completedAt),
      date: Value(date),
    );
  }

  factory DailyActivityLogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyActivityLogData(
      id: serializer.fromJson<int>(json['id']),
      activityType: serializer.fromJson<String>(json['activityType']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      date: serializer.fromJson<String>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'activityType': serializer.toJson<String>(activityType),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'date': serializer.toJson<String>(date),
    };
  }

  DailyActivityLogData copyWith({
    int? id,
    String? activityType,
    DateTime? completedAt,
    String? date,
  }) => DailyActivityLogData(
    id: id ?? this.id,
    activityType: activityType ?? this.activityType,
    completedAt: completedAt ?? this.completedAt,
    date: date ?? this.date,
  );
  DailyActivityLogData copyWithCompanion(DailyActivityLogCompanion data) {
    return DailyActivityLogData(
      id: data.id.present ? data.id.value : this.id,
      activityType:
          data.activityType.present
              ? data.activityType.value
              : this.activityType,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyActivityLogData(')
          ..write('id: $id, ')
          ..write('activityType: $activityType, ')
          ..write('completedAt: $completedAt, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, activityType, completedAt, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyActivityLogData &&
          other.id == this.id &&
          other.activityType == this.activityType &&
          other.completedAt == this.completedAt &&
          other.date == this.date);
}

class DailyActivityLogCompanion extends UpdateCompanion<DailyActivityLogData> {
  final Value<int> id;
  final Value<String> activityType;
  final Value<DateTime> completedAt;
  final Value<String> date;
  const DailyActivityLogCompanion({
    this.id = const Value.absent(),
    this.activityType = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.date = const Value.absent(),
  });
  DailyActivityLogCompanion.insert({
    this.id = const Value.absent(),
    required String activityType,
    required DateTime completedAt,
    required String date,
  }) : activityType = Value(activityType),
       completedAt = Value(completedAt),
       date = Value(date);
  static Insertable<DailyActivityLogData> custom({
    Expression<int>? id,
    Expression<String>? activityType,
    Expression<DateTime>? completedAt,
    Expression<String>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (activityType != null) 'activity_type': activityType,
      if (completedAt != null) 'completed_at': completedAt,
      if (date != null) 'date': date,
    });
  }

  DailyActivityLogCompanion copyWith({
    Value<int>? id,
    Value<String>? activityType,
    Value<DateTime>? completedAt,
    Value<String>? date,
  }) {
    return DailyActivityLogCompanion(
      id: id ?? this.id,
      activityType: activityType ?? this.activityType,
      completedAt: completedAt ?? this.completedAt,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (activityType.present) {
      map['activity_type'] = Variable<String>(activityType.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyActivityLogCompanion(')
          ..write('id: $id, ')
          ..write('activityType: $activityType, ')
          ..write('completedAt: $completedAt, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $CachedHadithSectionsTable extends CachedHadithSections
    with TableInfo<$CachedHadithSectionsTable, CachedHadithSection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedHadithSectionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _collectionKeyMeta = const VerificationMeta(
    'collectionKey',
  );
  @override
  late final GeneratedColumn<String> collectionKey = GeneratedColumn<String>(
    'collection_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sectionNumberMeta = const VerificationMeta(
    'sectionNumber',
  );
  @override
  late final GeneratedColumn<int> sectionNumber = GeneratedColumn<int>(
    'section_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _hadithStartNumberMeta = const VerificationMeta(
    'hadithStartNumber',
  );
  @override
  late final GeneratedColumn<int> hadithStartNumber = GeneratedColumn<int>(
    'hadith_start_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _hadithEndNumberMeta = const VerificationMeta(
    'hadithEndNumber',
  );
  @override
  late final GeneratedColumn<int> hadithEndNumber = GeneratedColumn<int>(
    'hadith_end_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    collectionKey,
    sectionNumber,
    name,
    nameArabic,
    hadithStartNumber,
    hadithEndNumber,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_hadith_sections';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedHadithSection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collection_key')) {
      context.handle(
        _collectionKeyMeta,
        collectionKey.isAcceptableOrUnknown(
          data['collection_key']!,
          _collectionKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionKeyMeta);
    }
    if (data.containsKey('section_number')) {
      context.handle(
        _sectionNumberMeta,
        sectionNumber.isAcceptableOrUnknown(
          data['section_number']!,
          _sectionNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sectionNumberMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_arabic')) {
      context.handle(
        _nameArabicMeta,
        nameArabic.isAcceptableOrUnknown(data['name_arabic']!, _nameArabicMeta),
      );
    }
    if (data.containsKey('hadith_start_number')) {
      context.handle(
        _hadithStartNumberMeta,
        hadithStartNumber.isAcceptableOrUnknown(
          data['hadith_start_number']!,
          _hadithStartNumberMeta,
        ),
      );
    }
    if (data.containsKey('hadith_end_number')) {
      context.handle(
        _hadithEndNumberMeta,
        hadithEndNumber.isAcceptableOrUnknown(
          data['hadith_end_number']!,
          _hadithEndNumberMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {collectionKey, sectionNumber},
  ];
  @override
  CachedHadithSection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedHadithSection(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      collectionKey:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}collection_key'],
          )!,
      sectionNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}section_number'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      nameArabic:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name_arabic'],
          )!,
      hadithStartNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}hadith_start_number'],
          )!,
      hadithEndNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}hadith_end_number'],
          )!,
    );
  }

  @override
  $CachedHadithSectionsTable createAlias(String alias) {
    return $CachedHadithSectionsTable(attachedDatabase, alias);
  }
}

class CachedHadithSection extends DataClass
    implements Insertable<CachedHadithSection> {
  final int id;
  final String collectionKey;
  final int sectionNumber;
  final String name;
  final String nameArabic;
  final int hadithStartNumber;
  final int hadithEndNumber;
  const CachedHadithSection({
    required this.id,
    required this.collectionKey,
    required this.sectionNumber,
    required this.name,
    required this.nameArabic,
    required this.hadithStartNumber,
    required this.hadithEndNumber,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['collection_key'] = Variable<String>(collectionKey);
    map['section_number'] = Variable<int>(sectionNumber);
    map['name'] = Variable<String>(name);
    map['name_arabic'] = Variable<String>(nameArabic);
    map['hadith_start_number'] = Variable<int>(hadithStartNumber);
    map['hadith_end_number'] = Variable<int>(hadithEndNumber);
    return map;
  }

  CachedHadithSectionsCompanion toCompanion(bool nullToAbsent) {
    return CachedHadithSectionsCompanion(
      id: Value(id),
      collectionKey: Value(collectionKey),
      sectionNumber: Value(sectionNumber),
      name: Value(name),
      nameArabic: Value(nameArabic),
      hadithStartNumber: Value(hadithStartNumber),
      hadithEndNumber: Value(hadithEndNumber),
    );
  }

  factory CachedHadithSection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedHadithSection(
      id: serializer.fromJson<int>(json['id']),
      collectionKey: serializer.fromJson<String>(json['collectionKey']),
      sectionNumber: serializer.fromJson<int>(json['sectionNumber']),
      name: serializer.fromJson<String>(json['name']),
      nameArabic: serializer.fromJson<String>(json['nameArabic']),
      hadithStartNumber: serializer.fromJson<int>(json['hadithStartNumber']),
      hadithEndNumber: serializer.fromJson<int>(json['hadithEndNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collectionKey': serializer.toJson<String>(collectionKey),
      'sectionNumber': serializer.toJson<int>(sectionNumber),
      'name': serializer.toJson<String>(name),
      'nameArabic': serializer.toJson<String>(nameArabic),
      'hadithStartNumber': serializer.toJson<int>(hadithStartNumber),
      'hadithEndNumber': serializer.toJson<int>(hadithEndNumber),
    };
  }

  CachedHadithSection copyWith({
    int? id,
    String? collectionKey,
    int? sectionNumber,
    String? name,
    String? nameArabic,
    int? hadithStartNumber,
    int? hadithEndNumber,
  }) => CachedHadithSection(
    id: id ?? this.id,
    collectionKey: collectionKey ?? this.collectionKey,
    sectionNumber: sectionNumber ?? this.sectionNumber,
    name: name ?? this.name,
    nameArabic: nameArabic ?? this.nameArabic,
    hadithStartNumber: hadithStartNumber ?? this.hadithStartNumber,
    hadithEndNumber: hadithEndNumber ?? this.hadithEndNumber,
  );
  CachedHadithSection copyWithCompanion(CachedHadithSectionsCompanion data) {
    return CachedHadithSection(
      id: data.id.present ? data.id.value : this.id,
      collectionKey:
          data.collectionKey.present
              ? data.collectionKey.value
              : this.collectionKey,
      sectionNumber:
          data.sectionNumber.present
              ? data.sectionNumber.value
              : this.sectionNumber,
      name: data.name.present ? data.name.value : this.name,
      nameArabic:
          data.nameArabic.present ? data.nameArabic.value : this.nameArabic,
      hadithStartNumber:
          data.hadithStartNumber.present
              ? data.hadithStartNumber.value
              : this.hadithStartNumber,
      hadithEndNumber:
          data.hadithEndNumber.present
              ? data.hadithEndNumber.value
              : this.hadithEndNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedHadithSection(')
          ..write('id: $id, ')
          ..write('collectionKey: $collectionKey, ')
          ..write('sectionNumber: $sectionNumber, ')
          ..write('name: $name, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('hadithStartNumber: $hadithStartNumber, ')
          ..write('hadithEndNumber: $hadithEndNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    collectionKey,
    sectionNumber,
    name,
    nameArabic,
    hadithStartNumber,
    hadithEndNumber,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedHadithSection &&
          other.id == this.id &&
          other.collectionKey == this.collectionKey &&
          other.sectionNumber == this.sectionNumber &&
          other.name == this.name &&
          other.nameArabic == this.nameArabic &&
          other.hadithStartNumber == this.hadithStartNumber &&
          other.hadithEndNumber == this.hadithEndNumber);
}

class CachedHadithSectionsCompanion
    extends UpdateCompanion<CachedHadithSection> {
  final Value<int> id;
  final Value<String> collectionKey;
  final Value<int> sectionNumber;
  final Value<String> name;
  final Value<String> nameArabic;
  final Value<int> hadithStartNumber;
  final Value<int> hadithEndNumber;
  const CachedHadithSectionsCompanion({
    this.id = const Value.absent(),
    this.collectionKey = const Value.absent(),
    this.sectionNumber = const Value.absent(),
    this.name = const Value.absent(),
    this.nameArabic = const Value.absent(),
    this.hadithStartNumber = const Value.absent(),
    this.hadithEndNumber = const Value.absent(),
  });
  CachedHadithSectionsCompanion.insert({
    this.id = const Value.absent(),
    required String collectionKey,
    required int sectionNumber,
    required String name,
    this.nameArabic = const Value.absent(),
    this.hadithStartNumber = const Value.absent(),
    this.hadithEndNumber = const Value.absent(),
  }) : collectionKey = Value(collectionKey),
       sectionNumber = Value(sectionNumber),
       name = Value(name);
  static Insertable<CachedHadithSection> custom({
    Expression<int>? id,
    Expression<String>? collectionKey,
    Expression<int>? sectionNumber,
    Expression<String>? name,
    Expression<String>? nameArabic,
    Expression<int>? hadithStartNumber,
    Expression<int>? hadithEndNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionKey != null) 'collection_key': collectionKey,
      if (sectionNumber != null) 'section_number': sectionNumber,
      if (name != null) 'name': name,
      if (nameArabic != null) 'name_arabic': nameArabic,
      if (hadithStartNumber != null) 'hadith_start_number': hadithStartNumber,
      if (hadithEndNumber != null) 'hadith_end_number': hadithEndNumber,
    });
  }

  CachedHadithSectionsCompanion copyWith({
    Value<int>? id,
    Value<String>? collectionKey,
    Value<int>? sectionNumber,
    Value<String>? name,
    Value<String>? nameArabic,
    Value<int>? hadithStartNumber,
    Value<int>? hadithEndNumber,
  }) {
    return CachedHadithSectionsCompanion(
      id: id ?? this.id,
      collectionKey: collectionKey ?? this.collectionKey,
      sectionNumber: sectionNumber ?? this.sectionNumber,
      name: name ?? this.name,
      nameArabic: nameArabic ?? this.nameArabic,
      hadithStartNumber: hadithStartNumber ?? this.hadithStartNumber,
      hadithEndNumber: hadithEndNumber ?? this.hadithEndNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collectionKey.present) {
      map['collection_key'] = Variable<String>(collectionKey.value);
    }
    if (sectionNumber.present) {
      map['section_number'] = Variable<int>(sectionNumber.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameArabic.present) {
      map['name_arabic'] = Variable<String>(nameArabic.value);
    }
    if (hadithStartNumber.present) {
      map['hadith_start_number'] = Variable<int>(hadithStartNumber.value);
    }
    if (hadithEndNumber.present) {
      map['hadith_end_number'] = Variable<int>(hadithEndNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedHadithSectionsCompanion(')
          ..write('id: $id, ')
          ..write('collectionKey: $collectionKey, ')
          ..write('sectionNumber: $sectionNumber, ')
          ..write('name: $name, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('hadithStartNumber: $hadithStartNumber, ')
          ..write('hadithEndNumber: $hadithEndNumber')
          ..write(')'))
        .toString();
  }
}

class $CachedHadithsTable extends CachedHadiths
    with TableInfo<$CachedHadithsTable, CachedHadith> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedHadithsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _collectionKeyMeta = const VerificationMeta(
    'collectionKey',
  );
  @override
  late final GeneratedColumn<String> collectionKey = GeneratedColumn<String>(
    'collection_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sectionNumberMeta = const VerificationMeta(
    'sectionNumber',
  );
  @override
  late final GeneratedColumn<int> sectionNumber = GeneratedColumn<int>(
    'section_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hadithNumberMeta = const VerificationMeta(
    'hadithNumber',
  );
  @override
  late final GeneratedColumn<int> hadithNumber = GeneratedColumn<int>(
    'hadith_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  static const VerificationMeta _textEnglishMeta = const VerificationMeta(
    'textEnglish',
  );
  @override
  late final GeneratedColumn<String> textEnglish = GeneratedColumn<String>(
    'text_english',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    collectionKey,
    sectionNumber,
    hadithNumber,
    textArabic,
    textEnglish,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_hadiths';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedHadith> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collection_key')) {
      context.handle(
        _collectionKeyMeta,
        collectionKey.isAcceptableOrUnknown(
          data['collection_key']!,
          _collectionKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionKeyMeta);
    }
    if (data.containsKey('section_number')) {
      context.handle(
        _sectionNumberMeta,
        sectionNumber.isAcceptableOrUnknown(
          data['section_number']!,
          _sectionNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sectionNumberMeta);
    }
    if (data.containsKey('hadith_number')) {
      context.handle(
        _hadithNumberMeta,
        hadithNumber.isAcceptableOrUnknown(
          data['hadith_number']!,
          _hadithNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hadithNumberMeta);
    }
    if (data.containsKey('text_arabic')) {
      context.handle(
        _textArabicMeta,
        textArabic.isAcceptableOrUnknown(data['text_arabic']!, _textArabicMeta),
      );
    } else if (isInserting) {
      context.missing(_textArabicMeta);
    }
    if (data.containsKey('text_english')) {
      context.handle(
        _textEnglishMeta,
        textEnglish.isAcceptableOrUnknown(
          data['text_english']!,
          _textEnglishMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {collectionKey, hadithNumber},
  ];
  @override
  CachedHadith map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedHadith(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      collectionKey:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}collection_key'],
          )!,
      sectionNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}section_number'],
          )!,
      hadithNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}hadith_number'],
          )!,
      textArabic:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}text_arabic'],
          )!,
      textEnglish:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}text_english'],
          )!,
    );
  }

  @override
  $CachedHadithsTable createAlias(String alias) {
    return $CachedHadithsTable(attachedDatabase, alias);
  }
}

class CachedHadith extends DataClass implements Insertable<CachedHadith> {
  final int id;
  final String collectionKey;
  final int sectionNumber;
  final int hadithNumber;
  final String textArabic;
  final String textEnglish;
  const CachedHadith({
    required this.id,
    required this.collectionKey,
    required this.sectionNumber,
    required this.hadithNumber,
    required this.textArabic,
    required this.textEnglish,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['collection_key'] = Variable<String>(collectionKey);
    map['section_number'] = Variable<int>(sectionNumber);
    map['hadith_number'] = Variable<int>(hadithNumber);
    map['text_arabic'] = Variable<String>(textArabic);
    map['text_english'] = Variable<String>(textEnglish);
    return map;
  }

  CachedHadithsCompanion toCompanion(bool nullToAbsent) {
    return CachedHadithsCompanion(
      id: Value(id),
      collectionKey: Value(collectionKey),
      sectionNumber: Value(sectionNumber),
      hadithNumber: Value(hadithNumber),
      textArabic: Value(textArabic),
      textEnglish: Value(textEnglish),
    );
  }

  factory CachedHadith.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedHadith(
      id: serializer.fromJson<int>(json['id']),
      collectionKey: serializer.fromJson<String>(json['collectionKey']),
      sectionNumber: serializer.fromJson<int>(json['sectionNumber']),
      hadithNumber: serializer.fromJson<int>(json['hadithNumber']),
      textArabic: serializer.fromJson<String>(json['textArabic']),
      textEnglish: serializer.fromJson<String>(json['textEnglish']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collectionKey': serializer.toJson<String>(collectionKey),
      'sectionNumber': serializer.toJson<int>(sectionNumber),
      'hadithNumber': serializer.toJson<int>(hadithNumber),
      'textArabic': serializer.toJson<String>(textArabic),
      'textEnglish': serializer.toJson<String>(textEnglish),
    };
  }

  CachedHadith copyWith({
    int? id,
    String? collectionKey,
    int? sectionNumber,
    int? hadithNumber,
    String? textArabic,
    String? textEnglish,
  }) => CachedHadith(
    id: id ?? this.id,
    collectionKey: collectionKey ?? this.collectionKey,
    sectionNumber: sectionNumber ?? this.sectionNumber,
    hadithNumber: hadithNumber ?? this.hadithNumber,
    textArabic: textArabic ?? this.textArabic,
    textEnglish: textEnglish ?? this.textEnglish,
  );
  CachedHadith copyWithCompanion(CachedHadithsCompanion data) {
    return CachedHadith(
      id: data.id.present ? data.id.value : this.id,
      collectionKey:
          data.collectionKey.present
              ? data.collectionKey.value
              : this.collectionKey,
      sectionNumber:
          data.sectionNumber.present
              ? data.sectionNumber.value
              : this.sectionNumber,
      hadithNumber:
          data.hadithNumber.present
              ? data.hadithNumber.value
              : this.hadithNumber,
      textArabic:
          data.textArabic.present ? data.textArabic.value : this.textArabic,
      textEnglish:
          data.textEnglish.present ? data.textEnglish.value : this.textEnglish,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedHadith(')
          ..write('id: $id, ')
          ..write('collectionKey: $collectionKey, ')
          ..write('sectionNumber: $sectionNumber, ')
          ..write('hadithNumber: $hadithNumber, ')
          ..write('textArabic: $textArabic, ')
          ..write('textEnglish: $textEnglish')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    collectionKey,
    sectionNumber,
    hadithNumber,
    textArabic,
    textEnglish,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedHadith &&
          other.id == this.id &&
          other.collectionKey == this.collectionKey &&
          other.sectionNumber == this.sectionNumber &&
          other.hadithNumber == this.hadithNumber &&
          other.textArabic == this.textArabic &&
          other.textEnglish == this.textEnglish);
}

class CachedHadithsCompanion extends UpdateCompanion<CachedHadith> {
  final Value<int> id;
  final Value<String> collectionKey;
  final Value<int> sectionNumber;
  final Value<int> hadithNumber;
  final Value<String> textArabic;
  final Value<String> textEnglish;
  const CachedHadithsCompanion({
    this.id = const Value.absent(),
    this.collectionKey = const Value.absent(),
    this.sectionNumber = const Value.absent(),
    this.hadithNumber = const Value.absent(),
    this.textArabic = const Value.absent(),
    this.textEnglish = const Value.absent(),
  });
  CachedHadithsCompanion.insert({
    this.id = const Value.absent(),
    required String collectionKey,
    required int sectionNumber,
    required int hadithNumber,
    required String textArabic,
    this.textEnglish = const Value.absent(),
  }) : collectionKey = Value(collectionKey),
       sectionNumber = Value(sectionNumber),
       hadithNumber = Value(hadithNumber),
       textArabic = Value(textArabic);
  static Insertable<CachedHadith> custom({
    Expression<int>? id,
    Expression<String>? collectionKey,
    Expression<int>? sectionNumber,
    Expression<int>? hadithNumber,
    Expression<String>? textArabic,
    Expression<String>? textEnglish,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionKey != null) 'collection_key': collectionKey,
      if (sectionNumber != null) 'section_number': sectionNumber,
      if (hadithNumber != null) 'hadith_number': hadithNumber,
      if (textArabic != null) 'text_arabic': textArabic,
      if (textEnglish != null) 'text_english': textEnglish,
    });
  }

  CachedHadithsCompanion copyWith({
    Value<int>? id,
    Value<String>? collectionKey,
    Value<int>? sectionNumber,
    Value<int>? hadithNumber,
    Value<String>? textArabic,
    Value<String>? textEnglish,
  }) {
    return CachedHadithsCompanion(
      id: id ?? this.id,
      collectionKey: collectionKey ?? this.collectionKey,
      sectionNumber: sectionNumber ?? this.sectionNumber,
      hadithNumber: hadithNumber ?? this.hadithNumber,
      textArabic: textArabic ?? this.textArabic,
      textEnglish: textEnglish ?? this.textEnglish,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collectionKey.present) {
      map['collection_key'] = Variable<String>(collectionKey.value);
    }
    if (sectionNumber.present) {
      map['section_number'] = Variable<int>(sectionNumber.value);
    }
    if (hadithNumber.present) {
      map['hadith_number'] = Variable<int>(hadithNumber.value);
    }
    if (textArabic.present) {
      map['text_arabic'] = Variable<String>(textArabic.value);
    }
    if (textEnglish.present) {
      map['text_english'] = Variable<String>(textEnglish.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedHadithsCompanion(')
          ..write('id: $id, ')
          ..write('collectionKey: $collectionKey, ')
          ..write('sectionNumber: $sectionNumber, ')
          ..write('hadithNumber: $hadithNumber, ')
          ..write('textArabic: $textArabic, ')
          ..write('textEnglish: $textEnglish')
          ..write(')'))
        .toString();
  }
}

class $CachedAzkarTable extends CachedAzkar
    with TableInfo<$CachedAzkarTable, CachedAzkarData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedAzkarTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryTitleMeta = const VerificationMeta(
    'categoryTitle',
  );
  @override
  late final GeneratedColumn<String> categoryTitle = GeneratedColumn<String>(
    'category_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _arabicTextMeta = const VerificationMeta(
    'arabicText',
  );
  @override
  late final GeneratedColumn<String> arabicText = GeneratedColumn<String>(
    'arabic_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repeatCountMeta = const VerificationMeta(
    'repeatCount',
  );
  @override
  late final GeneratedColumn<int> repeatCount = GeneratedColumn<int>(
    'repeat_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _audioUrlMeta = const VerificationMeta(
    'audioUrl',
  );
  @override
  late final GeneratedColumn<String> audioUrl = GeneratedColumn<String>(
    'audio_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    categoryTitle,
    itemId,
    arabicText,
    repeatCount,
    audioUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_azkar';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedAzkarData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('category_title')) {
      context.handle(
        _categoryTitleMeta,
        categoryTitle.isAcceptableOrUnknown(
          data['category_title']!,
          _categoryTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_categoryTitleMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('arabic_text')) {
      context.handle(
        _arabicTextMeta,
        arabicText.isAcceptableOrUnknown(data['arabic_text']!, _arabicTextMeta),
      );
    } else if (isInserting) {
      context.missing(_arabicTextMeta);
    }
    if (data.containsKey('repeat_count')) {
      context.handle(
        _repeatCountMeta,
        repeatCount.isAcceptableOrUnknown(
          data['repeat_count']!,
          _repeatCountMeta,
        ),
      );
    }
    if (data.containsKey('audio_url')) {
      context.handle(
        _audioUrlMeta,
        audioUrl.isAcceptableOrUnknown(data['audio_url']!, _audioUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {categoryId, itemId},
  ];
  @override
  CachedAzkarData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedAzkarData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      categoryId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}category_id'],
          )!,
      categoryTitle:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category_title'],
          )!,
      itemId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}item_id'],
          )!,
      arabicText:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}arabic_text'],
          )!,
      repeatCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}repeat_count'],
          )!,
      audioUrl:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}audio_url'],
          )!,
    );
  }

  @override
  $CachedAzkarTable createAlias(String alias) {
    return $CachedAzkarTable(attachedDatabase, alias);
  }
}

class CachedAzkarData extends DataClass implements Insertable<CachedAzkarData> {
  final int id;
  final int categoryId;
  final String categoryTitle;
  final int itemId;
  final String arabicText;
  final int repeatCount;
  final String audioUrl;
  const CachedAzkarData({
    required this.id,
    required this.categoryId,
    required this.categoryTitle,
    required this.itemId,
    required this.arabicText,
    required this.repeatCount,
    required this.audioUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['category_title'] = Variable<String>(categoryTitle);
    map['item_id'] = Variable<int>(itemId);
    map['arabic_text'] = Variable<String>(arabicText);
    map['repeat_count'] = Variable<int>(repeatCount);
    map['audio_url'] = Variable<String>(audioUrl);
    return map;
  }

  CachedAzkarCompanion toCompanion(bool nullToAbsent) {
    return CachedAzkarCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      categoryTitle: Value(categoryTitle),
      itemId: Value(itemId),
      arabicText: Value(arabicText),
      repeatCount: Value(repeatCount),
      audioUrl: Value(audioUrl),
    );
  }

  factory CachedAzkarData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedAzkarData(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      categoryTitle: serializer.fromJson<String>(json['categoryTitle']),
      itemId: serializer.fromJson<int>(json['itemId']),
      arabicText: serializer.fromJson<String>(json['arabicText']),
      repeatCount: serializer.fromJson<int>(json['repeatCount']),
      audioUrl: serializer.fromJson<String>(json['audioUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'categoryTitle': serializer.toJson<String>(categoryTitle),
      'itemId': serializer.toJson<int>(itemId),
      'arabicText': serializer.toJson<String>(arabicText),
      'repeatCount': serializer.toJson<int>(repeatCount),
      'audioUrl': serializer.toJson<String>(audioUrl),
    };
  }

  CachedAzkarData copyWith({
    int? id,
    int? categoryId,
    String? categoryTitle,
    int? itemId,
    String? arabicText,
    int? repeatCount,
    String? audioUrl,
  }) => CachedAzkarData(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    categoryTitle: categoryTitle ?? this.categoryTitle,
    itemId: itemId ?? this.itemId,
    arabicText: arabicText ?? this.arabicText,
    repeatCount: repeatCount ?? this.repeatCount,
    audioUrl: audioUrl ?? this.audioUrl,
  );
  CachedAzkarData copyWithCompanion(CachedAzkarCompanion data) {
    return CachedAzkarData(
      id: data.id.present ? data.id.value : this.id,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      categoryTitle:
          data.categoryTitle.present
              ? data.categoryTitle.value
              : this.categoryTitle,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      arabicText:
          data.arabicText.present ? data.arabicText.value : this.arabicText,
      repeatCount:
          data.repeatCount.present ? data.repeatCount.value : this.repeatCount,
      audioUrl: data.audioUrl.present ? data.audioUrl.value : this.audioUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedAzkarData(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('categoryTitle: $categoryTitle, ')
          ..write('itemId: $itemId, ')
          ..write('arabicText: $arabicText, ')
          ..write('repeatCount: $repeatCount, ')
          ..write('audioUrl: $audioUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    categoryTitle,
    itemId,
    arabicText,
    repeatCount,
    audioUrl,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedAzkarData &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.categoryTitle == this.categoryTitle &&
          other.itemId == this.itemId &&
          other.arabicText == this.arabicText &&
          other.repeatCount == this.repeatCount &&
          other.audioUrl == this.audioUrl);
}

class CachedAzkarCompanion extends UpdateCompanion<CachedAzkarData> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<String> categoryTitle;
  final Value<int> itemId;
  final Value<String> arabicText;
  final Value<int> repeatCount;
  final Value<String> audioUrl;
  const CachedAzkarCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.categoryTitle = const Value.absent(),
    this.itemId = const Value.absent(),
    this.arabicText = const Value.absent(),
    this.repeatCount = const Value.absent(),
    this.audioUrl = const Value.absent(),
  });
  CachedAzkarCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required String categoryTitle,
    required int itemId,
    required String arabicText,
    this.repeatCount = const Value.absent(),
    this.audioUrl = const Value.absent(),
  }) : categoryId = Value(categoryId),
       categoryTitle = Value(categoryTitle),
       itemId = Value(itemId),
       arabicText = Value(arabicText);
  static Insertable<CachedAzkarData> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? categoryTitle,
    Expression<int>? itemId,
    Expression<String>? arabicText,
    Expression<int>? repeatCount,
    Expression<String>? audioUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (categoryTitle != null) 'category_title': categoryTitle,
      if (itemId != null) 'item_id': itemId,
      if (arabicText != null) 'arabic_text': arabicText,
      if (repeatCount != null) 'repeat_count': repeatCount,
      if (audioUrl != null) 'audio_url': audioUrl,
    });
  }

  CachedAzkarCompanion copyWith({
    Value<int>? id,
    Value<int>? categoryId,
    Value<String>? categoryTitle,
    Value<int>? itemId,
    Value<String>? arabicText,
    Value<int>? repeatCount,
    Value<String>? audioUrl,
  }) {
    return CachedAzkarCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      categoryTitle: categoryTitle ?? this.categoryTitle,
      itemId: itemId ?? this.itemId,
      arabicText: arabicText ?? this.arabicText,
      repeatCount: repeatCount ?? this.repeatCount,
      audioUrl: audioUrl ?? this.audioUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (categoryTitle.present) {
      map['category_title'] = Variable<String>(categoryTitle.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (arabicText.present) {
      map['arabic_text'] = Variable<String>(arabicText.value);
    }
    if (repeatCount.present) {
      map['repeat_count'] = Variable<int>(repeatCount.value);
    }
    if (audioUrl.present) {
      map['audio_url'] = Variable<String>(audioUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedAzkarCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('categoryTitle: $categoryTitle, ')
          ..write('itemId: $itemId, ')
          ..write('arabicText: $arabicText, ')
          ..write('repeatCount: $repeatCount, ')
          ..write('audioUrl: $audioUrl')
          ..write(')'))
        .toString();
  }
}

class $AyahBookmarksTable extends AyahBookmarks
    with TableInfo<$AyahBookmarksTable, AyahBookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AyahBookmarksTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _surahIdMeta = const VerificationMeta(
    'surahId',
  );
  @override
  late final GeneratedColumn<int> surahId = GeneratedColumn<int>(
    'surah_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES surahs (id)',
    ),
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, surahId, ayahNumber, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ayah_bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<AyahBookmark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_id')) {
      context.handle(
        _surahIdMeta,
        surahId.isAcceptableOrUnknown(data['surah_id']!, _surahIdMeta),
      );
    } else if (isInserting) {
      context.missing(_surahIdMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {surahId, ayahNumber},
  ];
  @override
  AyahBookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AyahBookmark(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      surahId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}surah_id'],
          )!,
      ayahNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}ayah_number'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $AyahBookmarksTable createAlias(String alias) {
    return $AyahBookmarksTable(attachedDatabase, alias);
  }
}

class AyahBookmark extends DataClass implements Insertable<AyahBookmark> {
  final int id;
  final int surahId;
  final int ayahNumber;
  final DateTime createdAt;
  const AyahBookmark({
    required this.id,
    required this.surahId,
    required this.ayahNumber,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_id'] = Variable<int>(surahId);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AyahBookmarksCompanion toCompanion(bool nullToAbsent) {
    return AyahBookmarksCompanion(
      id: Value(id),
      surahId: Value(surahId),
      ayahNumber: Value(ayahNumber),
      createdAt: Value(createdAt),
    );
  }

  factory AyahBookmark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AyahBookmark(
      id: serializer.fromJson<int>(json['id']),
      surahId: serializer.fromJson<int>(json['surahId']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahId': serializer.toJson<int>(surahId),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AyahBookmark copyWith({
    int? id,
    int? surahId,
    int? ayahNumber,
    DateTime? createdAt,
  }) => AyahBookmark(
    id: id ?? this.id,
    surahId: surahId ?? this.surahId,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    createdAt: createdAt ?? this.createdAt,
  );
  AyahBookmark copyWithCompanion(AyahBookmarksCompanion data) {
    return AyahBookmark(
      id: data.id.present ? data.id.value : this.id,
      surahId: data.surahId.present ? data.surahId.value : this.surahId,
      ayahNumber:
          data.ayahNumber.present ? data.ayahNumber.value : this.ayahNumber,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AyahBookmark(')
          ..write('id: $id, ')
          ..write('surahId: $surahId, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, surahId, ayahNumber, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AyahBookmark &&
          other.id == this.id &&
          other.surahId == this.surahId &&
          other.ayahNumber == this.ayahNumber &&
          other.createdAt == this.createdAt);
}

class AyahBookmarksCompanion extends UpdateCompanion<AyahBookmark> {
  final Value<int> id;
  final Value<int> surahId;
  final Value<int> ayahNumber;
  final Value<DateTime> createdAt;
  const AyahBookmarksCompanion({
    this.id = const Value.absent(),
    this.surahId = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AyahBookmarksCompanion.insert({
    this.id = const Value.absent(),
    required int surahId,
    required int ayahNumber,
    required DateTime createdAt,
  }) : surahId = Value(surahId),
       ayahNumber = Value(ayahNumber),
       createdAt = Value(createdAt);
  static Insertable<AyahBookmark> custom({
    Expression<int>? id,
    Expression<int>? surahId,
    Expression<int>? ayahNumber,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahId != null) 'surah_id': surahId,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AyahBookmarksCompanion copyWith({
    Value<int>? id,
    Value<int>? surahId,
    Value<int>? ayahNumber,
    Value<DateTime>? createdAt,
  }) {
    return AyahBookmarksCompanion(
      id: id ?? this.id,
      surahId: surahId ?? this.surahId,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahId.present) {
      map['surah_id'] = Variable<int>(surahId.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AyahBookmarksCompanion(')
          ..write('id: $id, ')
          ..write('surahId: $surahId, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SurahsTable surahs = $SurahsTable(this);
  late final $AyahsTable ayahs = $AyahsTable(this);
  late final $AyahTranslationsTable ayahTranslations = $AyahTranslationsTable(
    this,
  );
  late final $RecitersTable reciters = $RecitersTable(this);
  late final $DownloadedAudioTable downloadedAudio = $DownloadedAudioTable(
    this,
  );
  late final $UserNotesTable userNotes = $UserNotesTable(this);
  late final $ReadingProgressTable readingProgress = $ReadingProgressTable(
    this,
  );
  late final $LessonProgressTable lessonProgress = $LessonProgressTable(this);
  late final $UserStreaksTable userStreaks = $UserStreaksTable(this);
  late final $AchievementsTable achievements = $AchievementsTable(this);
  late final $RecordingSessionsTable recordingSessions =
      $RecordingSessionsTable(this);
  late final $DailyActivityLogTable dailyActivityLog = $DailyActivityLogTable(
    this,
  );
  late final $CachedHadithSectionsTable cachedHadithSections =
      $CachedHadithSectionsTable(this);
  late final $CachedHadithsTable cachedHadiths = $CachedHadithsTable(this);
  late final $CachedAzkarTable cachedAzkar = $CachedAzkarTable(this);
  late final $AyahBookmarksTable ayahBookmarks = $AyahBookmarksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    surahs,
    ayahs,
    ayahTranslations,
    reciters,
    downloadedAudio,
    userNotes,
    readingProgress,
    lessonProgress,
    userStreaks,
    achievements,
    recordingSessions,
    dailyActivityLog,
    cachedHadithSections,
    cachedHadiths,
    cachedAzkar,
    ayahBookmarks,
  ];
}

typedef $$SurahsTableCreateCompanionBuilder =
    SurahsCompanion Function({
      Value<int> id,
      required String nameArabic,
      required String nameEnglish,
      required String nameTransliteration,
      required int ayahCount,
      required String revelationType,
      required int revelationOrder,
      Value<int> juzStart,
    });
typedef $$SurahsTableUpdateCompanionBuilder =
    SurahsCompanion Function({
      Value<int> id,
      Value<String> nameArabic,
      Value<String> nameEnglish,
      Value<String> nameTransliteration,
      Value<int> ayahCount,
      Value<String> revelationType,
      Value<int> revelationOrder,
      Value<int> juzStart,
    });

final class $$SurahsTableReferences
    extends BaseReferences<_$AppDatabase, $SurahsTable, Surah> {
  $$SurahsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AyahsTable, List<Ayah>> _ayahsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.ayahs,
    aliasName: $_aliasNameGenerator(db.surahs.id, db.ayahs.surahId),
  );

  $$AyahsTableProcessedTableManager get ayahsRefs {
    final manager = $$AyahsTableTableManager(
      $_db,
      $_db.ayahs,
    ).filter((f) => f.surahId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ayahsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AyahTranslationsTable, List<AyahTranslation>>
  _ayahTranslationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ayahTranslations,
    aliasName: $_aliasNameGenerator(db.surahs.id, db.ayahTranslations.surahId),
  );

  $$AyahTranslationsTableProcessedTableManager get ayahTranslationsRefs {
    final manager = $$AyahTranslationsTableTableManager(
      $_db,
      $_db.ayahTranslations,
    ).filter((f) => f.surahId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _ayahTranslationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DownloadedAudioTable, List<DownloadedAudioData>>
  _downloadedAudioRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.downloadedAudio,
    aliasName: $_aliasNameGenerator(db.surahs.id, db.downloadedAudio.surahId),
  );

  $$DownloadedAudioTableProcessedTableManager get downloadedAudioRefs {
    final manager = $$DownloadedAudioTableTableManager(
      $_db,
      $_db.downloadedAudio,
    ).filter((f) => f.surahId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _downloadedAudioRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UserNotesTable, List<UserNote>>
  _userNotesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userNotes,
    aliasName: $_aliasNameGenerator(db.surahs.id, db.userNotes.surahId),
  );

  $$UserNotesTableProcessedTableManager get userNotesRefs {
    final manager = $$UserNotesTableTableManager(
      $_db,
      $_db.userNotes,
    ).filter((f) => f.surahId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_userNotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReadingProgressTable, List<ReadingProgressData>>
  _readingProgressRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.readingProgress,
    aliasName: $_aliasNameGenerator(db.surahs.id, db.readingProgress.surahId),
  );

  $$ReadingProgressTableProcessedTableManager get readingProgressRefs {
    final manager = $$ReadingProgressTableTableManager(
      $_db,
      $_db.readingProgress,
    ).filter((f) => f.surahId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _readingProgressRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AyahBookmarksTable, List<AyahBookmark>>
  _ayahBookmarksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ayahBookmarks,
    aliasName: $_aliasNameGenerator(db.surahs.id, db.ayahBookmarks.surahId),
  );

  $$AyahBookmarksTableProcessedTableManager get ayahBookmarksRefs {
    final manager = $$AyahBookmarksTableTableManager(
      $_db,
      $_db.ayahBookmarks,
    ).filter((f) => f.surahId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ayahBookmarksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SurahsTableFilterComposer
    extends Composer<_$AppDatabase, $SurahsTable> {
  $$SurahsTableFilterComposer({
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

  ColumnFilters<int> get juzStart => $composableBuilder(
    column: $table.juzStart,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ayahsRefs(
    Expression<bool> Function($$AyahsTableFilterComposer f) f,
  ) {
    final $$AyahsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ayahs,
      getReferencedColumn: (t) => t.surahId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AyahsTableFilterComposer(
            $db: $db,
            $table: $db.ayahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ayahTranslationsRefs(
    Expression<bool> Function($$AyahTranslationsTableFilterComposer f) f,
  ) {
    final $$AyahTranslationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ayahTranslations,
      getReferencedColumn: (t) => t.surahId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AyahTranslationsTableFilterComposer(
            $db: $db,
            $table: $db.ayahTranslations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> downloadedAudioRefs(
    Expression<bool> Function($$DownloadedAudioTableFilterComposer f) f,
  ) {
    final $$DownloadedAudioTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.downloadedAudio,
      getReferencedColumn: (t) => t.surahId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DownloadedAudioTableFilterComposer(
            $db: $db,
            $table: $db.downloadedAudio,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> userNotesRefs(
    Expression<bool> Function($$UserNotesTableFilterComposer f) f,
  ) {
    final $$UserNotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userNotes,
      getReferencedColumn: (t) => t.surahId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserNotesTableFilterComposer(
            $db: $db,
            $table: $db.userNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> readingProgressRefs(
    Expression<bool> Function($$ReadingProgressTableFilterComposer f) f,
  ) {
    final $$ReadingProgressTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.readingProgress,
      getReferencedColumn: (t) => t.surahId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingProgressTableFilterComposer(
            $db: $db,
            $table: $db.readingProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ayahBookmarksRefs(
    Expression<bool> Function($$AyahBookmarksTableFilterComposer f) f,
  ) {
    final $$AyahBookmarksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ayahBookmarks,
      getReferencedColumn: (t) => t.surahId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AyahBookmarksTableFilterComposer(
            $db: $db,
            $table: $db.ayahBookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SurahsTableOrderingComposer
    extends Composer<_$AppDatabase, $SurahsTable> {
  $$SurahsTableOrderingComposer({
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

  ColumnOrderings<int> get juzStart => $composableBuilder(
    column: $table.juzStart,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SurahsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SurahsTable> {
  $$SurahsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

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

  GeneratedColumn<int> get juzStart =>
      $composableBuilder(column: $table.juzStart, builder: (column) => column);

  Expression<T> ayahsRefs<T extends Object>(
    Expression<T> Function($$AyahsTableAnnotationComposer a) f,
  ) {
    final $$AyahsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ayahs,
      getReferencedColumn: (t) => t.surahId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AyahsTableAnnotationComposer(
            $db: $db,
            $table: $db.ayahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> ayahTranslationsRefs<T extends Object>(
    Expression<T> Function($$AyahTranslationsTableAnnotationComposer a) f,
  ) {
    final $$AyahTranslationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ayahTranslations,
      getReferencedColumn: (t) => t.surahId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AyahTranslationsTableAnnotationComposer(
            $db: $db,
            $table: $db.ayahTranslations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> downloadedAudioRefs<T extends Object>(
    Expression<T> Function($$DownloadedAudioTableAnnotationComposer a) f,
  ) {
    final $$DownloadedAudioTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.downloadedAudio,
      getReferencedColumn: (t) => t.surahId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DownloadedAudioTableAnnotationComposer(
            $db: $db,
            $table: $db.downloadedAudio,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> userNotesRefs<T extends Object>(
    Expression<T> Function($$UserNotesTableAnnotationComposer a) f,
  ) {
    final $$UserNotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userNotes,
      getReferencedColumn: (t) => t.surahId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserNotesTableAnnotationComposer(
            $db: $db,
            $table: $db.userNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> readingProgressRefs<T extends Object>(
    Expression<T> Function($$ReadingProgressTableAnnotationComposer a) f,
  ) {
    final $$ReadingProgressTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.readingProgress,
      getReferencedColumn: (t) => t.surahId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingProgressTableAnnotationComposer(
            $db: $db,
            $table: $db.readingProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> ayahBookmarksRefs<T extends Object>(
    Expression<T> Function($$AyahBookmarksTableAnnotationComposer a) f,
  ) {
    final $$AyahBookmarksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ayahBookmarks,
      getReferencedColumn: (t) => t.surahId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AyahBookmarksTableAnnotationComposer(
            $db: $db,
            $table: $db.ayahBookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SurahsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SurahsTable,
          Surah,
          $$SurahsTableFilterComposer,
          $$SurahsTableOrderingComposer,
          $$SurahsTableAnnotationComposer,
          $$SurahsTableCreateCompanionBuilder,
          $$SurahsTableUpdateCompanionBuilder,
          (Surah, $$SurahsTableReferences),
          Surah,
          PrefetchHooks Function({
            bool ayahsRefs,
            bool ayahTranslationsRefs,
            bool downloadedAudioRefs,
            bool userNotesRefs,
            bool readingProgressRefs,
            bool ayahBookmarksRefs,
          })
        > {
  $$SurahsTableTableManager(_$AppDatabase db, $SurahsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SurahsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SurahsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SurahsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nameArabic = const Value.absent(),
                Value<String> nameEnglish = const Value.absent(),
                Value<String> nameTransliteration = const Value.absent(),
                Value<int> ayahCount = const Value.absent(),
                Value<String> revelationType = const Value.absent(),
                Value<int> revelationOrder = const Value.absent(),
                Value<int> juzStart = const Value.absent(),
              }) => SurahsCompanion(
                id: id,
                nameArabic: nameArabic,
                nameEnglish: nameEnglish,
                nameTransliteration: nameTransliteration,
                ayahCount: ayahCount,
                revelationType: revelationType,
                revelationOrder: revelationOrder,
                juzStart: juzStart,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nameArabic,
                required String nameEnglish,
                required String nameTransliteration,
                required int ayahCount,
                required String revelationType,
                required int revelationOrder,
                Value<int> juzStart = const Value.absent(),
              }) => SurahsCompanion.insert(
                id: id,
                nameArabic: nameArabic,
                nameEnglish: nameEnglish,
                nameTransliteration: nameTransliteration,
                ayahCount: ayahCount,
                revelationType: revelationType,
                revelationOrder: revelationOrder,
                juzStart: juzStart,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$SurahsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            ayahsRefs = false,
            ayahTranslationsRefs = false,
            downloadedAudioRefs = false,
            userNotesRefs = false,
            readingProgressRefs = false,
            ayahBookmarksRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (ayahsRefs) db.ayahs,
                if (ayahTranslationsRefs) db.ayahTranslations,
                if (downloadedAudioRefs) db.downloadedAudio,
                if (userNotesRefs) db.userNotes,
                if (readingProgressRefs) db.readingProgress,
                if (ayahBookmarksRefs) db.ayahBookmarks,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ayahsRefs)
                    await $_getPrefetchedData<Surah, $SurahsTable, Ayah>(
                      currentTable: table,
                      referencedTable: $$SurahsTableReferences._ayahsRefsTable(
                        db,
                      ),
                      managerFromTypedResult:
                          (p0) =>
                              $$SurahsTableReferences(db, table, p0).ayahsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.surahId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (ayahTranslationsRefs)
                    await $_getPrefetchedData<
                      Surah,
                      $SurahsTable,
                      AyahTranslation
                    >(
                      currentTable: table,
                      referencedTable: $$SurahsTableReferences
                          ._ayahTranslationsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$SurahsTableReferences(
                                db,
                                table,
                                p0,
                              ).ayahTranslationsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.surahId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (downloadedAudioRefs)
                    await $_getPrefetchedData<
                      Surah,
                      $SurahsTable,
                      DownloadedAudioData
                    >(
                      currentTable: table,
                      referencedTable: $$SurahsTableReferences
                          ._downloadedAudioRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$SurahsTableReferences(
                                db,
                                table,
                                p0,
                              ).downloadedAudioRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.surahId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (userNotesRefs)
                    await $_getPrefetchedData<Surah, $SurahsTable, UserNote>(
                      currentTable: table,
                      referencedTable: $$SurahsTableReferences
                          ._userNotesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$SurahsTableReferences(
                                db,
                                table,
                                p0,
                              ).userNotesRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.surahId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (readingProgressRefs)
                    await $_getPrefetchedData<
                      Surah,
                      $SurahsTable,
                      ReadingProgressData
                    >(
                      currentTable: table,
                      referencedTable: $$SurahsTableReferences
                          ._readingProgressRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$SurahsTableReferences(
                                db,
                                table,
                                p0,
                              ).readingProgressRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.surahId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (ayahBookmarksRefs)
                    await $_getPrefetchedData<
                      Surah,
                      $SurahsTable,
                      AyahBookmark
                    >(
                      currentTable: table,
                      referencedTable: $$SurahsTableReferences
                          ._ayahBookmarksRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$SurahsTableReferences(
                                db,
                                table,
                                p0,
                              ).ayahBookmarksRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.surahId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SurahsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SurahsTable,
      Surah,
      $$SurahsTableFilterComposer,
      $$SurahsTableOrderingComposer,
      $$SurahsTableAnnotationComposer,
      $$SurahsTableCreateCompanionBuilder,
      $$SurahsTableUpdateCompanionBuilder,
      (Surah, $$SurahsTableReferences),
      Surah,
      PrefetchHooks Function({
        bool ayahsRefs,
        bool ayahTranslationsRefs,
        bool downloadedAudioRefs,
        bool userNotesRefs,
        bool readingProgressRefs,
        bool ayahBookmarksRefs,
      })
    >;
typedef $$AyahsTableCreateCompanionBuilder =
    AyahsCompanion Function({
      Value<int> id,
      required int surahId,
      required int ayahNumber,
      required String textUthmani,
      Value<String?> textUthmaniTajweed,
      required int juzNumber,
      required int hizbQuarter,
      required int pageNumber,
    });
typedef $$AyahsTableUpdateCompanionBuilder =
    AyahsCompanion Function({
      Value<int> id,
      Value<int> surahId,
      Value<int> ayahNumber,
      Value<String> textUthmani,
      Value<String?> textUthmaniTajweed,
      Value<int> juzNumber,
      Value<int> hizbQuarter,
      Value<int> pageNumber,
    });

final class $$AyahsTableReferences
    extends BaseReferences<_$AppDatabase, $AyahsTable, Ayah> {
  $$AyahsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SurahsTable _surahIdTable(_$AppDatabase db) => db.surahs.createAlias(
    $_aliasNameGenerator(db.ayahs.surahId, db.surahs.id),
  );

  $$SurahsTableProcessedTableManager get surahId {
    final $_column = $_itemColumn<int>('surah_id')!;

    final manager = $$SurahsTableTableManager(
      $_db,
      $_db.surahs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_surahIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AyahsTableFilterComposer extends Composer<_$AppDatabase, $AyahsTable> {
  $$AyahsTableFilterComposer({
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

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textUthmani => $composableBuilder(
    column: $table.textUthmani,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textUthmaniTajweed => $composableBuilder(
    column: $table.textUthmaniTajweed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get juzNumber => $composableBuilder(
    column: $table.juzNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hizbQuarter => $composableBuilder(
    column: $table.hizbQuarter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => ColumnFilters(column),
  );

  $$SurahsTableFilterComposer get surahId {
    final $$SurahsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableFilterComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AyahsTableOrderingComposer
    extends Composer<_$AppDatabase, $AyahsTable> {
  $$AyahsTableOrderingComposer({
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

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textUthmani => $composableBuilder(
    column: $table.textUthmani,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textUthmaniTajweed => $composableBuilder(
    column: $table.textUthmaniTajweed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get juzNumber => $composableBuilder(
    column: $table.juzNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hizbQuarter => $composableBuilder(
    column: $table.hizbQuarter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => ColumnOrderings(column),
  );

  $$SurahsTableOrderingComposer get surahId {
    final $$SurahsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableOrderingComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AyahsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AyahsTable> {
  $$AyahsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get textUthmani => $composableBuilder(
    column: $table.textUthmani,
    builder: (column) => column,
  );

  GeneratedColumn<String> get textUthmaniTajweed => $composableBuilder(
    column: $table.textUthmaniTajweed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get juzNumber =>
      $composableBuilder(column: $table.juzNumber, builder: (column) => column);

  GeneratedColumn<int> get hizbQuarter => $composableBuilder(
    column: $table.hizbQuarter,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => column,
  );

  $$SurahsTableAnnotationComposer get surahId {
    final $$SurahsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableAnnotationComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AyahsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AyahsTable,
          Ayah,
          $$AyahsTableFilterComposer,
          $$AyahsTableOrderingComposer,
          $$AyahsTableAnnotationComposer,
          $$AyahsTableCreateCompanionBuilder,
          $$AyahsTableUpdateCompanionBuilder,
          (Ayah, $$AyahsTableReferences),
          Ayah,
          PrefetchHooks Function({bool surahId})
        > {
  $$AyahsTableTableManager(_$AppDatabase db, $AyahsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AyahsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AyahsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$AyahsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> surahId = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<String> textUthmani = const Value.absent(),
                Value<String?> textUthmaniTajweed = const Value.absent(),
                Value<int> juzNumber = const Value.absent(),
                Value<int> hizbQuarter = const Value.absent(),
                Value<int> pageNumber = const Value.absent(),
              }) => AyahsCompanion(
                id: id,
                surahId: surahId,
                ayahNumber: ayahNumber,
                textUthmani: textUthmani,
                textUthmaniTajweed: textUthmaniTajweed,
                juzNumber: juzNumber,
                hizbQuarter: hizbQuarter,
                pageNumber: pageNumber,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int surahId,
                required int ayahNumber,
                required String textUthmani,
                Value<String?> textUthmaniTajweed = const Value.absent(),
                required int juzNumber,
                required int hizbQuarter,
                required int pageNumber,
              }) => AyahsCompanion.insert(
                id: id,
                surahId: surahId,
                ayahNumber: ayahNumber,
                textUthmani: textUthmani,
                textUthmaniTajweed: textUthmaniTajweed,
                juzNumber: juzNumber,
                hizbQuarter: hizbQuarter,
                pageNumber: pageNumber,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$AyahsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({surahId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (surahId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.surahId,
                            referencedTable: $$AyahsTableReferences
                                ._surahIdTable(db),
                            referencedColumn:
                                $$AyahsTableReferences._surahIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AyahsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AyahsTable,
      Ayah,
      $$AyahsTableFilterComposer,
      $$AyahsTableOrderingComposer,
      $$AyahsTableAnnotationComposer,
      $$AyahsTableCreateCompanionBuilder,
      $$AyahsTableUpdateCompanionBuilder,
      (Ayah, $$AyahsTableReferences),
      Ayah,
      PrefetchHooks Function({bool surahId})
    >;
typedef $$AyahTranslationsTableCreateCompanionBuilder =
    AyahTranslationsCompanion Function({
      Value<int> id,
      required int surahId,
      required int ayahNumber,
      required String translationText,
      required String languageCode,
      required String translatorName,
      required int resourceId,
    });
typedef $$AyahTranslationsTableUpdateCompanionBuilder =
    AyahTranslationsCompanion Function({
      Value<int> id,
      Value<int> surahId,
      Value<int> ayahNumber,
      Value<String> translationText,
      Value<String> languageCode,
      Value<String> translatorName,
      Value<int> resourceId,
    });

final class $$AyahTranslationsTableReferences
    extends
        BaseReferences<_$AppDatabase, $AyahTranslationsTable, AyahTranslation> {
  $$AyahTranslationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SurahsTable _surahIdTable(_$AppDatabase db) => db.surahs.createAlias(
    $_aliasNameGenerator(db.ayahTranslations.surahId, db.surahs.id),
  );

  $$SurahsTableProcessedTableManager get surahId {
    final $_column = $_itemColumn<int>('surah_id')!;

    final manager = $$SurahsTableTableManager(
      $_db,
      $_db.surahs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_surahIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AyahTranslationsTableFilterComposer
    extends Composer<_$AppDatabase, $AyahTranslationsTable> {
  $$AyahTranslationsTableFilterComposer({
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

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translationText => $composableBuilder(
    column: $table.translationText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translatorName => $composableBuilder(
    column: $table.translatorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get resourceId => $composableBuilder(
    column: $table.resourceId,
    builder: (column) => ColumnFilters(column),
  );

  $$SurahsTableFilterComposer get surahId {
    final $$SurahsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableFilterComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AyahTranslationsTableOrderingComposer
    extends Composer<_$AppDatabase, $AyahTranslationsTable> {
  $$AyahTranslationsTableOrderingComposer({
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

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translationText => $composableBuilder(
    column: $table.translationText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translatorName => $composableBuilder(
    column: $table.translatorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get resourceId => $composableBuilder(
    column: $table.resourceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$SurahsTableOrderingComposer get surahId {
    final $$SurahsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableOrderingComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AyahTranslationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AyahTranslationsTable> {
  $$AyahTranslationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get translationText => $composableBuilder(
    column: $table.translationText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get translatorName => $composableBuilder(
    column: $table.translatorName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get resourceId => $composableBuilder(
    column: $table.resourceId,
    builder: (column) => column,
  );

  $$SurahsTableAnnotationComposer get surahId {
    final $$SurahsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableAnnotationComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AyahTranslationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AyahTranslationsTable,
          AyahTranslation,
          $$AyahTranslationsTableFilterComposer,
          $$AyahTranslationsTableOrderingComposer,
          $$AyahTranslationsTableAnnotationComposer,
          $$AyahTranslationsTableCreateCompanionBuilder,
          $$AyahTranslationsTableUpdateCompanionBuilder,
          (AyahTranslation, $$AyahTranslationsTableReferences),
          AyahTranslation,
          PrefetchHooks Function({bool surahId})
        > {
  $$AyahTranslationsTableTableManager(
    _$AppDatabase db,
    $AyahTranslationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$AyahTranslationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AyahTranslationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$AyahTranslationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> surahId = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<String> translationText = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<String> translatorName = const Value.absent(),
                Value<int> resourceId = const Value.absent(),
              }) => AyahTranslationsCompanion(
                id: id,
                surahId: surahId,
                ayahNumber: ayahNumber,
                translationText: translationText,
                languageCode: languageCode,
                translatorName: translatorName,
                resourceId: resourceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int surahId,
                required int ayahNumber,
                required String translationText,
                required String languageCode,
                required String translatorName,
                required int resourceId,
              }) => AyahTranslationsCompanion.insert(
                id: id,
                surahId: surahId,
                ayahNumber: ayahNumber,
                translationText: translationText,
                languageCode: languageCode,
                translatorName: translatorName,
                resourceId: resourceId,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$AyahTranslationsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({surahId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (surahId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.surahId,
                            referencedTable: $$AyahTranslationsTableReferences
                                ._surahIdTable(db),
                            referencedColumn:
                                $$AyahTranslationsTableReferences
                                    ._surahIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AyahTranslationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AyahTranslationsTable,
      AyahTranslation,
      $$AyahTranslationsTableFilterComposer,
      $$AyahTranslationsTableOrderingComposer,
      $$AyahTranslationsTableAnnotationComposer,
      $$AyahTranslationsTableCreateCompanionBuilder,
      $$AyahTranslationsTableUpdateCompanionBuilder,
      (AyahTranslation, $$AyahTranslationsTableReferences),
      AyahTranslation,
      PrefetchHooks Function({bool surahId})
    >;
typedef $$RecitersTableCreateCompanionBuilder =
    RecitersCompanion Function({
      Value<int> id,
      required String nameArabic,
      required String nameEnglish,
      Value<String> style,
      Value<String?> serverUrl,
      Value<String?> photoUrl,
    });
typedef $$RecitersTableUpdateCompanionBuilder =
    RecitersCompanion Function({
      Value<int> id,
      Value<String> nameArabic,
      Value<String> nameEnglish,
      Value<String> style,
      Value<String?> serverUrl,
      Value<String?> photoUrl,
    });

final class $$RecitersTableReferences
    extends BaseReferences<_$AppDatabase, $RecitersTable, Reciter> {
  $$RecitersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DownloadedAudioTable, List<DownloadedAudioData>>
  _downloadedAudioRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.downloadedAudio,
    aliasName: $_aliasNameGenerator(
      db.reciters.id,
      db.downloadedAudio.reciterId,
    ),
  );

  $$DownloadedAudioTableProcessedTableManager get downloadedAudioRefs {
    final manager = $$DownloadedAudioTableTableManager(
      $_db,
      $_db.downloadedAudio,
    ).filter((f) => f.reciterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _downloadedAudioRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RecitersTableFilterComposer
    extends Composer<_$AppDatabase, $RecitersTable> {
  $$RecitersTableFilterComposer({
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

  ColumnFilters<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEnglish => $composableBuilder(
    column: $table.nameEnglish,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get style => $composableBuilder(
    column: $table.style,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverUrl => $composableBuilder(
    column: $table.serverUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> downloadedAudioRefs(
    Expression<bool> Function($$DownloadedAudioTableFilterComposer f) f,
  ) {
    final $$DownloadedAudioTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.downloadedAudio,
      getReferencedColumn: (t) => t.reciterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DownloadedAudioTableFilterComposer(
            $db: $db,
            $table: $db.downloadedAudio,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecitersTableOrderingComposer
    extends Composer<_$AppDatabase, $RecitersTable> {
  $$RecitersTableOrderingComposer({
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

  ColumnOrderings<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEnglish => $composableBuilder(
    column: $table.nameEnglish,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get style => $composableBuilder(
    column: $table.style,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverUrl => $composableBuilder(
    column: $table.serverUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecitersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecitersTable> {
  $$RecitersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameEnglish => $composableBuilder(
    column: $table.nameEnglish,
    builder: (column) => column,
  );

  GeneratedColumn<String> get style =>
      $composableBuilder(column: $table.style, builder: (column) => column);

  GeneratedColumn<String> get serverUrl =>
      $composableBuilder(column: $table.serverUrl, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  Expression<T> downloadedAudioRefs<T extends Object>(
    Expression<T> Function($$DownloadedAudioTableAnnotationComposer a) f,
  ) {
    final $$DownloadedAudioTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.downloadedAudio,
      getReferencedColumn: (t) => t.reciterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DownloadedAudioTableAnnotationComposer(
            $db: $db,
            $table: $db.downloadedAudio,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecitersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecitersTable,
          Reciter,
          $$RecitersTableFilterComposer,
          $$RecitersTableOrderingComposer,
          $$RecitersTableAnnotationComposer,
          $$RecitersTableCreateCompanionBuilder,
          $$RecitersTableUpdateCompanionBuilder,
          (Reciter, $$RecitersTableReferences),
          Reciter,
          PrefetchHooks Function({bool downloadedAudioRefs})
        > {
  $$RecitersTableTableManager(_$AppDatabase db, $RecitersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RecitersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$RecitersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$RecitersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nameArabic = const Value.absent(),
                Value<String> nameEnglish = const Value.absent(),
                Value<String> style = const Value.absent(),
                Value<String?> serverUrl = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
              }) => RecitersCompanion(
                id: id,
                nameArabic: nameArabic,
                nameEnglish: nameEnglish,
                style: style,
                serverUrl: serverUrl,
                photoUrl: photoUrl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nameArabic,
                required String nameEnglish,
                Value<String> style = const Value.absent(),
                Value<String?> serverUrl = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
              }) => RecitersCompanion.insert(
                id: id,
                nameArabic: nameArabic,
                nameEnglish: nameEnglish,
                style: style,
                serverUrl: serverUrl,
                photoUrl: photoUrl,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$RecitersTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({downloadedAudioRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (downloadedAudioRefs) db.downloadedAudio,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (downloadedAudioRefs)
                    await $_getPrefetchedData<
                      Reciter,
                      $RecitersTable,
                      DownloadedAudioData
                    >(
                      currentTable: table,
                      referencedTable: $$RecitersTableReferences
                          ._downloadedAudioRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$RecitersTableReferences(
                                db,
                                table,
                                p0,
                              ).downloadedAudioRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.reciterId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RecitersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecitersTable,
      Reciter,
      $$RecitersTableFilterComposer,
      $$RecitersTableOrderingComposer,
      $$RecitersTableAnnotationComposer,
      $$RecitersTableCreateCompanionBuilder,
      $$RecitersTableUpdateCompanionBuilder,
      (Reciter, $$RecitersTableReferences),
      Reciter,
      PrefetchHooks Function({bool downloadedAudioRefs})
    >;
typedef $$DownloadedAudioTableCreateCompanionBuilder =
    DownloadedAudioCompanion Function({
      Value<int> id,
      required int reciterId,
      required int surahId,
      required String filePath,
      required int fileSize,
      required DateTime downloadedAt,
    });
typedef $$DownloadedAudioTableUpdateCompanionBuilder =
    DownloadedAudioCompanion Function({
      Value<int> id,
      Value<int> reciterId,
      Value<int> surahId,
      Value<String> filePath,
      Value<int> fileSize,
      Value<DateTime> downloadedAt,
    });

final class $$DownloadedAudioTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DownloadedAudioTable,
          DownloadedAudioData
        > {
  $$DownloadedAudioTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RecitersTable _reciterIdTable(_$AppDatabase db) =>
      db.reciters.createAlias(
        $_aliasNameGenerator(db.downloadedAudio.reciterId, db.reciters.id),
      );

  $$RecitersTableProcessedTableManager get reciterId {
    final $_column = $_itemColumn<int>('reciter_id')!;

    final manager = $$RecitersTableTableManager(
      $_db,
      $_db.reciters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reciterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SurahsTable _surahIdTable(_$AppDatabase db) => db.surahs.createAlias(
    $_aliasNameGenerator(db.downloadedAudio.surahId, db.surahs.id),
  );

  $$SurahsTableProcessedTableManager get surahId {
    final $_column = $_itemColumn<int>('surah_id')!;

    final manager = $$SurahsTableTableManager(
      $_db,
      $_db.surahs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_surahIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DownloadedAudioTableFilterComposer
    extends Composer<_$AppDatabase, $DownloadedAudioTable> {
  $$DownloadedAudioTableFilterComposer({
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

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get downloadedAt => $composableBuilder(
    column: $table.downloadedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$RecitersTableFilterComposer get reciterId {
    final $$RecitersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reciterId,
      referencedTable: $db.reciters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecitersTableFilterComposer(
            $db: $db,
            $table: $db.reciters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SurahsTableFilterComposer get surahId {
    final $$SurahsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableFilterComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DownloadedAudioTableOrderingComposer
    extends Composer<_$AppDatabase, $DownloadedAudioTable> {
  $$DownloadedAudioTableOrderingComposer({
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

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get downloadedAt => $composableBuilder(
    column: $table.downloadedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecitersTableOrderingComposer get reciterId {
    final $$RecitersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reciterId,
      referencedTable: $db.reciters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecitersTableOrderingComposer(
            $db: $db,
            $table: $db.reciters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SurahsTableOrderingComposer get surahId {
    final $$SurahsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableOrderingComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DownloadedAudioTableAnnotationComposer
    extends Composer<_$AppDatabase, $DownloadedAudioTable> {
  $$DownloadedAudioTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<int> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  GeneratedColumn<DateTime> get downloadedAt => $composableBuilder(
    column: $table.downloadedAt,
    builder: (column) => column,
  );

  $$RecitersTableAnnotationComposer get reciterId {
    final $$RecitersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reciterId,
      referencedTable: $db.reciters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecitersTableAnnotationComposer(
            $db: $db,
            $table: $db.reciters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SurahsTableAnnotationComposer get surahId {
    final $$SurahsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableAnnotationComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DownloadedAudioTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DownloadedAudioTable,
          DownloadedAudioData,
          $$DownloadedAudioTableFilterComposer,
          $$DownloadedAudioTableOrderingComposer,
          $$DownloadedAudioTableAnnotationComposer,
          $$DownloadedAudioTableCreateCompanionBuilder,
          $$DownloadedAudioTableUpdateCompanionBuilder,
          (DownloadedAudioData, $$DownloadedAudioTableReferences),
          DownloadedAudioData,
          PrefetchHooks Function({bool reciterId, bool surahId})
        > {
  $$DownloadedAudioTableTableManager(
    _$AppDatabase db,
    $DownloadedAudioTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$DownloadedAudioTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DownloadedAudioTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$DownloadedAudioTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> reciterId = const Value.absent(),
                Value<int> surahId = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<int> fileSize = const Value.absent(),
                Value<DateTime> downloadedAt = const Value.absent(),
              }) => DownloadedAudioCompanion(
                id: id,
                reciterId: reciterId,
                surahId: surahId,
                filePath: filePath,
                fileSize: fileSize,
                downloadedAt: downloadedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int reciterId,
                required int surahId,
                required String filePath,
                required int fileSize,
                required DateTime downloadedAt,
              }) => DownloadedAudioCompanion.insert(
                id: id,
                reciterId: reciterId,
                surahId: surahId,
                filePath: filePath,
                fileSize: fileSize,
                downloadedAt: downloadedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$DownloadedAudioTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({reciterId = false, surahId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (reciterId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.reciterId,
                            referencedTable: $$DownloadedAudioTableReferences
                                ._reciterIdTable(db),
                            referencedColumn:
                                $$DownloadedAudioTableReferences
                                    ._reciterIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (surahId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.surahId,
                            referencedTable: $$DownloadedAudioTableReferences
                                ._surahIdTable(db),
                            referencedColumn:
                                $$DownloadedAudioTableReferences
                                    ._surahIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DownloadedAudioTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DownloadedAudioTable,
      DownloadedAudioData,
      $$DownloadedAudioTableFilterComposer,
      $$DownloadedAudioTableOrderingComposer,
      $$DownloadedAudioTableAnnotationComposer,
      $$DownloadedAudioTableCreateCompanionBuilder,
      $$DownloadedAudioTableUpdateCompanionBuilder,
      (DownloadedAudioData, $$DownloadedAudioTableReferences),
      DownloadedAudioData,
      PrefetchHooks Function({bool reciterId, bool surahId})
    >;
typedef $$UserNotesTableCreateCompanionBuilder =
    UserNotesCompanion Function({
      Value<int> id,
      required int surahId,
      required int ayahNumber,
      required String content,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$UserNotesTableUpdateCompanionBuilder =
    UserNotesCompanion Function({
      Value<int> id,
      Value<int> surahId,
      Value<int> ayahNumber,
      Value<String> content,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$UserNotesTableReferences
    extends BaseReferences<_$AppDatabase, $UserNotesTable, UserNote> {
  $$UserNotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SurahsTable _surahIdTable(_$AppDatabase db) => db.surahs.createAlias(
    $_aliasNameGenerator(db.userNotes.surahId, db.surahs.id),
  );

  $$SurahsTableProcessedTableManager get surahId {
    final $_column = $_itemColumn<int>('surah_id')!;

    final manager = $$SurahsTableTableManager(
      $_db,
      $_db.surahs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_surahIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserNotesTableFilterComposer
    extends Composer<_$AppDatabase, $UserNotesTable> {
  $$UserNotesTableFilterComposer({
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

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SurahsTableFilterComposer get surahId {
    final $$SurahsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableFilterComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserNotesTable> {
  $$UserNotesTableOrderingComposer({
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

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SurahsTableOrderingComposer get surahId {
    final $$SurahsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableOrderingComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserNotesTable> {
  $$UserNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SurahsTableAnnotationComposer get surahId {
    final $$SurahsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableAnnotationComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserNotesTable,
          UserNote,
          $$UserNotesTableFilterComposer,
          $$UserNotesTableOrderingComposer,
          $$UserNotesTableAnnotationComposer,
          $$UserNotesTableCreateCompanionBuilder,
          $$UserNotesTableUpdateCompanionBuilder,
          (UserNote, $$UserNotesTableReferences),
          UserNote,
          PrefetchHooks Function({bool surahId})
        > {
  $$UserNotesTableTableManager(_$AppDatabase db, $UserNotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$UserNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UserNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$UserNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> surahId = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserNotesCompanion(
                id: id,
                surahId: surahId,
                ayahNumber: ayahNumber,
                content: content,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int surahId,
                required int ayahNumber,
                required String content,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => UserNotesCompanion.insert(
                id: id,
                surahId: surahId,
                ayahNumber: ayahNumber,
                content: content,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$UserNotesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({surahId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (surahId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.surahId,
                            referencedTable: $$UserNotesTableReferences
                                ._surahIdTable(db),
                            referencedColumn:
                                $$UserNotesTableReferences._surahIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserNotesTable,
      UserNote,
      $$UserNotesTableFilterComposer,
      $$UserNotesTableOrderingComposer,
      $$UserNotesTableAnnotationComposer,
      $$UserNotesTableCreateCompanionBuilder,
      $$UserNotesTableUpdateCompanionBuilder,
      (UserNote, $$UserNotesTableReferences),
      UserNote,
      PrefetchHooks Function({bool surahId})
    >;
typedef $$ReadingProgressTableCreateCompanionBuilder =
    ReadingProgressCompanion Function({
      Value<int> id,
      required int surahId,
      required int ayahNumber,
      required int pageNumber,
      required DateTime lastReadAt,
    });
typedef $$ReadingProgressTableUpdateCompanionBuilder =
    ReadingProgressCompanion Function({
      Value<int> id,
      Value<int> surahId,
      Value<int> ayahNumber,
      Value<int> pageNumber,
      Value<DateTime> lastReadAt,
    });

final class $$ReadingProgressTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ReadingProgressTable,
          ReadingProgressData
        > {
  $$ReadingProgressTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SurahsTable _surahIdTable(_$AppDatabase db) => db.surahs.createAlias(
    $_aliasNameGenerator(db.readingProgress.surahId, db.surahs.id),
  );

  $$SurahsTableProcessedTableManager get surahId {
    final $_column = $_itemColumn<int>('surah_id')!;

    final manager = $$SurahsTableTableManager(
      $_db,
      $_db.surahs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_surahIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReadingProgressTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingProgressTable> {
  $$ReadingProgressTableFilterComposer({
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

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReadAt => $composableBuilder(
    column: $table.lastReadAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SurahsTableFilterComposer get surahId {
    final $$SurahsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableFilterComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingProgressTable> {
  $$ReadingProgressTableOrderingComposer({
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

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReadAt => $composableBuilder(
    column: $table.lastReadAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SurahsTableOrderingComposer get surahId {
    final $$SurahsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableOrderingComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingProgressTable> {
  $$ReadingProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastReadAt => $composableBuilder(
    column: $table.lastReadAt,
    builder: (column) => column,
  );

  $$SurahsTableAnnotationComposer get surahId {
    final $$SurahsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableAnnotationComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadingProgressTable,
          ReadingProgressData,
          $$ReadingProgressTableFilterComposer,
          $$ReadingProgressTableOrderingComposer,
          $$ReadingProgressTableAnnotationComposer,
          $$ReadingProgressTableCreateCompanionBuilder,
          $$ReadingProgressTableUpdateCompanionBuilder,
          (ReadingProgressData, $$ReadingProgressTableReferences),
          ReadingProgressData,
          PrefetchHooks Function({bool surahId})
        > {
  $$ReadingProgressTableTableManager(
    _$AppDatabase db,
    $ReadingProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$ReadingProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ReadingProgressTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$ReadingProgressTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> surahId = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<int> pageNumber = const Value.absent(),
                Value<DateTime> lastReadAt = const Value.absent(),
              }) => ReadingProgressCompanion(
                id: id,
                surahId: surahId,
                ayahNumber: ayahNumber,
                pageNumber: pageNumber,
                lastReadAt: lastReadAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int surahId,
                required int ayahNumber,
                required int pageNumber,
                required DateTime lastReadAt,
              }) => ReadingProgressCompanion.insert(
                id: id,
                surahId: surahId,
                ayahNumber: ayahNumber,
                pageNumber: pageNumber,
                lastReadAt: lastReadAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$ReadingProgressTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({surahId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (surahId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.surahId,
                            referencedTable: $$ReadingProgressTableReferences
                                ._surahIdTable(db),
                            referencedColumn:
                                $$ReadingProgressTableReferences
                                    ._surahIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReadingProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadingProgressTable,
      ReadingProgressData,
      $$ReadingProgressTableFilterComposer,
      $$ReadingProgressTableOrderingComposer,
      $$ReadingProgressTableAnnotationComposer,
      $$ReadingProgressTableCreateCompanionBuilder,
      $$ReadingProgressTableUpdateCompanionBuilder,
      (ReadingProgressData, $$ReadingProgressTableReferences),
      ReadingProgressData,
      PrefetchHooks Function({bool surahId})
    >;
typedef $$LessonProgressTableCreateCompanionBuilder =
    LessonProgressCompanion Function({
      Value<int> id,
      required int lessonId,
      Value<bool> isCompleted,
      Value<int> bestQuizScore,
      Value<int> attemptCount,
      Value<DateTime?> completedAt,
      Value<DateTime?> lastAttemptAt,
    });
typedef $$LessonProgressTableUpdateCompanionBuilder =
    LessonProgressCompanion Function({
      Value<int> id,
      Value<int> lessonId,
      Value<bool> isCompleted,
      Value<int> bestQuizScore,
      Value<int> attemptCount,
      Value<DateTime?> completedAt,
      Value<DateTime?> lastAttemptAt,
    });

class $$LessonProgressTableFilterComposer
    extends Composer<_$AppDatabase, $LessonProgressTable> {
  $$LessonProgressTableFilterComposer({
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

  ColumnFilters<int> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bestQuizScore => $composableBuilder(
    column: $table.bestQuizScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LessonProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $LessonProgressTable> {
  $$LessonProgressTableOrderingComposer({
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

  ColumnOrderings<int> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bestQuizScore => $composableBuilder(
    column: $table.bestQuizScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LessonProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $LessonProgressTable> {
  $$LessonProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get lessonId =>
      $composableBuilder(column: $table.lessonId, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bestQuizScore => $composableBuilder(
    column: $table.bestQuizScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );
}

class $$LessonProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LessonProgressTable,
          LessonProgressData,
          $$LessonProgressTableFilterComposer,
          $$LessonProgressTableOrderingComposer,
          $$LessonProgressTableAnnotationComposer,
          $$LessonProgressTableCreateCompanionBuilder,
          $$LessonProgressTableUpdateCompanionBuilder,
          (
            LessonProgressData,
            BaseReferences<
              _$AppDatabase,
              $LessonProgressTable,
              LessonProgressData
            >,
          ),
          LessonProgressData,
          PrefetchHooks Function()
        > {
  $$LessonProgressTableTableManager(
    _$AppDatabase db,
    $LessonProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$LessonProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$LessonProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$LessonProgressTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> lessonId = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<int> bestQuizScore = const Value.absent(),
                Value<int> attemptCount = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
              }) => LessonProgressCompanion(
                id: id,
                lessonId: lessonId,
                isCompleted: isCompleted,
                bestQuizScore: bestQuizScore,
                attemptCount: attemptCount,
                completedAt: completedAt,
                lastAttemptAt: lastAttemptAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int lessonId,
                Value<bool> isCompleted = const Value.absent(),
                Value<int> bestQuizScore = const Value.absent(),
                Value<int> attemptCount = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
              }) => LessonProgressCompanion.insert(
                id: id,
                lessonId: lessonId,
                isCompleted: isCompleted,
                bestQuizScore: bestQuizScore,
                attemptCount: attemptCount,
                completedAt: completedAt,
                lastAttemptAt: lastAttemptAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LessonProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LessonProgressTable,
      LessonProgressData,
      $$LessonProgressTableFilterComposer,
      $$LessonProgressTableOrderingComposer,
      $$LessonProgressTableAnnotationComposer,
      $$LessonProgressTableCreateCompanionBuilder,
      $$LessonProgressTableUpdateCompanionBuilder,
      (
        LessonProgressData,
        BaseReferences<_$AppDatabase, $LessonProgressTable, LessonProgressData>,
      ),
      LessonProgressData,
      PrefetchHooks Function()
    >;
typedef $$UserStreaksTableCreateCompanionBuilder =
    UserStreaksCompanion Function({
      Value<int> id,
      Value<int> currentStreak,
      Value<int> longestStreak,
      Value<DateTime?> lastActivityDate,
      Value<int> totalRecordings,
      Value<int> totalPracticeSeconds,
    });
typedef $$UserStreaksTableUpdateCompanionBuilder =
    UserStreaksCompanion Function({
      Value<int> id,
      Value<int> currentStreak,
      Value<int> longestStreak,
      Value<DateTime?> lastActivityDate,
      Value<int> totalRecordings,
      Value<int> totalPracticeSeconds,
    });

class $$UserStreaksTableFilterComposer
    extends Composer<_$AppDatabase, $UserStreaksTable> {
  $$UserStreaksTableFilterComposer({
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

  ColumnFilters<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastActivityDate => $composableBuilder(
    column: $table.lastActivityDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalRecordings => $composableBuilder(
    column: $table.totalRecordings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPracticeSeconds => $composableBuilder(
    column: $table.totalPracticeSeconds,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserStreaksTableOrderingComposer
    extends Composer<_$AppDatabase, $UserStreaksTable> {
  $$UserStreaksTableOrderingComposer({
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

  ColumnOrderings<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastActivityDate => $composableBuilder(
    column: $table.lastActivityDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalRecordings => $composableBuilder(
    column: $table.totalRecordings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPracticeSeconds => $composableBuilder(
    column: $table.totalPracticeSeconds,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserStreaksTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserStreaksTable> {
  $$UserStreaksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastActivityDate => $composableBuilder(
    column: $table.lastActivityDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalRecordings => $composableBuilder(
    column: $table.totalRecordings,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalPracticeSeconds => $composableBuilder(
    column: $table.totalPracticeSeconds,
    builder: (column) => column,
  );
}

class $$UserStreaksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserStreaksTable,
          UserStreak,
          $$UserStreaksTableFilterComposer,
          $$UserStreaksTableOrderingComposer,
          $$UserStreaksTableAnnotationComposer,
          $$UserStreaksTableCreateCompanionBuilder,
          $$UserStreaksTableUpdateCompanionBuilder,
          (
            UserStreak,
            BaseReferences<_$AppDatabase, $UserStreaksTable, UserStreak>,
          ),
          UserStreak,
          PrefetchHooks Function()
        > {
  $$UserStreaksTableTableManager(_$AppDatabase db, $UserStreaksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$UserStreaksTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UserStreaksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$UserStreaksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                Value<DateTime?> lastActivityDate = const Value.absent(),
                Value<int> totalRecordings = const Value.absent(),
                Value<int> totalPracticeSeconds = const Value.absent(),
              }) => UserStreaksCompanion(
                id: id,
                currentStreak: currentStreak,
                longestStreak: longestStreak,
                lastActivityDate: lastActivityDate,
                totalRecordings: totalRecordings,
                totalPracticeSeconds: totalPracticeSeconds,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                Value<DateTime?> lastActivityDate = const Value.absent(),
                Value<int> totalRecordings = const Value.absent(),
                Value<int> totalPracticeSeconds = const Value.absent(),
              }) => UserStreaksCompanion.insert(
                id: id,
                currentStreak: currentStreak,
                longestStreak: longestStreak,
                lastActivityDate: lastActivityDate,
                totalRecordings: totalRecordings,
                totalPracticeSeconds: totalPracticeSeconds,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserStreaksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserStreaksTable,
      UserStreak,
      $$UserStreaksTableFilterComposer,
      $$UserStreaksTableOrderingComposer,
      $$UserStreaksTableAnnotationComposer,
      $$UserStreaksTableCreateCompanionBuilder,
      $$UserStreaksTableUpdateCompanionBuilder,
      (
        UserStreak,
        BaseReferences<_$AppDatabase, $UserStreaksTable, UserStreak>,
      ),
      UserStreak,
      PrefetchHooks Function()
    >;
typedef $$AchievementsTableCreateCompanionBuilder =
    AchievementsCompanion Function({
      Value<int> id,
      required String achievementId,
      required DateTime unlockedAt,
    });
typedef $$AchievementsTableUpdateCompanionBuilder =
    AchievementsCompanion Function({
      Value<int> id,
      Value<String> achievementId,
      Value<DateTime> unlockedAt,
    });

class $$AchievementsTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableFilterComposer({
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

  ColumnFilters<String> get achievementId => $composableBuilder(
    column: $table.achievementId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AchievementsTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableOrderingComposer({
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

  ColumnOrderings<String> get achievementId => $composableBuilder(
    column: $table.achievementId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AchievementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get achievementId => $composableBuilder(
    column: $table.achievementId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => column,
  );
}

class $$AchievementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AchievementsTable,
          Achievement,
          $$AchievementsTableFilterComposer,
          $$AchievementsTableOrderingComposer,
          $$AchievementsTableAnnotationComposer,
          $$AchievementsTableCreateCompanionBuilder,
          $$AchievementsTableUpdateCompanionBuilder,
          (
            Achievement,
            BaseReferences<_$AppDatabase, $AchievementsTable, Achievement>,
          ),
          Achievement,
          PrefetchHooks Function()
        > {
  $$AchievementsTableTableManager(_$AppDatabase db, $AchievementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AchievementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AchievementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$AchievementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> achievementId = const Value.absent(),
                Value<DateTime> unlockedAt = const Value.absent(),
              }) => AchievementsCompanion(
                id: id,
                achievementId: achievementId,
                unlockedAt: unlockedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String achievementId,
                required DateTime unlockedAt,
              }) => AchievementsCompanion.insert(
                id: id,
                achievementId: achievementId,
                unlockedAt: unlockedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AchievementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AchievementsTable,
      Achievement,
      $$AchievementsTableFilterComposer,
      $$AchievementsTableOrderingComposer,
      $$AchievementsTableAnnotationComposer,
      $$AchievementsTableCreateCompanionBuilder,
      $$AchievementsTableUpdateCompanionBuilder,
      (
        Achievement,
        BaseReferences<_$AppDatabase, $AchievementsTable, Achievement>,
      ),
      Achievement,
      PrefetchHooks Function()
    >;
typedef $$RecordingSessionsTableCreateCompanionBuilder =
    RecordingSessionsCompanion Function({
      Value<int> id,
      required int lessonId,
      required int surahId,
      required int ayahNumber,
      required String userAudioPath,
      required String sheikhAudioUrl,
      required DateTime recordedAt,
      required int durationMs,
      Value<int?> selfRating,
    });
typedef $$RecordingSessionsTableUpdateCompanionBuilder =
    RecordingSessionsCompanion Function({
      Value<int> id,
      Value<int> lessonId,
      Value<int> surahId,
      Value<int> ayahNumber,
      Value<String> userAudioPath,
      Value<String> sheikhAudioUrl,
      Value<DateTime> recordedAt,
      Value<int> durationMs,
      Value<int?> selfRating,
    });

class $$RecordingSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $RecordingSessionsTable> {
  $$RecordingSessionsTableFilterComposer({
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

  ColumnFilters<int> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surahId => $composableBuilder(
    column: $table.surahId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userAudioPath => $composableBuilder(
    column: $table.userAudioPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sheikhAudioUrl => $composableBuilder(
    column: $table.sheikhAudioUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get selfRating => $composableBuilder(
    column: $table.selfRating,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecordingSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecordingSessionsTable> {
  $$RecordingSessionsTableOrderingComposer({
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

  ColumnOrderings<int> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surahId => $composableBuilder(
    column: $table.surahId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userAudioPath => $composableBuilder(
    column: $table.userAudioPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sheikhAudioUrl => $composableBuilder(
    column: $table.sheikhAudioUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get selfRating => $composableBuilder(
    column: $table.selfRating,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecordingSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecordingSessionsTable> {
  $$RecordingSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get lessonId =>
      $composableBuilder(column: $table.lessonId, builder: (column) => column);

  GeneratedColumn<int> get surahId =>
      $composableBuilder(column: $table.surahId, builder: (column) => column);

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userAudioPath => $composableBuilder(
    column: $table.userAudioPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sheikhAudioUrl => $composableBuilder(
    column: $table.sheikhAudioUrl,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get selfRating => $composableBuilder(
    column: $table.selfRating,
    builder: (column) => column,
  );
}

class $$RecordingSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecordingSessionsTable,
          RecordingSession,
          $$RecordingSessionsTableFilterComposer,
          $$RecordingSessionsTableOrderingComposer,
          $$RecordingSessionsTableAnnotationComposer,
          $$RecordingSessionsTableCreateCompanionBuilder,
          $$RecordingSessionsTableUpdateCompanionBuilder,
          (
            RecordingSession,
            BaseReferences<
              _$AppDatabase,
              $RecordingSessionsTable,
              RecordingSession
            >,
          ),
          RecordingSession,
          PrefetchHooks Function()
        > {
  $$RecordingSessionsTableTableManager(
    _$AppDatabase db,
    $RecordingSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RecordingSessionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$RecordingSessionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$RecordingSessionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> lessonId = const Value.absent(),
                Value<int> surahId = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<String> userAudioPath = const Value.absent(),
                Value<String> sheikhAudioUrl = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<int> durationMs = const Value.absent(),
                Value<int?> selfRating = const Value.absent(),
              }) => RecordingSessionsCompanion(
                id: id,
                lessonId: lessonId,
                surahId: surahId,
                ayahNumber: ayahNumber,
                userAudioPath: userAudioPath,
                sheikhAudioUrl: sheikhAudioUrl,
                recordedAt: recordedAt,
                durationMs: durationMs,
                selfRating: selfRating,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int lessonId,
                required int surahId,
                required int ayahNumber,
                required String userAudioPath,
                required String sheikhAudioUrl,
                required DateTime recordedAt,
                required int durationMs,
                Value<int?> selfRating = const Value.absent(),
              }) => RecordingSessionsCompanion.insert(
                id: id,
                lessonId: lessonId,
                surahId: surahId,
                ayahNumber: ayahNumber,
                userAudioPath: userAudioPath,
                sheikhAudioUrl: sheikhAudioUrl,
                recordedAt: recordedAt,
                durationMs: durationMs,
                selfRating: selfRating,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecordingSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecordingSessionsTable,
      RecordingSession,
      $$RecordingSessionsTableFilterComposer,
      $$RecordingSessionsTableOrderingComposer,
      $$RecordingSessionsTableAnnotationComposer,
      $$RecordingSessionsTableCreateCompanionBuilder,
      $$RecordingSessionsTableUpdateCompanionBuilder,
      (
        RecordingSession,
        BaseReferences<
          _$AppDatabase,
          $RecordingSessionsTable,
          RecordingSession
        >,
      ),
      RecordingSession,
      PrefetchHooks Function()
    >;
typedef $$DailyActivityLogTableCreateCompanionBuilder =
    DailyActivityLogCompanion Function({
      Value<int> id,
      required String activityType,
      required DateTime completedAt,
      required String date,
    });
typedef $$DailyActivityLogTableUpdateCompanionBuilder =
    DailyActivityLogCompanion Function({
      Value<int> id,
      Value<String> activityType,
      Value<DateTime> completedAt,
      Value<String> date,
    });

class $$DailyActivityLogTableFilterComposer
    extends Composer<_$AppDatabase, $DailyActivityLogTable> {
  $$DailyActivityLogTableFilterComposer({
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

  ColumnFilters<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyActivityLogTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyActivityLogTable> {
  $$DailyActivityLogTableOrderingComposer({
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

  ColumnOrderings<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyActivityLogTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyActivityLogTable> {
  $$DailyActivityLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$DailyActivityLogTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyActivityLogTable,
          DailyActivityLogData,
          $$DailyActivityLogTableFilterComposer,
          $$DailyActivityLogTableOrderingComposer,
          $$DailyActivityLogTableAnnotationComposer,
          $$DailyActivityLogTableCreateCompanionBuilder,
          $$DailyActivityLogTableUpdateCompanionBuilder,
          (
            DailyActivityLogData,
            BaseReferences<
              _$AppDatabase,
              $DailyActivityLogTable,
              DailyActivityLogData
            >,
          ),
          DailyActivityLogData,
          PrefetchHooks Function()
        > {
  $$DailyActivityLogTableTableManager(
    _$AppDatabase db,
    $DailyActivityLogTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$DailyActivityLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DailyActivityLogTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$DailyActivityLogTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> activityType = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<String> date = const Value.absent(),
              }) => DailyActivityLogCompanion(
                id: id,
                activityType: activityType,
                completedAt: completedAt,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String activityType,
                required DateTime completedAt,
                required String date,
              }) => DailyActivityLogCompanion.insert(
                id: id,
                activityType: activityType,
                completedAt: completedAt,
                date: date,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyActivityLogTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyActivityLogTable,
      DailyActivityLogData,
      $$DailyActivityLogTableFilterComposer,
      $$DailyActivityLogTableOrderingComposer,
      $$DailyActivityLogTableAnnotationComposer,
      $$DailyActivityLogTableCreateCompanionBuilder,
      $$DailyActivityLogTableUpdateCompanionBuilder,
      (
        DailyActivityLogData,
        BaseReferences<
          _$AppDatabase,
          $DailyActivityLogTable,
          DailyActivityLogData
        >,
      ),
      DailyActivityLogData,
      PrefetchHooks Function()
    >;
typedef $$CachedHadithSectionsTableCreateCompanionBuilder =
    CachedHadithSectionsCompanion Function({
      Value<int> id,
      required String collectionKey,
      required int sectionNumber,
      required String name,
      Value<String> nameArabic,
      Value<int> hadithStartNumber,
      Value<int> hadithEndNumber,
    });
typedef $$CachedHadithSectionsTableUpdateCompanionBuilder =
    CachedHadithSectionsCompanion Function({
      Value<int> id,
      Value<String> collectionKey,
      Value<int> sectionNumber,
      Value<String> name,
      Value<String> nameArabic,
      Value<int> hadithStartNumber,
      Value<int> hadithEndNumber,
    });

class $$CachedHadithSectionsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedHadithSectionsTable> {
  $$CachedHadithSectionsTableFilterComposer({
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

  ColumnFilters<String> get collectionKey => $composableBuilder(
    column: $table.collectionKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sectionNumber => $composableBuilder(
    column: $table.sectionNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hadithStartNumber => $composableBuilder(
    column: $table.hadithStartNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hadithEndNumber => $composableBuilder(
    column: $table.hadithEndNumber,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedHadithSectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedHadithSectionsTable> {
  $$CachedHadithSectionsTableOrderingComposer({
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

  ColumnOrderings<String> get collectionKey => $composableBuilder(
    column: $table.collectionKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sectionNumber => $composableBuilder(
    column: $table.sectionNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hadithStartNumber => $composableBuilder(
    column: $table.hadithStartNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hadithEndNumber => $composableBuilder(
    column: $table.hadithEndNumber,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedHadithSectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedHadithSectionsTable> {
  $$CachedHadithSectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get collectionKey => $composableBuilder(
    column: $table.collectionKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sectionNumber => $composableBuilder(
    column: $table.sectionNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hadithStartNumber => $composableBuilder(
    column: $table.hadithStartNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hadithEndNumber => $composableBuilder(
    column: $table.hadithEndNumber,
    builder: (column) => column,
  );
}

class $$CachedHadithSectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedHadithSectionsTable,
          CachedHadithSection,
          $$CachedHadithSectionsTableFilterComposer,
          $$CachedHadithSectionsTableOrderingComposer,
          $$CachedHadithSectionsTableAnnotationComposer,
          $$CachedHadithSectionsTableCreateCompanionBuilder,
          $$CachedHadithSectionsTableUpdateCompanionBuilder,
          (
            CachedHadithSection,
            BaseReferences<
              _$AppDatabase,
              $CachedHadithSectionsTable,
              CachedHadithSection
            >,
          ),
          CachedHadithSection,
          PrefetchHooks Function()
        > {
  $$CachedHadithSectionsTableTableManager(
    _$AppDatabase db,
    $CachedHadithSectionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CachedHadithSectionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$CachedHadithSectionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$CachedHadithSectionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> collectionKey = const Value.absent(),
                Value<int> sectionNumber = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> nameArabic = const Value.absent(),
                Value<int> hadithStartNumber = const Value.absent(),
                Value<int> hadithEndNumber = const Value.absent(),
              }) => CachedHadithSectionsCompanion(
                id: id,
                collectionKey: collectionKey,
                sectionNumber: sectionNumber,
                name: name,
                nameArabic: nameArabic,
                hadithStartNumber: hadithStartNumber,
                hadithEndNumber: hadithEndNumber,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String collectionKey,
                required int sectionNumber,
                required String name,
                Value<String> nameArabic = const Value.absent(),
                Value<int> hadithStartNumber = const Value.absent(),
                Value<int> hadithEndNumber = const Value.absent(),
              }) => CachedHadithSectionsCompanion.insert(
                id: id,
                collectionKey: collectionKey,
                sectionNumber: sectionNumber,
                name: name,
                nameArabic: nameArabic,
                hadithStartNumber: hadithStartNumber,
                hadithEndNumber: hadithEndNumber,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedHadithSectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedHadithSectionsTable,
      CachedHadithSection,
      $$CachedHadithSectionsTableFilterComposer,
      $$CachedHadithSectionsTableOrderingComposer,
      $$CachedHadithSectionsTableAnnotationComposer,
      $$CachedHadithSectionsTableCreateCompanionBuilder,
      $$CachedHadithSectionsTableUpdateCompanionBuilder,
      (
        CachedHadithSection,
        BaseReferences<
          _$AppDatabase,
          $CachedHadithSectionsTable,
          CachedHadithSection
        >,
      ),
      CachedHadithSection,
      PrefetchHooks Function()
    >;
typedef $$CachedHadithsTableCreateCompanionBuilder =
    CachedHadithsCompanion Function({
      Value<int> id,
      required String collectionKey,
      required int sectionNumber,
      required int hadithNumber,
      required String textArabic,
      Value<String> textEnglish,
    });
typedef $$CachedHadithsTableUpdateCompanionBuilder =
    CachedHadithsCompanion Function({
      Value<int> id,
      Value<String> collectionKey,
      Value<int> sectionNumber,
      Value<int> hadithNumber,
      Value<String> textArabic,
      Value<String> textEnglish,
    });

class $$CachedHadithsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedHadithsTable> {
  $$CachedHadithsTableFilterComposer({
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

  ColumnFilters<String> get collectionKey => $composableBuilder(
    column: $table.collectionKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sectionNumber => $composableBuilder(
    column: $table.sectionNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hadithNumber => $composableBuilder(
    column: $table.hadithNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textArabic => $composableBuilder(
    column: $table.textArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textEnglish => $composableBuilder(
    column: $table.textEnglish,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedHadithsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedHadithsTable> {
  $$CachedHadithsTableOrderingComposer({
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

  ColumnOrderings<String> get collectionKey => $composableBuilder(
    column: $table.collectionKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sectionNumber => $composableBuilder(
    column: $table.sectionNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hadithNumber => $composableBuilder(
    column: $table.hadithNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textArabic => $composableBuilder(
    column: $table.textArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textEnglish => $composableBuilder(
    column: $table.textEnglish,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedHadithsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedHadithsTable> {
  $$CachedHadithsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get collectionKey => $composableBuilder(
    column: $table.collectionKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sectionNumber => $composableBuilder(
    column: $table.sectionNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hadithNumber => $composableBuilder(
    column: $table.hadithNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get textArabic => $composableBuilder(
    column: $table.textArabic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get textEnglish => $composableBuilder(
    column: $table.textEnglish,
    builder: (column) => column,
  );
}

class $$CachedHadithsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedHadithsTable,
          CachedHadith,
          $$CachedHadithsTableFilterComposer,
          $$CachedHadithsTableOrderingComposer,
          $$CachedHadithsTableAnnotationComposer,
          $$CachedHadithsTableCreateCompanionBuilder,
          $$CachedHadithsTableUpdateCompanionBuilder,
          (
            CachedHadith,
            BaseReferences<_$AppDatabase, $CachedHadithsTable, CachedHadith>,
          ),
          CachedHadith,
          PrefetchHooks Function()
        > {
  $$CachedHadithsTableTableManager(_$AppDatabase db, $CachedHadithsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CachedHadithsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$CachedHadithsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$CachedHadithsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> collectionKey = const Value.absent(),
                Value<int> sectionNumber = const Value.absent(),
                Value<int> hadithNumber = const Value.absent(),
                Value<String> textArabic = const Value.absent(),
                Value<String> textEnglish = const Value.absent(),
              }) => CachedHadithsCompanion(
                id: id,
                collectionKey: collectionKey,
                sectionNumber: sectionNumber,
                hadithNumber: hadithNumber,
                textArabic: textArabic,
                textEnglish: textEnglish,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String collectionKey,
                required int sectionNumber,
                required int hadithNumber,
                required String textArabic,
                Value<String> textEnglish = const Value.absent(),
              }) => CachedHadithsCompanion.insert(
                id: id,
                collectionKey: collectionKey,
                sectionNumber: sectionNumber,
                hadithNumber: hadithNumber,
                textArabic: textArabic,
                textEnglish: textEnglish,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedHadithsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedHadithsTable,
      CachedHadith,
      $$CachedHadithsTableFilterComposer,
      $$CachedHadithsTableOrderingComposer,
      $$CachedHadithsTableAnnotationComposer,
      $$CachedHadithsTableCreateCompanionBuilder,
      $$CachedHadithsTableUpdateCompanionBuilder,
      (
        CachedHadith,
        BaseReferences<_$AppDatabase, $CachedHadithsTable, CachedHadith>,
      ),
      CachedHadith,
      PrefetchHooks Function()
    >;
typedef $$CachedAzkarTableCreateCompanionBuilder =
    CachedAzkarCompanion Function({
      Value<int> id,
      required int categoryId,
      required String categoryTitle,
      required int itemId,
      required String arabicText,
      Value<int> repeatCount,
      Value<String> audioUrl,
    });
typedef $$CachedAzkarTableUpdateCompanionBuilder =
    CachedAzkarCompanion Function({
      Value<int> id,
      Value<int> categoryId,
      Value<String> categoryTitle,
      Value<int> itemId,
      Value<String> arabicText,
      Value<int> repeatCount,
      Value<String> audioUrl,
    });

class $$CachedAzkarTableFilterComposer
    extends Composer<_$AppDatabase, $CachedAzkarTable> {
  $$CachedAzkarTableFilterComposer({
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

  ColumnFilters<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryTitle => $composableBuilder(
    column: $table.categoryTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get arabicText => $composableBuilder(
    column: $table.arabicText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repeatCount => $composableBuilder(
    column: $table.repeatCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedAzkarTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedAzkarTable> {
  $$CachedAzkarTableOrderingComposer({
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

  ColumnOrderings<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryTitle => $composableBuilder(
    column: $table.categoryTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arabicText => $composableBuilder(
    column: $table.arabicText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repeatCount => $composableBuilder(
    column: $table.repeatCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedAzkarTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedAzkarTable> {
  $$CachedAzkarTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryTitle => $composableBuilder(
    column: $table.categoryTitle,
    builder: (column) => column,
  );

  GeneratedColumn<int> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get arabicText => $composableBuilder(
    column: $table.arabicText,
    builder: (column) => column,
  );

  GeneratedColumn<int> get repeatCount => $composableBuilder(
    column: $table.repeatCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get audioUrl =>
      $composableBuilder(column: $table.audioUrl, builder: (column) => column);
}

class $$CachedAzkarTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedAzkarTable,
          CachedAzkarData,
          $$CachedAzkarTableFilterComposer,
          $$CachedAzkarTableOrderingComposer,
          $$CachedAzkarTableAnnotationComposer,
          $$CachedAzkarTableCreateCompanionBuilder,
          $$CachedAzkarTableUpdateCompanionBuilder,
          (
            CachedAzkarData,
            BaseReferences<_$AppDatabase, $CachedAzkarTable, CachedAzkarData>,
          ),
          CachedAzkarData,
          PrefetchHooks Function()
        > {
  $$CachedAzkarTableTableManager(_$AppDatabase db, $CachedAzkarTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CachedAzkarTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CachedAzkarTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$CachedAzkarTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<String> categoryTitle = const Value.absent(),
                Value<int> itemId = const Value.absent(),
                Value<String> arabicText = const Value.absent(),
                Value<int> repeatCount = const Value.absent(),
                Value<String> audioUrl = const Value.absent(),
              }) => CachedAzkarCompanion(
                id: id,
                categoryId: categoryId,
                categoryTitle: categoryTitle,
                itemId: itemId,
                arabicText: arabicText,
                repeatCount: repeatCount,
                audioUrl: audioUrl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int categoryId,
                required String categoryTitle,
                required int itemId,
                required String arabicText,
                Value<int> repeatCount = const Value.absent(),
                Value<String> audioUrl = const Value.absent(),
              }) => CachedAzkarCompanion.insert(
                id: id,
                categoryId: categoryId,
                categoryTitle: categoryTitle,
                itemId: itemId,
                arabicText: arabicText,
                repeatCount: repeatCount,
                audioUrl: audioUrl,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedAzkarTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedAzkarTable,
      CachedAzkarData,
      $$CachedAzkarTableFilterComposer,
      $$CachedAzkarTableOrderingComposer,
      $$CachedAzkarTableAnnotationComposer,
      $$CachedAzkarTableCreateCompanionBuilder,
      $$CachedAzkarTableUpdateCompanionBuilder,
      (
        CachedAzkarData,
        BaseReferences<_$AppDatabase, $CachedAzkarTable, CachedAzkarData>,
      ),
      CachedAzkarData,
      PrefetchHooks Function()
    >;
typedef $$AyahBookmarksTableCreateCompanionBuilder =
    AyahBookmarksCompanion Function({
      Value<int> id,
      required int surahId,
      required int ayahNumber,
      required DateTime createdAt,
    });
typedef $$AyahBookmarksTableUpdateCompanionBuilder =
    AyahBookmarksCompanion Function({
      Value<int> id,
      Value<int> surahId,
      Value<int> ayahNumber,
      Value<DateTime> createdAt,
    });

final class $$AyahBookmarksTableReferences
    extends BaseReferences<_$AppDatabase, $AyahBookmarksTable, AyahBookmark> {
  $$AyahBookmarksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SurahsTable _surahIdTable(_$AppDatabase db) => db.surahs.createAlias(
    $_aliasNameGenerator(db.ayahBookmarks.surahId, db.surahs.id),
  );

  $$SurahsTableProcessedTableManager get surahId {
    final $_column = $_itemColumn<int>('surah_id')!;

    final manager = $$SurahsTableTableManager(
      $_db,
      $_db.surahs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_surahIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AyahBookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $AyahBookmarksTable> {
  $$AyahBookmarksTableFilterComposer({
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

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SurahsTableFilterComposer get surahId {
    final $$SurahsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableFilterComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AyahBookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $AyahBookmarksTable> {
  $$AyahBookmarksTableOrderingComposer({
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

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SurahsTableOrderingComposer get surahId {
    final $$SurahsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableOrderingComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AyahBookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $AyahBookmarksTable> {
  $$AyahBookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SurahsTableAnnotationComposer get surahId {
    final $$SurahsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableAnnotationComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AyahBookmarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AyahBookmarksTable,
          AyahBookmark,
          $$AyahBookmarksTableFilterComposer,
          $$AyahBookmarksTableOrderingComposer,
          $$AyahBookmarksTableAnnotationComposer,
          $$AyahBookmarksTableCreateCompanionBuilder,
          $$AyahBookmarksTableUpdateCompanionBuilder,
          (AyahBookmark, $$AyahBookmarksTableReferences),
          AyahBookmark,
          PrefetchHooks Function({bool surahId})
        > {
  $$AyahBookmarksTableTableManager(_$AppDatabase db, $AyahBookmarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AyahBookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$AyahBookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$AyahBookmarksTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> surahId = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AyahBookmarksCompanion(
                id: id,
                surahId: surahId,
                ayahNumber: ayahNumber,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int surahId,
                required int ayahNumber,
                required DateTime createdAt,
              }) => AyahBookmarksCompanion.insert(
                id: id,
                surahId: surahId,
                ayahNumber: ayahNumber,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$AyahBookmarksTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({surahId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (surahId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.surahId,
                            referencedTable: $$AyahBookmarksTableReferences
                                ._surahIdTable(db),
                            referencedColumn:
                                $$AyahBookmarksTableReferences
                                    ._surahIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AyahBookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AyahBookmarksTable,
      AyahBookmark,
      $$AyahBookmarksTableFilterComposer,
      $$AyahBookmarksTableOrderingComposer,
      $$AyahBookmarksTableAnnotationComposer,
      $$AyahBookmarksTableCreateCompanionBuilder,
      $$AyahBookmarksTableUpdateCompanionBuilder,
      (AyahBookmark, $$AyahBookmarksTableReferences),
      AyahBookmark,
      PrefetchHooks Function({bool surahId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SurahsTableTableManager get surahs =>
      $$SurahsTableTableManager(_db, _db.surahs);
  $$AyahsTableTableManager get ayahs =>
      $$AyahsTableTableManager(_db, _db.ayahs);
  $$AyahTranslationsTableTableManager get ayahTranslations =>
      $$AyahTranslationsTableTableManager(_db, _db.ayahTranslations);
  $$RecitersTableTableManager get reciters =>
      $$RecitersTableTableManager(_db, _db.reciters);
  $$DownloadedAudioTableTableManager get downloadedAudio =>
      $$DownloadedAudioTableTableManager(_db, _db.downloadedAudio);
  $$UserNotesTableTableManager get userNotes =>
      $$UserNotesTableTableManager(_db, _db.userNotes);
  $$ReadingProgressTableTableManager get readingProgress =>
      $$ReadingProgressTableTableManager(_db, _db.readingProgress);
  $$LessonProgressTableTableManager get lessonProgress =>
      $$LessonProgressTableTableManager(_db, _db.lessonProgress);
  $$UserStreaksTableTableManager get userStreaks =>
      $$UserStreaksTableTableManager(_db, _db.userStreaks);
  $$AchievementsTableTableManager get achievements =>
      $$AchievementsTableTableManager(_db, _db.achievements);
  $$RecordingSessionsTableTableManager get recordingSessions =>
      $$RecordingSessionsTableTableManager(_db, _db.recordingSessions);
  $$DailyActivityLogTableTableManager get dailyActivityLog =>
      $$DailyActivityLogTableTableManager(_db, _db.dailyActivityLog);
  $$CachedHadithSectionsTableTableManager get cachedHadithSections =>
      $$CachedHadithSectionsTableTableManager(_db, _db.cachedHadithSections);
  $$CachedHadithsTableTableManager get cachedHadiths =>
      $$CachedHadithsTableTableManager(_db, _db.cachedHadiths);
  $$CachedAzkarTableTableManager get cachedAzkar =>
      $$CachedAzkarTableTableManager(_db, _db.cachedAzkar);
  $$AyahBookmarksTableTableManager get ayahBookmarks =>
      $$AyahBookmarksTableTableManager(_db, _db.ayahBookmarks);
}
