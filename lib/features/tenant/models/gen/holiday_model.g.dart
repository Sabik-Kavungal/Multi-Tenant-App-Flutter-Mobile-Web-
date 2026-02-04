// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../holiday_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HolidayImpl _$$HolidayImplFromJson(Map<String, dynamic> json) =>
    _$HolidayImpl(
      id: json['id'] as String?,
      tenantId: json['tenant_id'] as String?,
      holidayDate: json['holiday_date'] as String?,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$HolidayImplToJson(_$HolidayImpl instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.tenantId case final value?) 'tenant_id': value,
      if (instance.holidayDate case final value?) 'holiday_date': value,
      if (instance.reason case final value?) 'reason': value,
    };

_$CreateHolidayRequestImpl _$$CreateHolidayRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateHolidayRequestImpl(
  holidayDate: json['holiday_date'] as String,
  reason: json['reason'] as String,
);

Map<String, dynamic> _$$CreateHolidayRequestImplToJson(
  _$CreateHolidayRequestImpl instance,
) => <String, dynamic>{
  'holiday_date': instance.holidayDate,
  'reason': instance.reason,
};
