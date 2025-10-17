import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

/// Generic cache manager for storing and retrieving data
class CacheManager {
  static final CacheManager _instance = CacheManager._internal();
  factory CacheManager() => _instance;
  CacheManager._internal();

  final Map<String, CacheItem> _memoryCache = {};
  SharedPreferences? _prefs;

  /// Initialize the cache manager
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Store data in cache with expiration
  Future<void> store<T>(
    String key,
    T data, {
    Duration? expiration,
    bool persistToDisk = false,
  }) async {
    final item = CacheItem<T>(
      data: data,
      timestamp: DateTime.now(),
      expiration: expiration,
    );

    _memoryCache[key] = item;

    if (persistToDisk && _prefs != null) {
      try {
        final json = jsonEncode({
          'data': data,
          'timestamp': item.timestamp.millisecondsSinceEpoch,
          'expiration': expiration?.inMilliseconds,
        });
        await _prefs!.setString('cache_$key', json);
      } catch (e) {
        // Handle serialization errors
        print('Failed to persist cache item $key: $e');
      }
    }
  }

  /// Retrieve data from cache
  T? retrieve<T>(String key) {
    final item = _memoryCache[key] as CacheItem<T>?;
    
    if (item == null) {
      return null;
    }

    // Check if expired
    if (item.isExpired) {
      _memoryCache.remove(key);
      return null;
    }

    return item.data;
  }

  /// Retrieve data from cache or disk
  Future<T?> retrieveOrLoad<T>(
    String key,
    Future<T> Function() loader, {
    Duration? expiration,
    bool persistToDisk = false,
  }) async {
    // Try memory cache first
    final cached = retrieve<T>(key);
    if (cached != null) {
      return cached;
    }

    // Try disk cache
    if (persistToDisk && _prefs != null) {
      final diskData = await _loadFromDisk<T>(key);
      if (diskData != null) {
        // Store back in memory cache
        await store(key, diskData, expiration: expiration);
        return diskData;
      }
    }

    // Load from source
    try {
      final data = await loader();
      await store(key, data, expiration: expiration, persistToDisk: persistToDisk);
      return data;
    } catch (e) {
      print('Failed to load data for key $key: $e');
      return null;
    }
  }

  /// Load data from disk
  Future<T?> _loadFromDisk<T>(String key) async {
    if (_prefs == null) return null;

    try {
      final json = _prefs!.getString('cache_$key');
      if (json == null) return null;

      final data = jsonDecode(json);
      final timestamp = DateTime.fromMillisecondsSinceEpoch(data['timestamp']);
      final expirationMs = data['expiration'] as int?;

      // Check if expired
      if (expirationMs != null) {
        final expiration = Duration(milliseconds: expirationMs);
        if (DateTime.now().difference(timestamp) > expiration) {
          await _prefs!.remove('cache_$key');
          return null;
        }
      }

      return data['data'] as T;
    } catch (e) {
      print('Failed to load from disk for key $key: $e');
      return null;
    }
  }

  /// Remove item from cache
  Future<void> remove(String key) async {
    _memoryCache.remove(key);
    
    if (_prefs != null) {
      await _prefs!.remove('cache_$key');
    }
  }

  /// Clear all cache
  Future<void> clear() async {
    _memoryCache.clear();
    
    if (_prefs != null) {
      final keys = _prefs!.getKeys().where((key) => key.startsWith('cache_'));
      for (final key in keys) {
        await _prefs!.remove(key);
      }
    }
  }

  /// Clear expired items
  void clearExpired() {
    final now = DateTime.now();
    _memoryCache.removeWhere((key, item) => item.isExpired);
  }

  /// Get cache statistics
  CacheStats getStats() {
    final totalItems = _memoryCache.length;
    final expiredItems = _memoryCache.values.where((item) => item.isExpired).length;
    final memoryUsage = _memoryCache.length; // Simplified memory usage

    return CacheStats(
      totalItems: totalItems,
      expiredItems: expiredItems,
      memoryUsage: memoryUsage,
    );
  }

  /// Generate cache key from parameters
  static String generateKey(String base, Map<String, dynamic>? params) {
    if (params == null || params.isEmpty) {
      return base;
    }

    final sortedParams = Map.fromEntries(
      params.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );

    final paramString = jsonEncode(sortedParams);
    final hash = md5.convert(utf8.encode(paramString)).toString();
    
    return '${base}_$hash';
  }
}

/// Cache item model
class CacheItem<T> {
  final T data;
  final DateTime timestamp;
  final Duration? expiration;

  CacheItem({
    required this.data,
    required this.timestamp,
    this.expiration,
  });

  bool get isExpired {
    if (expiration == null) return false;
    return DateTime.now().difference(timestamp) > expiration!;
  }
}

/// Cache statistics model
class CacheStats {
  final int totalItems;
  final int expiredItems;
  final int memoryUsage;

  const CacheStats({
    required this.totalItems,
    required this.expiredItems,
    required this.memoryUsage,
  });
}

/// HTTP cache interceptor for network requests
class HttpCacheInterceptor {
  static final CacheManager _cache = CacheManager();
  
  /// Cache HTTP response
  static Future<T> cacheResponse<T>(
    String url,
    Future<T> Function() request, {
    Duration? expiration,
    Map<String, dynamic>? params,
  }) async {
    final cacheKey = CacheManager.generateKey(url, params);
    
    return await _cache.retrieveOrLoad(
      cacheKey,
      request,
      expiration: expiration ?? const Duration(minutes: 5),
      persistToDisk: true,
    ) ?? (throw Exception('Failed to load data'));
  }
}

/// Image cache manager
class ImageCacheManager {
  static final Map<String, String> _imageCache = {};
  
  /// Cache image URL
  static void cacheImage(String key, String url) {
    _imageCache[key] = url;
  }
  
  /// Get cached image URL
  static String? getCachedImage(String key) {
    return _imageCache[key];
  }
  
  /// Clear image cache
  static void clearImageCache() {
    _imageCache.clear();
  }
}

/// Database query cache
class QueryCache {
  static final Map<String, QueryCacheItem> _queryCache = {};
  
  /// Cache query result
  static void cacheQuery(String query, dynamic result, {Duration? expiration}) {
    _queryCache[query] = QueryCacheItem(
      result: result,
      timestamp: DateTime.now(),
      expiration: expiration,
    );
  }
  
  /// Get cached query result
  static dynamic getCachedQuery(String query) {
    final item = _queryCache[query];
    if (item == null || item.isExpired) {
      _queryCache.remove(query);
      return null;
    }
    return item.result;
  }
  
  /// Clear query cache
  static void clearQueryCache() {
    _queryCache.clear();
  }
  
  /// Clear expired queries
  static void clearExpiredQueries() {
    _queryCache.removeWhere((key, item) => item.isExpired);
  }
}

/// Query cache item model
class QueryCacheItem {
  final dynamic result;
  final DateTime timestamp;
  final Duration? expiration;

  QueryCacheItem({
    required this.result,
    required this.timestamp,
    this.expiration,
  });

  bool get isExpired {
    if (expiration == null) return false;
    return DateTime.now().difference(timestamp) > expiration!;
  }
}
