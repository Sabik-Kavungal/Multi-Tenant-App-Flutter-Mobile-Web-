// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../working_hours_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WorkingHours _$WorkingHoursFromJson(Map<String, dynamic> json) {
  return _WorkingHours.fromJson(json);
}

/// @nodoc
mixin _$WorkingHours {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'tenant_id')
  String? get tenantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'day_of_week')
  int? get dayOfWeek => throw _privateConstructorUsedError;
  @JsonKey(name: 'open_time')
  String? get openTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'close_time')
  String? get closeTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_closed')
  bool? get isClosed => throw _privateConstructorUsedError;

  /// Serializes this WorkingHours to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkingHours
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkingHoursCopyWith<WorkingHours> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkingHoursCopyWith<$Res> {
  factory $WorkingHoursCopyWith(
    WorkingHours value,
    $Res Function(WorkingHours) then,
  ) = _$WorkingHoursCopyWithImpl<$Res, WorkingHours>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'day_of_week') int? dayOfWeek,
    @JsonKey(name: 'open_time') String? openTime,
    @JsonKey(name: 'close_time') String? closeTime,
    @JsonKey(name: 'is_closed') bool? isClosed,
  });
}

/// @nodoc
class _$WorkingHoursCopyWithImpl<$Res, $Val extends WorkingHours>
    implements $WorkingHoursCopyWith<$Res> {
  _$WorkingHoursCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkingHours
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? dayOfWeek = freezed,
    Object? openTime = freezed,
    Object? closeTime = freezed,
    Object? isClosed = freezed,
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
            dayOfWeek: freezed == dayOfWeek
                ? _value.dayOfWeek
                : dayOfWeek // ignore: cast_nullable_to_non_nullable
                      as int?,
            openTime: freezed == openTime
                ? _value.openTime
                : openTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            closeTime: freezed == closeTime
                ? _value.closeTime
                : closeTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            isClosed: freezed == isClosed
                ? _value.isClosed
                : isClosed // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkingHoursImplCopyWith<$Res>
    implements $WorkingHoursCopyWith<$Res> {
  factory _$$WorkingHoursImplCopyWith(
    _$WorkingHoursImpl value,
    $Res Function(_$WorkingHoursImpl) then,
  ) = __$$WorkingHoursImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'day_of_week') int? dayOfWeek,
    @JsonKey(name: 'open_time') String? openTime,
    @JsonKey(name: 'close_time') String? closeTime,
    @JsonKey(name: 'is_closed') bool? isClosed,
  });
}

/// @nodoc
class __$$WorkingHoursImplCopyWithImpl<$Res>
    extends _$WorkingHoursCopyWithImpl<$Res, _$WorkingHoursImpl>
    implements _$$WorkingHoursImplCopyWith<$Res> {
  __$$WorkingHoursImplCopyWithImpl(
    _$WorkingHoursImpl _value,
    $Res Function(_$WorkingHoursImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkingHours
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? dayOfWeek = freezed,
    Object? openTime = freezed,
    Object? closeTime = freezed,
    Object? isClosed = freezed,
  }) {
    return _then(
      _$WorkingHoursImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        tenantId: freezed == tenantId
            ? _value.tenantId
            : tenantId // ignore: cast_nullable_to_non_nullable
                  as String?,
        dayOfWeek: freezed == dayOfWeek
            ? _value.dayOfWeek
            : dayOfWeek // ignore: cast_nullable_to_non_nullable
                  as int?,
        openTime: freezed == openTime
            ? _value.openTime
            : openTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        closeTime: freezed == closeTime
            ? _value.closeTime
            : closeTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        isClosed: freezed == isClosed
            ? _value.isClosed
            : isClosed // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkingHoursImpl implements _WorkingHours {
  const _$WorkingHoursImpl({
    this.id,
    @JsonKey(name: 'tenant_id') this.tenantId,
    @JsonKey(name: 'day_of_week') this.dayOfWeek,
    @JsonKey(name: 'open_time') this.openTime,
    @JsonKey(name: 'close_time') this.closeTime,
    @JsonKey(name: 'is_closed') this.isClosed,
  });

  factory _$WorkingHoursImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkingHoursImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'tenant_id')
  final String? tenantId;
  @override
  @JsonKey(name: 'day_of_week')
  final int? dayOfWeek;
  @override
  @JsonKey(name: 'open_time')
  final String? openTime;
  @override
  @JsonKey(name: 'close_time')
  final String? closeTime;
  @override
  @JsonKey(name: 'is_closed')
  final bool? isClosed;

  @override
  String toString() {
    return 'WorkingHours(id: $id, tenantId: $tenantId, dayOfWeek: $dayOfWeek, openTime: $openTime, closeTime: $closeTime, isClosed: $isClosed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkingHoursImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.openTime, openTime) ||
                other.openTime == openTime) &&
            (identical(other.closeTime, closeTime) ||
                other.closeTime == closeTime) &&
            (identical(other.isClosed, isClosed) ||
                other.isClosed == isClosed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    tenantId,
    dayOfWeek,
    openTime,
    closeTime,
    isClosed,
  );

  /// Create a copy of WorkingHours
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkingHoursImplCopyWith<_$WorkingHoursImpl> get copyWith =>
      __$$WorkingHoursImplCopyWithImpl<_$WorkingHoursImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkingHoursImplToJson(this);
  }
}

abstract class _WorkingHours implements WorkingHours {
  const factory _WorkingHours({
    final String? id,
    @JsonKey(name: 'tenant_id') final String? tenantId,
    @JsonKey(name: 'day_of_week') final int? dayOfWeek,
    @JsonKey(name: 'open_time') final String? openTime,
    @JsonKey(name: 'close_time') final String? closeTime,
    @JsonKey(name: 'is_closed') final bool? isClosed,
  }) = _$WorkingHoursImpl;

  factory _WorkingHours.fromJson(Map<String, dynamic> json) =
      _$WorkingHoursImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'tenant_id')
  String? get tenantId;
  @override
  @JsonKey(name: 'day_of_week')
  int? get dayOfWeek;
  @override
  @JsonKey(name: 'open_time')
  String? get openTime;
  @override
  @JsonKey(name: 'close_time')
  String? get closeTime;
  @override
  @JsonKey(name: 'is_closed')
  bool? get isClosed;

  /// Create a copy of WorkingHours
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkingHoursImplCopyWith<_$WorkingHoursImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkingHoursInput _$WorkingHoursInputFromJson(Map<String, dynamic> json) {
  return _WorkingHoursInput.fromJson(json);
}

/// @nodoc
mixin _$WorkingHoursInput {
  @JsonKey(name: 'day_of_week')
  int get dayOfWeek => throw _privateConstructorUsedError;
  @JsonKey(name: 'open_time')
  String? get openTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'close_time')
  String? get closeTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_closed')
  bool get isClosed => throw _privateConstructorUsedError;

  /// Serializes this WorkingHoursInput to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkingHoursInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkingHoursInputCopyWith<WorkingHoursInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkingHoursInputCopyWith<$Res> {
  factory $WorkingHoursInputCopyWith(
    WorkingHoursInput value,
    $Res Function(WorkingHoursInput) then,
  ) = _$WorkingHoursInputCopyWithImpl<$Res, WorkingHoursInput>;
  @useResult
  $Res call({
    @JsonKey(name: 'day_of_week') int dayOfWeek,
    @JsonKey(name: 'open_time') String? openTime,
    @JsonKey(name: 'close_time') String? closeTime,
    @JsonKey(name: 'is_closed') bool isClosed,
  });
}

/// @nodoc
class _$WorkingHoursInputCopyWithImpl<$Res, $Val extends WorkingHoursInput>
    implements $WorkingHoursInputCopyWith<$Res> {
  _$WorkingHoursInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkingHoursInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dayOfWeek = null,
    Object? openTime = freezed,
    Object? closeTime = freezed,
    Object? isClosed = null,
  }) {
    return _then(
      _value.copyWith(
            dayOfWeek: null == dayOfWeek
                ? _value.dayOfWeek
                : dayOfWeek // ignore: cast_nullable_to_non_nullable
                      as int,
            openTime: freezed == openTime
                ? _value.openTime
                : openTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            closeTime: freezed == closeTime
                ? _value.closeTime
                : closeTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            isClosed: null == isClosed
                ? _value.isClosed
                : isClosed // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkingHoursInputImplCopyWith<$Res>
    implements $WorkingHoursInputCopyWith<$Res> {
  factory _$$WorkingHoursInputImplCopyWith(
    _$WorkingHoursInputImpl value,
    $Res Function(_$WorkingHoursInputImpl) then,
  ) = __$$WorkingHoursInputImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'day_of_week') int dayOfWeek,
    @JsonKey(name: 'open_time') String? openTime,
    @JsonKey(name: 'close_time') String? closeTime,
    @JsonKey(name: 'is_closed') bool isClosed,
  });
}

/// @nodoc
class __$$WorkingHoursInputImplCopyWithImpl<$Res>
    extends _$WorkingHoursInputCopyWithImpl<$Res, _$WorkingHoursInputImpl>
    implements _$$WorkingHoursInputImplCopyWith<$Res> {
  __$$WorkingHoursInputImplCopyWithImpl(
    _$WorkingHoursInputImpl _value,
    $Res Function(_$WorkingHoursInputImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkingHoursInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dayOfWeek = null,
    Object? openTime = freezed,
    Object? closeTime = freezed,
    Object? isClosed = null,
  }) {
    return _then(
      _$WorkingHoursInputImpl(
        dayOfWeek: null == dayOfWeek
            ? _value.dayOfWeek
            : dayOfWeek // ignore: cast_nullable_to_non_nullable
                  as int,
        openTime: freezed == openTime
            ? _value.openTime
            : openTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        closeTime: freezed == closeTime
            ? _value.closeTime
            : closeTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        isClosed: null == isClosed
            ? _value.isClosed
            : isClosed // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkingHoursInputImpl implements _WorkingHoursInput {
  const _$WorkingHoursInputImpl({
    @JsonKey(name: 'day_of_week') required this.dayOfWeek,
    @JsonKey(name: 'open_time') this.openTime,
    @JsonKey(name: 'close_time') this.closeTime,
    @JsonKey(name: 'is_closed') required this.isClosed,
  });

  factory _$WorkingHoursInputImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkingHoursInputImplFromJson(json);

  @override
  @JsonKey(name: 'day_of_week')
  final int dayOfWeek;
  @override
  @JsonKey(name: 'open_time')
  final String? openTime;
  @override
  @JsonKey(name: 'close_time')
  final String? closeTime;
  @override
  @JsonKey(name: 'is_closed')
  final bool isClosed;

  @override
  String toString() {
    return 'WorkingHoursInput(dayOfWeek: $dayOfWeek, openTime: $openTime, closeTime: $closeTime, isClosed: $isClosed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkingHoursInputImpl &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.openTime, openTime) ||
                other.openTime == openTime) &&
            (identical(other.closeTime, closeTime) ||
                other.closeTime == closeTime) &&
            (identical(other.isClosed, isClosed) ||
                other.isClosed == isClosed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, dayOfWeek, openTime, closeTime, isClosed);

  /// Create a copy of WorkingHoursInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkingHoursInputImplCopyWith<_$WorkingHoursInputImpl> get copyWith =>
      __$$WorkingHoursInputImplCopyWithImpl<_$WorkingHoursInputImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkingHoursInputImplToJson(this);
  }
}

abstract class _WorkingHoursInput implements WorkingHoursInput {
  const factory _WorkingHoursInput({
    @JsonKey(name: 'day_of_week') required final int dayOfWeek,
    @JsonKey(name: 'open_time') final String? openTime,
    @JsonKey(name: 'close_time') final String? closeTime,
    @JsonKey(name: 'is_closed') required final bool isClosed,
  }) = _$WorkingHoursInputImpl;

  factory _WorkingHoursInput.fromJson(Map<String, dynamic> json) =
      _$WorkingHoursInputImpl.fromJson;

  @override
  @JsonKey(name: 'day_of_week')
  int get dayOfWeek;
  @override
  @JsonKey(name: 'open_time')
  String? get openTime;
  @override
  @JsonKey(name: 'close_time')
  String? get closeTime;
  @override
  @JsonKey(name: 'is_closed')
  bool get isClosed;

  /// Create a copy of WorkingHoursInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkingHoursInputImplCopyWith<_$WorkingHoursInputImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateWorkingHoursRequest _$UpdateWorkingHoursRequestFromJson(
  Map<String, dynamic> json,
) {
  return _UpdateWorkingHoursRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateWorkingHoursRequest {
  List<WorkingHoursInput> get hours => throw _privateConstructorUsedError;

  /// Serializes this UpdateWorkingHoursRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateWorkingHoursRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateWorkingHoursRequestCopyWith<UpdateWorkingHoursRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateWorkingHoursRequestCopyWith<$Res> {
  factory $UpdateWorkingHoursRequestCopyWith(
    UpdateWorkingHoursRequest value,
    $Res Function(UpdateWorkingHoursRequest) then,
  ) = _$UpdateWorkingHoursRequestCopyWithImpl<$Res, UpdateWorkingHoursRequest>;
  @useResult
  $Res call({List<WorkingHoursInput> hours});
}

/// @nodoc
class _$UpdateWorkingHoursRequestCopyWithImpl<
  $Res,
  $Val extends UpdateWorkingHoursRequest
>
    implements $UpdateWorkingHoursRequestCopyWith<$Res> {
  _$UpdateWorkingHoursRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateWorkingHoursRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? hours = null}) {
    return _then(
      _value.copyWith(
            hours: null == hours
                ? _value.hours
                : hours // ignore: cast_nullable_to_non_nullable
                      as List<WorkingHoursInput>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateWorkingHoursRequestImplCopyWith<$Res>
    implements $UpdateWorkingHoursRequestCopyWith<$Res> {
  factory _$$UpdateWorkingHoursRequestImplCopyWith(
    _$UpdateWorkingHoursRequestImpl value,
    $Res Function(_$UpdateWorkingHoursRequestImpl) then,
  ) = __$$UpdateWorkingHoursRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<WorkingHoursInput> hours});
}

/// @nodoc
class __$$UpdateWorkingHoursRequestImplCopyWithImpl<$Res>
    extends
        _$UpdateWorkingHoursRequestCopyWithImpl<
          $Res,
          _$UpdateWorkingHoursRequestImpl
        >
    implements _$$UpdateWorkingHoursRequestImplCopyWith<$Res> {
  __$$UpdateWorkingHoursRequestImplCopyWithImpl(
    _$UpdateWorkingHoursRequestImpl _value,
    $Res Function(_$UpdateWorkingHoursRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateWorkingHoursRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? hours = null}) {
    return _then(
      _$UpdateWorkingHoursRequestImpl(
        hours: null == hours
            ? _value._hours
            : hours // ignore: cast_nullable_to_non_nullable
                  as List<WorkingHoursInput>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateWorkingHoursRequestImpl implements _UpdateWorkingHoursRequest {
  const _$UpdateWorkingHoursRequestImpl({
    required final List<WorkingHoursInput> hours,
  }) : _hours = hours;

  factory _$UpdateWorkingHoursRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateWorkingHoursRequestImplFromJson(json);

  final List<WorkingHoursInput> _hours;
  @override
  List<WorkingHoursInput> get hours {
    if (_hours is EqualUnmodifiableListView) return _hours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hours);
  }

  @override
  String toString() {
    return 'UpdateWorkingHoursRequest(hours: $hours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateWorkingHoursRequestImpl &&
            const DeepCollectionEquality().equals(other._hours, _hours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_hours));

  /// Create a copy of UpdateWorkingHoursRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateWorkingHoursRequestImplCopyWith<_$UpdateWorkingHoursRequestImpl>
  get copyWith =>
      __$$UpdateWorkingHoursRequestImplCopyWithImpl<
        _$UpdateWorkingHoursRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateWorkingHoursRequestImplToJson(this);
  }
}

abstract class _UpdateWorkingHoursRequest implements UpdateWorkingHoursRequest {
  const factory _UpdateWorkingHoursRequest({
    required final List<WorkingHoursInput> hours,
  }) = _$UpdateWorkingHoursRequestImpl;

  factory _UpdateWorkingHoursRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateWorkingHoursRequestImpl.fromJson;

  @override
  List<WorkingHoursInput> get hours;

  /// Create a copy of UpdateWorkingHoursRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateWorkingHoursRequestImplCopyWith<_$UpdateWorkingHoursRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
