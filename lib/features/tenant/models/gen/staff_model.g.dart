// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../staff_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StaffImpl _$$StaffImplFromJson(Map<String, dynamic> json) => _$StaffImpl(
  id: json['id'] as String?,
  tenantId: json['tenant_id'] as String?,
  userId: json['user_id'] as String?,
  designation: json['designation'] as String?,
  isActive: json['is_active'] as bool?,
  joinedAt: json['joined_at'] as String?,
);

Map<String, dynamic> _$$StaffImplToJson(_$StaffImpl instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.tenantId case final value?) 'tenant_id': value,
      if (instance.userId case final value?) 'user_id': value,
      if (instance.designation case final value?) 'designation': value,
      if (instance.isActive case final value?) 'is_active': value,
      if (instance.joinedAt case final value?) 'joined_at': value,
    };

_$CreateStaffRequestImpl _$$CreateStaffRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateStaffRequestImpl(
  userId: json['user_id'] as String,
  designation: json['designation'] as String,
);

Map<String, dynamic> _$$CreateStaffRequestImplToJson(
  _$CreateStaffRequestImpl instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'designation': instance.designation,
};

_$UpdateStaffRequestImpl _$$UpdateStaffRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateStaffRequestImpl(
  designation: json['designation'] as String?,
  isActive: json['is_active'] as bool?,
);

Map<String, dynamic> _$$UpdateStaffRequestImplToJson(
  _$UpdateStaffRequestImpl instance,
) => <String, dynamic>{
  if (instance.designation case final value?) 'designation': value,
  if (instance.isActive case final value?) 'is_active': value,
};
