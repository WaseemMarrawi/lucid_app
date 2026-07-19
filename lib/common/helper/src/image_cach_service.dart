// // import 'dart:io';
// // import 'package:dio/dio.dart';
// // import 'package:path_provider/path_provider.dart';
// //
// // class ImagePrefetcher {
// //   final Dio dio;
// //
// //   ImagePrefetcher(this.dio);
// //
// //   // =========================
// //   // MAIN API
// //   // =========================
// //   Future<String?> downloadAndGetPath(String url) async {
// //     if (url.isEmpty) return null;
// //
// //     try {
// //       final file = await _getFile(url);
// //
// //       // ✅ already cached locally
// //       if (await file.exists()) {
// //         return file.path;
// //       }
// //
// //       // ⬇️ download
// //       await dio.download(
// //         url,
// //         file.path,
// //         options: Options(
// //           responseType: ResponseType.bytes,
// //           followRedirects: true,
// //           receiveTimeout: const Duration(seconds: 30),
// //           sendTimeout: const Duration(seconds: 30),
// //         ),
// //       );
// //
// //       return file.path;
// //     } catch (_) {
// //       return null;
// //     }
// //   }
// //
// //   // =========================
// //   // MULTI PRELOAD (optional)
// //   // =========================
// //   Future<void> preload(List<String> urls) async {
// //     for (final url in urls) {
// //       await downloadAndGetPath(url);
// //     }
// //   }
// //
// //   // =========================
// //   // FILE PATH GENERATION
// //   // =========================
// //   Future<File> _getFile(String url) async {
// //     final dir = await getApplicationDocumentsDirectory();
// //     final imagesDir = Directory('${dir.path}/images');
// //
// //     if (!await imagesDir.exists()) {
// //       await imagesDir.create(recursive: true);
// //     }
// //
// //     final fileName = _generateFileName(url);
// //     return File('${imagesDir.path}/$fileName');
// //   }
// //
// //   String _generateFileName(String url) {
// //     final uri = Uri.parse(url);
// //
// //     final base = uri.pathSegments.isNotEmpty
// //         ? uri.pathSegments.last
// //         : url.hashCode.toString();
// //
// //     // prevent collisions
// //     final safeHash = url.hashCode.toString();
// //
// //     return '${safeHash}_$base';
// //   }
// // }
//
// import 'dart:io';
//
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:injectable/injectable.dart';
//
// // @lazySingleton
// // class ImageCacheService {
// //   final CacheManager _cacheManager = DefaultCacheManager();
// //
// //   Future<File?> getCachedImage(String url) async {
// //     try {
// //       final fileInfo = await _cacheManager.getFileFromCache(url);
// //
// //       if (fileInfo == null) {
// //         return null;
// //       }
// //
// //       if (!await fileInfo.file.exists()) {
// //         return null;
// //       }
// //
// //       return fileInfo.file;
// //     } catch (_) {
// //       return null;
// //     }
// //   }
// //
// //   Future<void> prefetch(String url) async {
// //     try {
// //       final cached = await _cacheManager.getFileFromCache(url);
// //
// //       if (cached != null) {
// //         return;
// //       }
// //
// //       await _cacheManager.downloadFile(url);
// //     } catch (_) {}
// //   }
// //
// //   Future<void> prefetchAll(List<String> urls) async {
// //     for (final url in urls) {
// //       await prefetch(url);
// //     }
// //   }
// // }