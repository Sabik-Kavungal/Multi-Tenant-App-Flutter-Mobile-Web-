// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../tenant_api_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreatedUserImpl _$$CreatedUserImplFromJson(Map<String, dynamic> json) =>
    _$CreatedUserImpl(
      id: json['id'] as String,
      tenantId: json['tenant_id'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      role: json['role'] as String,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$CreatedUserImplToJson(_$CreatedUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenant_id': instance.tenantId,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'role': instance.role,
      'is_active': instance.isActive,
    };

_$UserListResponseImpl _$$UserListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$UserListResponseImpl(
  users: (json['users'] as List<dynamic>)
      .map((e) => CreatedUser.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
);

Map<String, dynamic> _$$UserListResponseImplToJson(
  _$UserListResponseImpl instance,
) => <String, dynamic>{
  'users': instance.users.map((e) => e.toJson()).toList(),
  'total': instance.total,
};
