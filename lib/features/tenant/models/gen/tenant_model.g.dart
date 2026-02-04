// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../tenant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TenantImpl _$$TenantImplFromJson(Map<String, dynamic> json) => _$TenantImpl(
  id: json['id'] as String?,
  name: json['name'] as String?,
  type: json['type'] as String?,
  ownerUserId: json['owner_user_id'] as String?,
  status: json['status'] as String?,
  timezone: json['timezone'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$$TenantImplToJson(_$TenantImpl instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.type case final value?) 'type': value,
      if (instance.ownerUserId case final value?) 'owner_user_id': value,
      if (instance.status case final value?) 'status': value,
      if (instance.timezone case final value?) 'timezone': value,
      if (instance.createdAt case final value?) 'created_at': value,
      if (instance.updatedAt case final value?) 'updated_at': value,
    };

_$CreateTenantRequestImpl _$$CreateTenantRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateTenantRequestImpl(
  name: json['name'] as String,
  type: json['type'] as String,
  ownerUserId: json['owner_user_id'] as String,
  timezone: json['timezone'] as String,
);

Map<String, dynamic> _$$CreateTenantRequestImplToJson(
  _$CreateTenantRequestImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'type': instance.type,
  'owner_user_id': instance.ownerUserId,
  'timezone': instance.timezone,
};

_$UpdateTenantRequestImpl _$$UpdateTenantRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateTenantRequestImpl(
  name: json['name'] as String?,
  type: json['type'] as String?,
  status: json['status'] as String?,
  timezone: json['timezone'] as String?,
);

Map<String, dynamic> _$$UpdateTenantRequestImplToJson(
  _$UpdateTenantRequestImpl instance,
) => <String, dynamic>{
  if (instance.name case final value?) 'name': value,
  if (instance.type case final value?) 'type': value,
  if (instance.status case final value?) 'status': value,
  if (instance.timezone case final value?) 'timezone': value,
};
