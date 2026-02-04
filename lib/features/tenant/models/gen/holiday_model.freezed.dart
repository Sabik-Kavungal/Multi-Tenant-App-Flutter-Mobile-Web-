// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../holiday_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Holiday _$HolidayFromJson(Map<String, dynamic> json) {
  return _Holiday.fromJson(json);
}

/// @nodoc
mixin _$Holiday {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'tenant_id')
  String? get tenantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'holiday_date')
  String? get holidayDate => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;

  /// Serializes this Holiday to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Holiday
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HolidayCopyWith<Holiday> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HolidayCopyWith<$Res> {
  factory $HolidayCopyWith(Holiday value, $Res Function(Holiday) then) =
      _$HolidayCopyWithImpl<$Res, Holiday>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'holiday_date') String? holidayDate,
    String? reason,
  });
}

/// @nodoc
class _$HolidayCopyWithImpl<$Res, $Val extends Holiday>
    implements $HolidayCopyWith<$Res> {
  _$HolidayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Holiday
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? holidayDate = freezed,
    Object? reason = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            tenantId: freezed == tenantId
                ? _value.tenantId
                : tenantId // ignore: cast_nullable_to_non_nullable
                      as String?,
            holidayDate: freezed == holidayDate
                ? _value.holidayDate
                : holidayDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HolidayImplCopyWith<$Res> implements $HolidayCopyWith<$Res> {
  factory _$$HolidayImplCopyWith(
    _$HolidayImpl value,
    $Res Function(_$HolidayImpl) then,
  ) = __$$HolidayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'holiday_date') String? holidayDate,
    String? reason,
  });
}

/// @nodoc
class __$$HolidayImplCopyWithImpl<$Res>
    extends _$HolidayCopyWithImpl<$Res, _$HolidayImpl>
    implements _$$HolidayImplCopyWith<$Res> {
  __$$HolidayImplCopyWithImpl(
    _$HolidayImpl _value,
    $Res Function(_$HolidayImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Holiday
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? holidayDate = freezed,
    Object? reason = freezed,
  }) {
    return _then(
      _$HolidayImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        tenantId: freezed == tenantId
            ? _value.tenantId
            : tenantId // ignore: cast_nullable_to_non_nullable
                  as String?,
        holidayDate: freezed == holidayDate
            ? _value.holidayDate
            : holidayDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HolidayImpl implements _Holiday {
  const _$HolidayImpl({
    this.id,
    @JsonKey(name: 'tenant_id') this.tenantId,
    @JsonKey(name: 'holiday_date') this.holidayDate,
    this.reason,
  });

  factory _$HolidayImpl.fromJson(Map<String, dynamic> json) =>
      _$$HolidayImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'tenant_id')
  final String? tenantId;
  @override
  @JsonKey(name: 'holiday_date')
  final String? holidayDate;
  @override
  final String? reason;

  @override
  String toString() {
    return 'Holiday(id: $id, tenantId: $tenantId, holidayDate: $holidayDate, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HolidayImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.holidayDate, holidayDate) ||
                other.holidayDate == holidayDate) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, tenantId, holidayDate, reason);

  /// Create a copy of Holiday
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HolidayImplCopyWith<_$HolidayImpl> get copyWith =>
      __$$HolidayImplCopyWithImpl<_$HolidayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HolidayImplToJson(this);
  }
}

abstract class _Holiday implements Holiday {
  const factory _Holiday({
    final String? id,
    @JsonKey(name: 'tenant_id') final String? tenantId,
    @JsonKey(name: 'holiday_date') final String? holidayDate,
    final String? reason,
  }) = _$HolidayImpl;

  factory _Holiday.fromJson(Map<String, dynamic> json) = _$HolidayImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'tenant_id')
  String? get tenantId;
  @override
  @JsonKey(name: 'holiday_date')
  String? get holidayDate;
  @override
  String? get reason;

  /// Create a copy of Holiday
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HolidayImplCopyWith<_$HolidayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateHolidayRequest _$CreateHolidayRequestFromJson(Map<String, dynamic> json) {
  return _CreateHolidayRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateHolidayRequest {
  @JsonKey(name: 'holiday_date')
  String get holidayDate => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;

  /// Serializes this CreateHolidayRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateHolidayRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateHolidayRequestCopyWith<CreateHolidayRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateHolidayRequestCopyWith<$Res> {
  factory $CreateHolidayRequestCopyWith(
    CreateHolidayRequest value,
    $Res Function(CreateHolidayRequest) then,
  ) = _$CreateHolidayRequestCopyWithImpl<$Res, CreateHolidayRequest>;
  @useResult
  $Res call({@JsonKey(name: 'holiday_date') String holidayDate, String reason});
}

/// @nodoc
class _$CreateHolidayRequestCopyWithImpl<
  $Res,
  $Val extends CreateHolidayRequest
>
    implements $CreateHolidayRequestCopyWith<$Res> {
  _$CreateHolidayRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateHolidayRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? holidayDate = null, Object? reason = null}) {
    return _then(
      _value.copyWith(
            holidayDate: null == holidayDate
                ? _value.holidayDate
                : holidayDate // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateHolidayRequestImplCopyWith<$Res>
    implements $CreateHolidayRequestCopyWith<$Res> {
  factory _$$CreateHolidayRequestImplCopyWith(
    _$CreateHolidayRequestImpl value,
    $Res Function(_$CreateHolidayRequestImpl) then,
  ) = __$$CreateHolidayRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'holiday_date') String holidayDate, String reason});
}

/// @nodoc
class __$$CreateHolidayRequestImplCopyWithImpl<$Res>
    extends _$CreateHolidayRequestCopyWithImpl<$Res, _$CreateHolidayRequestImpl>
    implements _$$CreateHolidayRequestImplCopyWith<$Res> {
  __$$CreateHolidayRequestImplCopyWithImpl(
    _$CreateHolidayRequestImpl _value,
    $Res Function(_$CreateHolidayRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateHolidayRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? holidayDate = null, Object? reason = null}) {
    return _then(
      _$CreateHolidayRequestImpl(
        holidayDate: null == holidayDate
            ? _value.holidayDate
            : holidayDate // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateHolidayRequestImpl implements _CreateHolidayRequest {
  const _$CreateHolidayRequestImpl({
    @JsonKey(name: 'holiday_date') required this.holidayDate,
    required this.reason,
  });

  factory _$CreateHolidayRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateHolidayRequestImplFromJson(json);

  @override
  @JsonKey(name: 'holiday_date')
  final String holidayDate;
  @override
  final String reason;

  @override
  String toString() {
    return 'CreateHolidayRequest(holidayDate: $holidayDate, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateHolidayRequestImpl &&
            (identical(other.holidayDate, holidayDate) ||
                other.holidayDate == holidayDate) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, holidayDate, reason);

  /// Create a copy of CreateHolidayRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateHolidayRequestImplCopyWith<_$CreateHolidayRequestImpl>
  get copyWith =>
      __$$CreateHolidayRequestImplCopyWithImpl<_$CreateHolidayRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateHolidayRequestImplToJson(this);
  }
}

abstract class _CreateHolidayRequest implements CreateHolidayRequest {
  const factory _CreateHolidayRequest({
    @JsonKey(name: 'holiday_date') required final String holidayDate,
    required final String reason,
  }) = _$CreateHolidayRequestImpl;

  factory _CreateHolidayRequest.fromJson(Map<String, dynamic> json) =
      _$CreateHolidayRequestImpl.fromJson;

  @override
  @JsonKey(name: 'holiday_date')
  String get holidayDate;
  @override
  String get reason;

  /// Create a copy of CreateHolidayRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateHolidayRequestImplCopyWith<_$CreateHolidayRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
