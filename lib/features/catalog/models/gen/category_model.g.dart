// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      id: json['id'] as String?,
      tenantId: json['tenant_id'] as String?,
      name: json['name'] as String?,
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.tenantId case final value?) 'tenant_id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.isActive case final value?) 'is_active': value,
      if (instance.createdAt case final value?) 'created_at': value,
    };

_$CreateCategoryRequestImpl _$$CreateCategoryRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateCategoryRequestImpl(
  name: json['name'] as String,
  isActive: json['is_active'] as bool?,
);

Map<String, dynamic> _$$CreateCategoryRequestImplToJson(
  _$CreateCategoryRequestImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  if (instance.isActive case final value?) 'is_active': value,
};

_$UpdateCategoryRequestImpl _$$UpdateCategoryRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateCategoryRequestImpl(
  name: json['name'] as String?,
  isActive: json['is_active'] as bool?,
);

Map<String, dynamic> _$$UpdateCategoryRequestImplToJson(
  _$UpdateCategoryRequestImpl instance,
) => <String, dynamic>{
  if (instance.name case final value?) 'name': value,
  if (instance.isActive case final value?) 'is_active': value,
};
