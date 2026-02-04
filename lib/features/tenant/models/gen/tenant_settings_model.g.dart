// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../tenant_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TenantSettingsImpl _$$TenantSettingsImplFromJson(Map<String, dynamic> json) =>
    _$TenantSettingsImpl(
      tenantId: json['tenant_id'] as String?,
      maxDailyBookings: (json['max_daily_bookings'] as num?)?.toInt(),
      allowWalkins: json['allow_walkins'] as bool?,
      cancellationWindowMinutes: (json['cancellation_window_minutes'] as num?)
          ?.toInt(),
      queueEnabled: json['queue_enabled'] as bool?,
      autoAssignStaff: json['auto_assign_staff'] as bool?,
    );

Map<String, dynamic> _$$TenantSettingsImplToJson(
  _$TenantSettingsImpl instance,
) => <String, dynamic>{
  if (instance.tenantId case final value?) 'tenant_id': value,
  if (instance.maxDailyBookings case final value?) 'max_daily_bookings': value,
  if (instance.allowWalkins case final value?) 'allow_walkins': value,
  if (instance.cancellationWindowMinutes case final value?)
    'cancellation_window_minutes': value,
  if (instance.queueEnabled case final value?) 'queue_enabled': value,
  if (instance.autoAssignStaff case final value?) 'auto_assign_staff': value,
};

_$UpdateSettingsRequestImpl _$$UpdateSettingsRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateSettingsRequestImpl(
  maxDailyBookings: (json['max_daily_bookings'] as num?)?.toInt(),
  allowWalkins: json['allow_walkins'] as bool?,
  cancellationWindowMinutes: (json['cancellation_window_minutes'] as num?)
      ?.toInt(),
  queueEnabled: json['queue_enabled'] as bool?,
  autoAssignStaff: json['auto_assign_staff'] as bool?,
);

Map<String, dynamic> _$$UpdateSettingsRequestImplToJson(
  _$UpdateSettingsRequestImpl instance,
) => <String, dynamic>{
  if (instance.maxDailyBookings case final value?) 'max_daily_bookings': value,
  if (instance.allowWalkins case final value?) 'allow_walkins': value,
  if (instance.cancellationWindowMinutes case final value?)
    'cancellation_window_minutes': value,
  if (instance.queueEnabled case final value?) 'queue_enabled': value,
  if (instance.autoAssignStaff case final value?) 'auto_assign_staff': value,
};
