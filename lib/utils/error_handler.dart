import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// Centralized error handling system
class ErrorHandler {
  static final ErrorHandler _instance = ErrorHandler._internal();
  factory ErrorHandler() => _instance;
  ErrorHandler._internal();

  final List<ErrorListener> _listeners = [];
  final StreamController<AppError> _errorController = StreamController<AppError>.broadcast();

  /// Stream of errors
  Stream<AppError> get errorStream => _errorController.stream;

  /// Initialize error handling
  void init() {
    // Set up Flutter error handling
    FlutterError.onError = (FlutterErrorDetails details) {
      _handleFlutterError(details);
    };

    // Set up Dart error handling
    PlatformDispatcher.instance.onError = (error, stack) {
      _handleDartError(error, stack);
      return true;
    };

    // Set up Zone error handling
    runZonedGuarded(() {
      // App initialization
    }, (error, stack) {
      _handleZoneError(error, stack);
    });
  }

  /// Handle Flutter framework errors
  void _handleFlutterError(FlutterErrorDetails details) {
    final error = AppError(
      type: ErrorType.flutter,
      message: details.exception.toString(),
      stackTrace: details.stack,
      context: details.context?.toString(),
      library: details.library,
    );

    _processError(error);
  }

  /// Handle Dart errors
  void _handleDartError(Object error, StackTrace stack) {
    final appError = AppError(
      type: ErrorType.dart,
      message: error.toString(),
      stackTrace: stack,
    );

    _processError(appError);
  }

  /// Handle Zone errors
  void _handleZoneError(Object error, StackTrace stack) {
    final appError = AppError(
      type: ErrorType.zone,
      message: error.toString(),
      stackTrace: stack,
    );

    _processError(appError);
  }

  /// Process and handle an error
  void _processError(AppError error) {
    // Log to console in debug mode
    if (kDebugMode) {
      debugPrint('🚨 Error: ${error.message}');
      debugPrint('📍 Type: ${error.type}');
      if (error.stackTrace != null) {
        debugPrint('📚 Stack: ${error.stackTrace}');
      }
    }

    // Log to Firebase Crashlytics in production
    if (kReleaseMode) {
      FirebaseCrashlytics.instance.recordError(
        error.message,
        error.stackTrace,
        fatal: error.isFatal,
        information: [
          'Type: ${error.type}',
          'Context: ${error.context ?? 'N/A'}',
          'Library: ${error.library ?? 'N/A'}',
        ],
      );
    }

    // Log to developer console
    developer.log(
      error.message,
      name: 'ErrorHandler',
      error: error,
      stackTrace: error.stackTrace,
    );

    // Notify listeners
    for (final listener in _listeners) {
      try {
        listener.onError(error);
      } catch (e) {
        debugPrint('Error in error listener: $e');
      }
    }

    // Emit to stream
    _errorController.add(error);
  }

  /// Handle a custom error
  void handleError(
    String message, {
    ErrorType type = ErrorType.custom,
    StackTrace? stackTrace,
    String? context,
    String? library,
    bool isFatal = false,
  }) {
    final error = AppError(
      type: type,
      message: message,
      stackTrace: stackTrace,
      context: context,
      library: library,
      isFatal: isFatal,
    );

    _processError(error);
  }

  /// Handle network errors
  void handleNetworkError(
    String message, {
    int? statusCode,
    String? endpoint,
    StackTrace? stackTrace,
  }) {
    final error = AppError(
      type: ErrorType.network,
      message: message,
      stackTrace: stackTrace,
      context: 'Status: $statusCode, Endpoint: $endpoint',
    );

    _processError(error);
  }

  /// Handle database errors
  void handleDatabaseError(
    String message, {
    String? operation,
    String? table,
    StackTrace? stackTrace,
  }) {
    final error = AppError(
      type: ErrorType.database,
      message: message,
      stackTrace: stackTrace,
      context: 'Operation: $operation, Table: $table',
    );

    _processError(error);
  }

  /// Handle authentication errors
  void handleAuthError(
    String message, {
    String? provider,
    StackTrace? stackTrace,
  }) {
    final error = AppError(
      type: ErrorType.authentication,
      message: message,
      stackTrace: stackTrace,
      context: 'Provider: $provider',
    );

    _processError(error);
  }

  /// Add error listener
  void addListener(ErrorListener listener) {
    _listeners.add(listener);
  }

  /// Remove error listener
  void removeListener(ErrorListener listener) {
    _listeners.remove(listener);
  }

  /// Dispose resources
  void dispose() {
    _errorController.close();
    _listeners.clear();
  }
}

/// Error types enum
enum ErrorType {
  flutter,
  dart,
  zone,
  network,
  database,
  authentication,
  validation,
  custom,
}

/// App error model
class AppError {
  final ErrorType type;
  final String message;
  final StackTrace? stackTrace;
  final String? context;
  final String? library;
  final bool isFatal;
  final DateTime timestamp;

  AppError({
    required this.type,
    required this.message,
    this.stackTrace,
    this.context,
    this.library,
    this.isFatal = false,
  }) : timestamp = DateTime.now();

  /// Get user-friendly error message
  String get userMessage {
    return switch (type) {
      ErrorType.network => 'Network connection error. Please check your internet connection.',
      ErrorType.database => 'Data error. Please try again.',
      ErrorType.authentication => 'Authentication error. Please sign in again.',
      ErrorType.validation => message,
      _ => 'An unexpected error occurred. Please try again.',
    };
  }

  /// Get error severity
  ErrorSeverity get severity {
    return switch (type) {
      ErrorType.flutter => ErrorSeverity.critical,
      ErrorType.dart => ErrorSeverity.critical,
      ErrorType.zone => ErrorSeverity.critical,
      ErrorType.network => ErrorSeverity.warning,
      ErrorType.database => ErrorSeverity.error,
      ErrorType.authentication => ErrorSeverity.warning,
      ErrorType.validation => ErrorSeverity.info,
      ErrorType.custom => isFatal ? ErrorSeverity.critical : ErrorSeverity.error,
    };
  }
}

/// Error severity levels
enum ErrorSeverity {
  info,
  warning,
  error,
  critical,
}

/// Error listener interface
abstract class ErrorListener {
  void onError(AppError error);
}

/// Default error listener implementation
class DefaultErrorListener implements ErrorListener {
  @override
  void onError(AppError error) {
    // Default implementation - can be overridden
  }
}

/// Error listener implementation for error boundary
class _ErrorListenerImpl implements ErrorListener {
  final _ErrorBoundaryState _state;
  
  _ErrorListenerImpl(this._state);
  
  @override
  void onError(AppError error) {
    if (_state.mounted) {
      _state.setState(() {
        _state._error = error;
      });
    }
  }
}

/// Error recovery strategies
class ErrorRecovery {
  /// Retry operation with exponential backoff
  static Future<T> retryWithBackoff<T>(
    Future<T> Function() operation, {
    int maxRetries = 3,
    Duration initialDelay = const Duration(seconds: 1),
  }) async {
    int retries = 0;
    Duration delay = initialDelay;

    while (retries < maxRetries) {
      try {
        return await operation();
      } catch (e) {
        retries++;
        if (retries >= maxRetries) {
          rethrow;
        }

        await Future.delayed(delay);
        delay *= 2; // Exponential backoff
      }
    }

    throw Exception('Max retries exceeded');
  }

  /// Fallback operation
  static Future<T> withFallback<T>(
    Future<T> Function() primary,
    Future<T> Function() fallback,
  ) async {
    try {
      return await primary();
    } catch (e) {
      return await fallback();
    }
  }

  /// Circuit breaker pattern
  static Future<T> withCircuitBreaker<T>(
    String operation,
    Future<T> Function() operationFunc, {
    int failureThreshold = 5,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    // This would typically use a circuit breaker implementation
    // For now, we'll just add a timeout
    return await operationFunc().timeout(timeout);
  }
}

/// Error boundary widget for catching widget errors
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(AppError error)? errorBuilder;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  AppError? _error;

  @override
  void initState() {
    super.initState();
    ErrorHandler().addListener(_errorListener);
  }

  @override
  void dispose() {
    ErrorHandler().removeListener(_errorListener);
    super.dispose();
  }

  late final ErrorListener _errorListener = _ErrorListenerImpl(this);

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return widget.errorBuilder?.call(_error!) ?? _defaultErrorWidget(_error!);
    }

    return widget.child;
  }

  Widget _defaultErrorWidget(AppError error) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error.userMessage,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _error = null;
              });
            },
            child: Text('Try Again'),
          ),
        ],
      ),
    );
  }
}

/// Global error handler initialization
void initializeErrorHandling() {
  ErrorHandler().init();
}
