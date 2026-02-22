import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

/// API endpoints for different Quran data sources.
class ApiEndpoints {
  ApiEndpoints._();

  // Primary: Quran.com API v4
  static const String quranCom = 'https://api.quran.com/api/v4';

  // Fallback: Al Quran Cloud (no auth)
  static const String alQuranCloud = 'https://api.alquran.cloud/v1';

  // Audio: MP3Quran (260+ reciters)
  static const String mp3Quran = 'https://mp3quran.net/api/v3';

  // Audio files: EveryAyah (static CDN)
  static const String everyAyah = 'https://everyayah.com/data';

  // Tafsir: QuranHub
  static const String quranHub = 'https://api.quranhub.com';
}

/// Creates configured Dio instances for each API.
class ApiClient {
  late final Dio quranComDio;
  late final Dio alQuranCloudDio;
  late final Dio mp3QuranDio;
  late final Dio quranHubDio;

  final CacheOptions _cacheOptions;

  ApiClient()
      : _cacheOptions = CacheOptions(
          store: MemCacheStore(),
          policy: CachePolicy.forceCache,
          maxStale: const Duration(days: 7),
        ) {
    quranComDio = _createDio(ApiEndpoints.quranCom);
    alQuranCloudDio = _createDio(ApiEndpoints.alQuranCloud);
    mp3QuranDio = _createDio(ApiEndpoints.mp3Quran);
    quranHubDio = _createDio(ApiEndpoints.quranHub);
  }

  Dio _createDio(String baseUrl) {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
      },
    ));

    // Cache interceptor
    dio.interceptors.add(DioCacheInterceptor(options: _cacheOptions));

    // Retry interceptor
    dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) async {
        if (_shouldRetry(error)) {
          try {
            final response = await dio.fetch(error.requestOptions);
            return handler.resolve(response);
          } catch (_) {
            return handler.next(error);
          }
        }
        return handler.next(error);
      },
    ));

    return dio;
  }

  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        (error.response?.statusCode ?? 0) >= 500;
  }
}
