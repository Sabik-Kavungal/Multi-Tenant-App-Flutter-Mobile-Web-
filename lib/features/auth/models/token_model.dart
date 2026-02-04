import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/token_model.freezed.dart';
part 'gen/token_model.g.dart';

/// Token model for JWT authentication
/// Maps to SaaS Platform API token response
/// Contains access token, refresh token, token type, and expiration
@freezed
class Token with _$Token {
  const factory Token({
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'refresh_token') String? refreshToken,
    @JsonKey(name: 'token_type') String? tokenType,
    @JsonKey(name: 'expires_in') int? expiresIn, // in seconds
  }) = _Token;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}

/// Extension for Token computed properties
/// Freezed doesn't allow getters in the main class
extension TokenExtension on Token {
  /// Get expiration DateTime calculated from expires_in
  DateTime? get expiresAt {
    if (expiresIn == null) return null;
    return DateTime.now().add(Duration(seconds: expiresIn!));
  }

  /// Check if token is expired
  bool get isExpired {
    final expires = expiresAt;
    if (expires == null) return true;
    return DateTime.now().isAfter(expires);
  }

  /// Check if token expires soon (within 2 minutes)
  bool get expiresSoon {
    final expires = expiresAt;
    if (expires == null) return true;
    return expires.difference(DateTime.now()).inMinutes < 2;
  }
}
