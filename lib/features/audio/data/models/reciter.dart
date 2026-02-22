/// Reciter model from MP3Quran API.
class ReciterModel {
  final int id;
  final String name;
  final String? letter;
  final List<ReciterMoshaf> mpieces;

  const ReciterModel({
    required this.id,
    required this.name,
    this.letter,
    this.mpieces = const [],
  });

  factory ReciterModel.fromJson(Map<String, dynamic> json) {
    return ReciterModel(
      id: json['id'] as int,
      name: json['name'] as String,
      letter: json['letter'] as String?,
      mpieces: (json['moshaf'] as List?)
              ?.map((m) => ReciterMoshaf.fromJson(m as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

/// A moshaf (edition) for a reciter - contains server URL and surah list.
class ReciterMoshaf {
  final int id;
  final String name;
  final String server;
  final List<int> surahList;
  final int surahTotal;

  const ReciterMoshaf({
    required this.id,
    required this.name,
    required this.server,
    required this.surahList,
    required this.surahTotal,
  });

  factory ReciterMoshaf.fromJson(Map<String, dynamic> json) {
    final surahListStr = json['surah_list'] as String? ?? '';
    final surahIds = surahListStr
        .split(',')
        .where((s) => s.isNotEmpty)
        .map((s) => int.parse(s.trim()))
        .toList();

    return ReciterMoshaf(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      server: json['server'] as String? ?? '',
      surahList: surahIds,
      surahTotal: json['surah_total'] as int? ?? surahIds.length,
    );
  }
}
