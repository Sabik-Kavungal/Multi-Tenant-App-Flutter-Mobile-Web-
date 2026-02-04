// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../working_hours_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkingHoursImpl _$$WorkingHoursImplFromJson(Map<String, dynamic> json) =>
    _$WorkingHoursImpl(
      id: json['id'] as String?,
      tenantId: json['tenant_id'] as String?,
      dayOfWeek: (json['day_of_week'] as num?)?.toInt(),
      openTime: json['open_time'] as String?,
      closeTime: json['close_time'] as String?,
      isClosed: json['is_closed'] as bool?,
    );

Map<String, dynamic> _$$WorkingHoursImplToJson(_$WorkingHoursImpl instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.tenantId case final value?) 'tenant_id': value,
      if (instance.dayOfWeek case final value?) 'day_of_week': value,
      if (instance.openTime case final value?) 'open_time': value,
      if (instance.closeTime case final value?) 'close_time': value,
      if (instance.isClosed case final value?) 'is_closed': value,
    };

_$WorkingHoursInputImpl _$$WorkingHoursInputImplFromJson(
  Map<String, dynamic> json,
) => _$WorkingHoursInputImpl(
  dayOfWeek: (json['day_of_week'] as num).toInt(),
  openTime: json['open_time'] as String?,
  closeTime: json['close_time'] as String?,
  isClosed: json['is_closed'] as bool,
);

Map<String, dynamic> _$$WorkingHoursInputImplToJson(
  _$WorkingHoursInputImpl instance,
) => <String, dynamic>{
  'day_of_week': instance.dayOfWeek,
  if (instance.openTime case final value?) 'open_time': value,
  if (instance.closeTime case final value?) 'close_time': value,
  'is_closed': instance.isClosed,
};

_$UpdateWorkingHoursRequestImpl _$$UpdateWorkingHoursRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateWorkingHoursRequestImpl(
  hours: (json['hours'] as List<dynamic>)
      .map((e) => WorkingHoursInput.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$UpdateWorkingHoursRequestImplToJson(
  _$UpdateWorkingHoursRequestImpl instance,
) => <String, dynamic>{'hours': instance.hours.map((e) => e.toJson()).toList()};
