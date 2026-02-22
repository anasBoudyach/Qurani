import '../../../../core/network/api_client.dart';
import '../models/reciter.dart';

/// Repository for audio-related data (reciters, downloads).
class AudioRepository {
  final ApiClient _apiClient;

  AudioRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  /// Fetch all reciters from MP3Quran API.
  Future<List<ReciterModel>> getReciters({String language = 'eng'}) async {
    try {
      final response = await _apiClient.mp3QuranDio.get(
        '/reciters',
        queryParameters: {'language': language},
      );

      final data = response.data;
      final reciters = (data['reciters'] as List?)
              ?.map((r) => ReciterModel.fromJson(r as Map<String, dynamic>))
              .toList() ??
          [];

      // Sort alphabetically
      reciters.sort((a, b) => a.name.compareTo(b.name));
      return reciters;
    } catch (e) {
      rethrow;
    }
  }

  /// Search reciters by name.
  Future<List<ReciterModel>> searchReciters(String query,
      {String language = 'eng'}) async {
    final allReciters = await getReciters(language: language);
    final lowerQuery = query.toLowerCase();
    return allReciters
        .where((r) => r.name.toLowerCase().contains(lowerQuery))
        .toList();
  }
}
