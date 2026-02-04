import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/tenant_settings_model.freezed.dart';
part 'gen/tenant_settings_model.g.dart';

/// Tenant settings model
/// Maps to Tenant Service Settings API response
@freezed
class TenantSettings with _$TenantSettings {
  const factory TenantSettings({
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'max_daily_bookings') int? maxDailyBookings,
    @JsonKey(name: 'allow_walkins') bool? allowWalkins,
    @JsonKey(name: 'cancellation_window_minutes') int? cancellationWindowMinutes,
    @JsonKey(name: 'queue_enabled') bool? queueEnabled,
    @JsonKey(name: 'auto_assign_staff') bool? autoAssignStaff,
  }) = _TenantSettings;

  factory TenantSettings.fromJson(Map<String, dynamic> json) =>
      _$TenantSettingsFromJson(json);
}

/// Request model for updating tenant settings
@freezed
class UpdateSettingsRequest with _$UpdateSettingsRequest {
  const factory UpdateSettingsRequest({
    @JsonKey(name: 'max_daily_bookings') int? maxDailyBookings,
    @JsonKey(name: 'allow_walkins') bool? allowWalkins,
    @JsonKey(name: 'cancellation_window_minutes') int? cancellationWindowMinutes,
    @JsonKey(name: 'queue_enabled') bool? queueEnabled,
    @JsonKey(name: 'auto_assign_staff') bool? autoAssignStaff,
  }) = _UpdateSettingsRequest;

  factory UpdateSettingsRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateSettingsRequestFromJson(json);
}
