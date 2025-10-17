import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "auth.freezed.dart";

/// Modern sealed class for authentication state with better type safety
@freezed
sealed class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = _Initial;
  const factory AuthenticationState.loading() = _Loading;
  const factory AuthenticationState.unauthenticated({
    String? message,
    Exception? exception,
  }) = _UnAuthentication;
  const factory AuthenticationState.authenticated({
    required User user,
    required DateTime loginTime,
  }) = _Authenticated;
  const factory AuthenticationState.success({
    required String message,
    DateTime? timestamp,
  }) = _Success;
  const factory AuthenticationState.failed({
    required String message,
    Exception? exception,
    DateTime? timestamp,
  }) = _Failed;
}

/// Extension methods for AuthenticationState
extension AuthenticationStateExtension on AuthenticationState {
  /// Check if user is authenticated
  bool get isAuthenticated => this is _Authenticated;

  /// Check if authentication is loading
  bool get isLoading => this is _Loading;

  /// Check if authentication failed
  bool get isFailed => this is _Failed;

  /// Get user if authenticated
  User? get user => switch (this) {
    _Authenticated(user: final user) => user,
    _ => null,
  };

  /// Get error message if failed
  String? get errorMessage => switch (this) {
    _Failed(message: final message) => message,
    _UnAuthentication(message: final message) => message,
    _ => null,
  };

  /// Get success message if successful
  String? get successMessage => switch (this) {
    _Success(message: final message) => message,
    _ => null,
  };
}