import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/tenant_api_user_model.freezed.dart';
part 'gen/tenant_api_user_model.g.dart';

/// Created User Response (from Auth Service - Super Admin only)
@freezed
class CreatedUser with _$CreatedUser {
  const factory CreatedUser({
    required String id,
    @JsonKey(name: 'tenant_id') required String tenantId,
    required String email,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String role,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _CreatedUser;

  factory CreatedUser.fromJson(Map<String, dynamic> json) =>
      _$CreatedUserFromJson(json);
}

/// Extension for CreatedUser computed properties
extension CreatedUserExtension on CreatedUser {
  /// Get display name for dropdown
  String get displayName => '$firstName $lastName';

  /// Get display with email for dropdown
  String get displayWithEmail => '$firstName $lastName ($email)';
}

/// User List Response (for dropdown - Super Admin only)
@freezed
class UserListResponse with _$UserListResponse {
  const factory UserListResponse({
    required List<CreatedUser> users,
    required int total,
  }) = _UserListResponse;

  factory UserListResponse.fromJson(Map<String, dynamic> json) =>
      _$UserListResponseFromJson(json);
}
