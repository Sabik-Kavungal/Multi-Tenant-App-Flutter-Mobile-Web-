import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saasf/features/auth/models/user_model.dart';
import 'package:saasf/features/auth/models/token_model.dart';

part 'gen/auth_response_model.freezed.dart';
part 'gen/auth_response_model.g.dart';

/// Auth API Response wrapper
/// Handles both success and error responses from API
@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required bool success,
    User? user,
    Token? token,
    String? message,
    String? error,
    String? errorCode,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

/// Extension for AuthResponse computed properties
extension AuthResponseExtension on AuthResponse {
  /// Check if error is due to invalid credentials
  bool get isInvalidCredentials => errorCode == 'authentication_failed';

  /// Check if error is due to validation
  bool get isValidationError => errorCode == 'validation_error';

  /// Check if error is due to token issues
  bool get isTokenError =>
      errorCode == 'token_refresh_failed' || errorCode == 'unauthorized';

  /// Check if user already exists
  bool get isUserExists => error?.contains('already exists') ?? false;

  /// Check if account is inactive
  bool get isAccountInactive => error?.contains('inactive') ?? false;
}
