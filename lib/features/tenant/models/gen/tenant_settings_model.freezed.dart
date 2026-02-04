// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../tenant_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TenantSettings _$TenantSettingsFromJson(Map<String, dynamic> json) {
  return _TenantSettings.fromJson(json);
}

/// @nodoc
mixin _$TenantSettings {
  @JsonKey(name: 'tenant_id')
  String? get tenantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_daily_bookings')
  int? get maxDailyBookings => throw _privateConstructorUsedError;
  @JsonKey(name: 'allow_walkins')
  bool? get allowWalkins => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancellation_window_minutes')
  int? get cancellationWindowMinutes => throw _privateConstructorUsedError;
  @JsonKey(name: 'queue_enabled')
  bool? get queueEnabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'auto_assign_staff')
  bool? get autoAssignStaff => throw _privateConstructorUsedError;

  /// Serializes this TenantSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TenantSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TenantSettingsCopyWith<TenantSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TenantSettingsCopyWith<$Res> {
  factory $TenantSettingsCopyWith(
    TenantSettings value,
    $Res Function(TenantSettings) then,
  ) = _$TenantSettingsCopyWithImpl<$Res, TenantSettings>;
  @useResult
  $Res call({
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'max_daily_bookings') int? maxDailyBookings,
    @JsonKey(name: 'allow_walkins') bool? allowWalkins,
    @JsonKey(name: 'cancellation_window_minutes')
    int? cancellationWindowMinutes,
    @JsonKey(name: 'queue_enabled') bool? queueEnabled,
    @JsonKey(name: 'auto_assign_staff') bool? autoAssignStaff,
  });
}

/// @nodoc
class _$TenantSettingsCopyWithImpl<$Res, $Val extends TenantSettings>
    implements $TenantSettingsCopyWith<$Res> {
  _$TenantSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TenantSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tenantId = freezed,
    Object? maxDailyBookings = freezed,
    Object? allowWalkins = freezed,
    Object? cancellationWindowMinutes = freezed,
    Object? queueEnabled = freezed,
    Object? autoAssignStaff = freezed,
  }) {
    return _then(
      _value.copyWith(
            tenantId: freezed == tenantId
                ? _value.tenantId
                : tenantId // ignore: cast_nullable_to_non_nullable
                      as String?,
            maxDailyBookings: freezed == maxDailyBookings
                ? _value.maxDailyBookings
                : maxDailyBookings // ignore: cast_nullable_to_non_nullable
                      as int?,
            allowWalkins: freezed == allowWalkins
                ? _value.allowWalkins
                : allowWalkins // ignore: cast_nullable_to_non_nullable
                      as bool?,
            cancellationWindowMinutes: freezed == cancellationWindowMinutes
                ? _value.cancellationWindowMinutes
                : cancellationWindowMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            queueEnabled: freezed == queueEnabled
                ? _value.queueEnabled
                : queueEnabled // ignore: cast_nullable_to_non_nullable
                      as bool?,
            autoAssignStaff: freezed == autoAssignStaff
                ? _value.autoAssignStaff
                : autoAssignStaff // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TenantSettingsImplCopyWith<$Res>
    implements $TenantSettingsCopyWith<$Res> {
  factory _$$TenantSettingsImplCopyWith(
    _$TenantSettingsImpl value,
    $Res Function(_$TenantSettingsImpl) then,
  ) = __$$TenantSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'max_daily_bookings') int? maxDailyBookings,
    @JsonKey(name: 'allow_walkins') bool? allowWalkins,
    @JsonKey(name: 'cancellation_window_minutes')
    int? cancellationWindowMinutes,
    @JsonKey(name: 'queue_enabled') bool? queueEnabled,
    @JsonKey(name: 'auto_assign_staff') bool? autoAssignStaff,
  });
}

/// @nodoc
class __$$TenantSettingsImplCopyWithImpl<$Res>
    extends _$TenantSettingsCopyWithImpl<$Res, _$TenantSettingsImpl>
    implements _$$TenantSettingsImplCopyWith<$Res> {
  __$$TenantSettingsImplCopyWithImpl(
    _$TenantSettingsImpl _value,
    $Res Function(_$TenantSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TenantSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tenantId = freezed,
    Object? maxDailyBookings = freezed,
    Object? allowWalkins = freezed,
    Object? cancellationWindowMinutes = freezed,
    Object? queueEnabled = freezed,
    Object? autoAssignStaff = freezed,
  }) {
    return _then(
      _$TenantSettingsImpl(
        tenantId: freezed == tenantId
            ? _value.tenantId
            : tenantId // ignore: cast_nullable_to_non_nullable
                  as String?,
        maxDailyBookings: freezed == maxDailyBookings
            ? _value.maxDailyBookings
            : maxDailyBookings // ignore: cast_nullable_to_non_nullable
                  as int?,
        allowWalkins: freezed == allowWalkins
            ? _value.allowWalkins
            : allowWalkins // ignore: cast_nullable_to_non_nullable
                  as bool?,
        cancellationWindowMinutes: freezed == cancellationWindowMinutes
            ? _value.cancellationWindowMinutes
            : cancellationWindowMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        queueEnabled: freezed == queueEnabled
            ? _value.queueEnabled
            : queueEnabled // ignore: cast_nullable_to_non_nullable
                  as bool?,
        autoAssignStaff: freezed == autoAssignStaff
            ? _value.autoAssignStaff
            : autoAssignStaff // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TenantSettingsImpl implements _TenantSettings {
  const _$TenantSettingsImpl({
    @JsonKey(name: 'tenant_id') this.tenantId,
    @JsonKey(name: 'max_daily_bookings') this.maxDailyBookings,
    @JsonKey(name: 'allow_walkins') this.allowWalkins,
    @JsonKey(name: 'cancellation_window_minutes')
    this.cancellationWindowMinutes,
    @JsonKey(name: 'queue_enabled') this.queueEnabled,
    @JsonKey(name: 'auto_assign_staff') this.autoAssignStaff,
  });

  factory _$TenantSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TenantSettingsImplFromJson(json);

  @override
  @JsonKey(name: 'tenant_id')
  final String? tenantId;
  @override
  @JsonKey(name: 'max_daily_bookings')
  final int? maxDailyBookings;
  @override
  @JsonKey(name: 'allow_walkins')
  final bool? allowWalkins;
  @override
  @JsonKey(name: 'cancellation_window_minutes')
  final int? cancellationWindowMinutes;
  @override
  @JsonKey(name: 'queue_enabled')
  final bool? queueEnabled;
  @override
  @JsonKey(name: 'auto_assign_staff')
  final bool? autoAssignStaff;

  @override
  String toString() {
    return 'TenantSettings(tenantId: $tenantId, maxDailyBookings: $maxDailyBookings, allowWalkins: $allowWalkins, cancellationWindowMinutes: $cancellationWindowMinutes, queueEnabled: $queueEnabled, autoAssignStaff: $autoAssignStaff)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TenantSettingsImpl &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.maxDailyBookings, maxDailyBookings) ||
                other.maxDailyBookings == maxDailyBookings) &&
            (identical(other.allowWalkins, allowWalkins) ||
                other.allowWalkins == allowWalkins) &&
            (identical(
                  other.cancellationWindowMinutes,
                  cancellationWindowMinutes,
                ) ||
                other.cancellationWindowMinutes == cancellationWindowMinutes) &&
            (identical(other.queueEnabled, queueEnabled) ||
                other.queueEnabled == queueEnabled) &&
            (identical(other.autoAssignStaff, autoAssignStaff) ||
                other.autoAssignStaff == autoAssignStaff));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tenantId,
    maxDailyBookings,
    allowWalkins,
    cancellationWindowMinutes,
    queueEnabled,
    autoAssignStaff,
  );

  /// Create a copy of TenantSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TenantSettingsImplCopyWith<_$TenantSettingsImpl> get copyWith =>
      __$$TenantSettingsImplCopyWithImpl<_$TenantSettingsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TenantSettingsImplToJson(this);
  }
}

abstract class _TenantSettings implements TenantSettings {
  const factory _TenantSettings({
    @JsonKey(name: 'tenant_id') final String? tenantId,
    @JsonKey(name: 'max_daily_bookings') final int? maxDailyBookings,
    @JsonKey(name: 'allow_walkins') final bool? allowWalkins,
    @JsonKey(name: 'cancellation_window_minutes')
    final int? cancellationWindowMinutes,
    @JsonKey(name: 'queue_enabled') final bool? queueEnabled,
    @JsonKey(name: 'auto_assign_staff') final bool? autoAssignStaff,
  }) = _$TenantSettingsImpl;

  factory _TenantSettings.fromJson(Map<String, dynamic> json) =
      _$TenantSettingsImpl.fromJson;

  @override
  @JsonKey(name: 'tenant_id')
  String? get tenantId;
  @override
  @JsonKey(name: 'max_daily_bookings')
  int? get maxDailyBookings;
  @override
  @JsonKey(name: 'allow_walkins')
  bool? get allowWalkins;
  @override
  @JsonKey(name: 'cancellation_window_minutes')
  int? get cancellationWindowMinutes;
  @override
  @JsonKey(name: 'queue_enabled')
  bool? get queueEnabled;
  @override
  @JsonKey(name: 'auto_assign_staff')
  bool? get autoAssignStaff;

  /// Create a copy of TenantSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TenantSettingsImplCopyWith<_$TenantSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateSettingsRequest _$UpdateSettingsRequestFromJson(
  Map<String, dynamic> json,
) {
  return _UpdateSettingsRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateSettingsRequest {
  @JsonKey(name: 'max_daily_bookings')
  int? get maxDailyBookings => throw _privateConstructorUsedError;
  @JsonKey(name: 'allow_walkins')
  bool? get allowWalkins => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancellation_window_minutes')
  int? get cancellationWindowMinutes => throw _privateConstructorUsedError;
  @JsonKey(name: 'queue_enabled')
  bool? get queueEnabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'auto_assign_staff')
  bool? get autoAssignStaff => throw _privateConstructorUsedError;

  /// Serializes this UpdateSettingsRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateSettingsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateSettingsRequestCopyWith<UpdateSettingsRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateSettingsRequestCopyWith<$Res> {
  factory $UpdateSettingsRequestCopyWith(
    UpdateSettingsRequest value,
    $Res Function(UpdateSettingsRequest) then,
  ) = _$UpdateSettingsRequestCopyWithImpl<$Res, UpdateSettingsRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'max_daily_bookings') int? maxDailyBookings,
    @JsonKey(name: 'allow_walkins') bool? allowWalkins,
    @JsonKey(name: 'cancellation_window_minutes')
    int? cancellationWindowMinutes,
    @JsonKey(name: 'queue_enabled') bool? queueEnabled,
    @JsonKey(name: 'auto_assign_staff') bool? autoAssignStaff,
  });
}

/// @nodoc
class _$UpdateSettingsRequestCopyWithImpl<
  $Res,
  $Val extends UpdateSettingsRequest
>
    implements $UpdateSettingsRequestCopyWith<$Res> {
  _$UpdateSettingsRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateSettingsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxDailyBookings = freezed,
    Object? allowWalkins = freezed,
    Object? cancellationWindowMinutes = freezed,
    Object? queueEnabled = freezed,
    Object? autoAssignStaff = freezed,
  }) {
    return _then(
      _value.copyWith(
            maxDailyBookings: freezed == maxDailyBookings
                ? _value.maxDailyBookings
                : maxDailyBookings // ignore: cast_nullable_to_non_nullable
                      as int?,
            allowWalkins: freezed == allowWalkins
                ? _value.allowWalkins
                : allowWalkins // ignore: cast_nullable_to_non_nullable
                      as bool?,
            cancellationWindowMinutes: freezed == cancellationWindowMinutes
                ? _value.cancellationWindowMinutes
                : cancellationWindowMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            queueEnabled: freezed == queueEnabled
                ? _value.queueEnabled
                : queueEnabled // ignore: cast_nullable_to_non_nullable
                      as bool?,
            autoAssignStaff: freezed == autoAssignStaff
                ? _value.autoAssignStaff
                : autoAssignStaff // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateSettingsRequestImplCopyWith<$Res>
    implements $UpdateSettingsRequestCopyWith<$Res> {
  factory _$$UpdateSettingsRequestImplCopyWith(
    _$UpdateSettingsRequestImpl value,
    $Res Function(_$UpdateSettingsRequestImpl) then,
  ) = __$$UpdateSettingsRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'max_daily_bookings') int? maxDailyBookings,
    @JsonKey(name: 'allow_walkins') bool? allowWalkins,
    @JsonKey(name: 'cancellation_window_minutes')
    int? cancellationWindowMinutes,
    @JsonKey(name: 'queue_enabled') bool? queueEnabled,
    @JsonKey(name: 'auto_assign_staff') bool? autoAssignStaff,
  });
}

/// @nodoc
class __$$UpdateSettingsRequestImplCopyWithImpl<$Res>
    extends
        _$UpdateSettingsRequestCopyWithImpl<$Res, _$UpdateSettingsRequestImpl>
    implements _$$UpdateSettingsRequestImplCopyWith<$Res> {
  __$$UpdateSettingsRequestImplCopyWithImpl(
    _$UpdateSettingsRequestImpl _value,
    $Res Function(_$UpdateSettingsRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateSettingsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxDailyBookings = freezed,
    Object? allowWalkins = freezed,
    Object? cancellationWindowMinutes = freezed,
    Object? queueEnabled = freezed,
    Object? autoAssignStaff = freezed,
  }) {
    return _then(
      _$UpdateSettingsRequestImpl(
        maxDailyBookings: freezed == maxDailyBookings
            ? _value.maxDailyBookings
            : maxDailyBookings // ignore: cast_nullable_to_non_nullable
                  as int?,
        allowWalkins: freezed == allowWalkins
            ? _value.allowWalkins
            : allowWalkins // ignore: cast_nullable_to_non_nullable
                  as bool?,
        cancellationWindowMinutes: freezed == cancellationWindowMinutes
            ? _value.cancellationWindowMinutes
            : cancellationWindowMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        queueEnabled: freezed == queueEnabled
            ? _value.queueEnabled
            : queueEnabled // ignore: cast_nullable_to_non_nullable
                  as bool?,
        autoAssignStaff: freezed == autoAssignStaff
            ? _value.autoAssignStaff
            : autoAssignStaff // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateSettingsRequestImpl implements _UpdateSettingsRequest {
  const _$UpdateSettingsRequestImpl({
    @JsonKey(name: 'max_daily_bookings') this.maxDailyBookings,
    @JsonKey(name: 'allow_walkins') this.allowWalkins,
    @JsonKey(name: 'cancellation_window_minutes')
    this.cancellationWindowMinutes,
    @JsonKey(name: 'queue_enabled') this.queueEnabled,
    @JsonKey(name: 'auto_assign_staff') this.autoAssignStaff,
  });

  factory _$UpdateSettingsRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateSettingsRequestImplFromJson(json);

  @override
  @JsonKey(name: 'max_daily_bookings')
  final int? maxDailyBookings;
  @override
  @JsonKey(name: 'allow_walkins')
  final bool? allowWalkins;
  @override
  @JsonKey(name: 'cancellation_window_minutes')
  final int? cancellationWindowMinutes;
  @override
  @JsonKey(name: 'queue_enabled')
  final bool? queueEnabled;
  @override
  @JsonKey(name: 'auto_assign_staff')
  final bool? autoAssignStaff;

  @override
  String toString() {
    return 'UpdateSettingsRequest(maxDailyBookings: $maxDailyBookings, allowWalkins: $allowWalkins, cancellationWindowMinutes: $cancellationWindowMinutes, queueEnabled: $queueEnabled, autoAssignStaff: $autoAssignStaff)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateSettingsRequestImpl &&
            (identical(other.maxDailyBookings, maxDailyBookings) ||
                other.maxDailyBookings == maxDailyBookings) &&
            (identical(other.allowWalkins, allowWalkins) ||
                other.allowWalkins == allowWalkins) &&
            (identical(
                  other.cancellationWindowMinutes,
                  cancellationWindowMinutes,
                ) ||
                other.cancellationWindowMinutes == cancellationWindowMinutes) &&
            (identical(other.queueEnabled, queueEnabled) ||
                other.queueEnabled == queueEnabled) &&
            (identical(other.autoAssignStaff, autoAssignStaff) ||
                other.autoAssignStaff == autoAssignStaff));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    maxDailyBookings,
    allowWalkins,
    cancellationWindowMinutes,
    queueEnabled,
    autoAssignStaff,
  );

  /// Create a copy of UpdateSettingsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateSettingsRequestImplCopyWith<_$UpdateSettingsRequestImpl>
  get copyWith =>
      __$$UpdateSettingsRequestImplCopyWithImpl<_$UpdateSettingsRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateSettingsRequestImplToJson(this);
  }
}

abstract class _UpdateSettingsRequest implements UpdateSettingsRequest {
  const factory _UpdateSettingsRequest({
    @JsonKey(name: 'max_daily_bookings') final int? maxDailyBookings,
    @JsonKey(name: 'allow_walkins') final bool? allowWalkins,
    @JsonKey(name: 'cancellation_window_minutes')
    final int? cancellationWindowMinutes,
    @JsonKey(name: 'queue_enabled') final bool? queueEnabled,
    @JsonKey(name: 'auto_assign_staff') final bool? autoAssignStaff,
  }) = _$UpdateSettingsRequestImpl;

  factory _UpdateSettingsRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateSettingsRequestImpl.fromJson;

  @override
  @JsonKey(name: 'max_daily_bookings')
  int? get maxDailyBookings;
  @override
  @JsonKey(name: 'allow_walkins')
  bool? get allowWalkins;
  @override
  @JsonKey(name: 'cancellation_window_minutes')
  int? get cancellationWindowMinutes;
  @override
  @JsonKey(name: 'queue_enabled')
  bool? get queueEnabled;
  @override
  @JsonKey(name: 'auto_assign_staff')
  bool? get autoAssignStaff;

  /// Create a copy of UpdateSettingsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateSettingsRequestImplCopyWith<_$UpdateSettingsRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
