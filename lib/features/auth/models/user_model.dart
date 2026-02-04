import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/user_model.freezed.dart';
part 'gen/user_model.g.dart';

/// User model representing authenticated user
/// Maps to SaaS Platform Auth Service response
@freezed
class User with _$User {
  const factory User({
    String? id,
    String? email,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    String? role,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'is_active') bool? isActive,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
