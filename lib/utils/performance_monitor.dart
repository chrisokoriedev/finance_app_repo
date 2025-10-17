import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Performance monitoring utility for tracking app performance
class PerformanceMonitor {
  static final PerformanceMonitor _instance = PerformanceMonitor._internal();
  factory PerformanceMonitor() => _instance;
  PerformanceMonitor._internal();

  final Map<String, Stopwatch> _timers = {};
  final Map<String, List<Duration>> _measurements = {};

  /// Start timing an operation
  void startTimer(String operation) {
    _timers[operation] = Stopwatch()..start();
  }

  /// End timing an operation and record the duration
  Duration endTimer(String operation) {
    final stopwatch = _timers.remove(operation);
    if (stopwatch == null) {
      debugPrint('Timer for $operation was not started');
      return Duration.zero;
    }

    stopwatch.stop();
    final duration = stopwatch.elapsed;

    // Record the measurement
    _measurements.putIfAbsent(operation, () => []).add(duration);

    // Log in debug mode
    if (kDebugMode) {
      debugPrint('⏱️ $operation took ${duration.inMilliseconds}ms');
    }

    return duration;
  }

  /// Get average time for an operation
  Duration getAverageTime(String operation) {
    final measurements = _measurements[operation];
    if (measurements == null || measurements.isEmpty) {
      return Duration.zero;
    }

    final totalMs = measurements.fold<int>(
      0,
      (sum, duration) => sum + duration.inMilliseconds,
    );

    return Duration(milliseconds: totalMs ~/ measurements.length);
  }

  /// Get all performance statistics
  Map<String, PerformanceStats> getStats() {
    return _measurements.map((operation, measurements) {
      final totalMs = measurements.fold<int>(
        0,
        (sum, duration) => sum + duration.inMilliseconds,
      );

      return MapEntry(
        operation,
        PerformanceStats(
          operation: operation,
          totalCalls: measurements.length,
          averageTime: Duration(milliseconds: totalMs ~/ measurements.length),
          minTime: measurements.reduce((a, b) => a < b ? a : b),
          maxTime: measurements.reduce((a, b) => a > b ? a : b),
          totalTime: Duration(milliseconds: totalMs),
        ),
      );
    });
  }

  /// Clear all measurements
  void clearStats() {
    _measurements.clear();
    _timers.clear();
  }

  /// Log performance stats
  void logStats() {
    if (kDebugMode) {
      debugPrint('📊 Performance Statistics:');
      final stats = getStats();
      stats.forEach((operation, stat) {
        debugPrint(
          '  $operation: ${stat.averageTime.inMilliseconds}ms avg '
          '(${stat.totalCalls} calls, '
          '${stat.minTime.inMilliseconds}ms min, '
          '${stat.maxTime.inMilliseconds}ms max)',
        );
      });
    }
  }
}

/// Performance statistics model
class PerformanceStats {
  final String operation;
  final int totalCalls;
  final Duration averageTime;
  final Duration minTime;
  final Duration maxTime;
  final Duration totalTime;

  const PerformanceStats({
    required this.operation,
    required this.totalCalls,
    required this.averageTime,
    required this.minTime,
    required this.maxTime,
    required this.totalTime,
  });
}

/// Performance monitoring widget that tracks widget build times
class PerformanceTracker extends StatefulWidget {
  final Widget child;
  final String name;

  const PerformanceTracker({
    super.key,
    required this.child,
    required this.name,
  });

  @override
  State<PerformanceTracker> createState() => _PerformanceTrackerState();
}

class _PerformanceTrackerState extends State<PerformanceTracker> {
  late Stopwatch _buildTimer;

  @override
  void initState() {
    super.initState();
    _buildTimer = Stopwatch()..start();
  }

  @override
  Widget build(BuildContext context) {
    _buildTimer.reset();
    _buildTimer.start();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _buildTimer.stop();
      PerformanceMonitor().startTimer('${widget.name}_build');
      PerformanceMonitor().endTimer('${widget.name}_build');
    });

    return widget.child;
  }
}

/// Extension for easy performance tracking
extension PerformanceTracking on Widget {
  /// Track the performance of this widget
  Widget trackPerformance(String name) {
    if (kDebugMode) {
      return PerformanceTracker(name: name, child: this);
    }
    return this;
  }
}

/// Performance monitoring mixin for classes
mixin PerformanceMixin {
  final PerformanceMonitor _monitor = PerformanceMonitor();

  /// Track a method execution
  Future<T> trackMethod<T>(
    String methodName,
    Future<T> Function() method,
  ) async {
    _monitor.startTimer(methodName);
    try {
      final result = await method();
      return result;
    } finally {
      _monitor.endTimer(methodName);
    }
  }

  /// Track a synchronous method execution
  T trackSyncMethod<T>(
    String methodName,
    T Function() method,
  ) {
    _monitor.startTimer(methodName);
    try {
      final result = method();
      return result;
    } finally {
      _monitor.endTimer(methodName);
    }
  }
}

/// Memory usage monitor
class MemoryMonitor {
  static void logMemoryUsage(String context) {
    if (kDebugMode) {
      // This would typically use platform-specific memory monitoring
      // For now, we'll just log the context
      debugPrint('🧠 Memory check at: $context');
    }
  }

  /// Monitor memory usage during an operation
  static Future<T> monitorMemory<T>(
    String operation,
    Future<T> Function() operationFunc,
  ) async {
    logMemoryUsage('Before $operation');
    final result = await operationFunc();
    logMemoryUsage('After $operation');
    return result;
  }
}

/// Network performance monitor
class NetworkMonitor {
  static final Map<String, List<Duration>> _requestTimes = {};

  /// Record network request time
  static void recordRequestTime(String endpoint, Duration duration) {
    _requestTimes.putIfAbsent(endpoint, () => []).add(duration);
    
    if (kDebugMode) {
      debugPrint('🌐 $endpoint: ${duration.inMilliseconds}ms');
    }
  }

  /// Get average request time for an endpoint
  static Duration getAverageRequestTime(String endpoint) {
    final times = _requestTimes[endpoint];
    if (times == null || times.isEmpty) {
      return Duration.zero;
    }

    final totalMs = times.fold<int>(
      0,
      (sum, duration) => sum + duration.inMilliseconds,
    );

    return Duration(milliseconds: totalMs ~/ times.length);
  }

  /// Get all network statistics
  static Map<String, Duration> getNetworkStats() {
    return _requestTimes.map(
      (endpoint, times) => MapEntry(
        endpoint,
        getAverageRequestTime(endpoint),
      ),
    );
  }
}
