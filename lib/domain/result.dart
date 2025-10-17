import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

/// Modern Result type for better error handling
@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(String message, [Exception? exception]) = Failure<T>;
  const factory Result.loading() = Loading<T>;
}

/// Extension methods for Result type
extension ResultExtension<T> on Result<T> {
  /// Check if result is success
  bool get isSuccess => this is Success<T>;

  /// Check if result is failure
  bool get isFailure => this is Failure<T>;

  /// Check if result is loading
  bool get isLoading => this is Loading<T>;

  /// Get data if success, null otherwise
  T? get data => switch (this) {
    Success<T>(data: final data) => data,
    _ => null,
  };

  /// Get error message if failure, null otherwise
  String? get errorMessage => switch (this) {
    Failure<T>(message: final message) => message,
    _ => null,
  };

  /// Transform the data if success
  Result<R> map<R>(R Function(T) transform) {
    return switch (this) {
      Success<T>(data: final data) => Result.success(transform(data)),
      Failure<T>(message: final message, exception: final exception) => 
        Result.failure(message, exception),
      Loading<T>() => const Result.loading(),
    };
  }

  /// Handle different result states
  R when<R>({
    required R Function(T data) success,
    required R Function(String message, Exception? exception) failure,
    required R Function() loading,
  }) {
    return switch (this) {
      Success<T>(data: final data) => success(data),
      Failure<T>(message: final message, exception: final exception) => 
        failure(message, exception),
      Loading<T>() => loading(),
    };
  }

  /// Handle different result states with default values
  R? whenOrNull<R>({
    R Function(T data)? success,
    R Function(String message, Exception? exception)? failure,
    R Function()? loading,
    R? orElse,
  }) {
    return switch (this) {
      Success<T>(data: final data) => success?.call(data) ?? orElse,
      Failure<T>(message: final message, exception: final exception) => 
        failure?.call(message, exception) ?? orElse,
      Loading<T>() => loading?.call() ?? orElse,
    };
  }
}
