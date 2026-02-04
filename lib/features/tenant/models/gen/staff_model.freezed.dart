// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../staff_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Staff _$StaffFromJson(Map<String, dynamic> json) {
  return _Staff.fromJson(json);
}

/// @nodoc
mixin _$Staff {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'tenant_id')
  String? get tenantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  String? get designation => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool? get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'joined_at')
  String? get joinedAt => throw _privateConstructorUsedError;

  /// Serializes this Staff to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffCopyWith<Staff> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffCopyWith<$Res> {
  factory $StaffCopyWith(Staff value, $Res Function(Staff) then) =
      _$StaffCopyWithImpl<$Res, Staff>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'user_id') String? userId,
    String? designation,
    @JsonKey(name: 'is_active') bool? isActive,
    @JsonKey(name: 'joined_at') String? joinedAt,
  });
}

/// @nodoc
class _$StaffCopyWithImpl<$Res, $Val extends Staff>
    implements $StaffCopyWith<$Res> {
  _$StaffCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? userId = freezed,
    Object? designation = freezed,
    Object? isActive = freezed,
    Object? joinedAt = freezed,
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
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String?,
            designation: freezed == designation
                ? _value.designation
                : designation // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: freezed == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool?,
            joinedAt: freezed == joinedAt
                ? _value.joinedAt
                : joinedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StaffImplCopyWith<$Res> implements $StaffCopyWith<$Res> {
  factory _$$StaffImplCopyWith(
    _$StaffImpl value,
    $Res Function(_$StaffImpl) then,
  ) = __$$StaffImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'user_id') String? userId,
    String? designation,
    @JsonKey(name: 'is_active') bool? isActive,
    @JsonKey(name: 'joined_at') String? joinedAt,
  });
}

/// @nodoc
class __$$StaffImplCopyWithImpl<$Res>
    extends _$StaffCopyWithImpl<$Res, _$StaffImpl>
    implements _$$StaffImplCopyWith<$Res> {
  __$$StaffImplCopyWithImpl(
    _$StaffImpl _value,
    $Res Function(_$StaffImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? userId = freezed,
    Object? designation = freezed,
    Object? isActive = freezed,
    Object? joinedAt = freezed,
  }) {
    return _then(
      _$StaffImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        tenantId: freezed == tenantId
            ? _value.tenantId
            : tenantId // ignore: cast_nullable_to_non_nullable
                  as String?,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
        designation: freezed == designation
            ? _value.designation
            : designation // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: freezed == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool?,
        joinedAt: freezed == joinedAt
            ? _value.joinedAt
            : joinedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffImpl implements _Staff {
  const _$StaffImpl({
    this.id,
    @JsonKey(name: 'tenant_id') this.tenantId,
    @JsonKey(name: 'user_id') this.userId,
    this.designation,
    @JsonKey(name: 'is_active') this.isActive,
    @JsonKey(name: 'joined_at') this.joinedAt,
  });

  factory _$StaffImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'tenant_id')
  final String? tenantId;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  final String? designation;
  @override
  @JsonKey(name: 'is_active')
  final bool? isActive;
  @override
  @JsonKey(name: 'joined_at')
  final String? joinedAt;

  @override
  String toString() {
    return 'Staff(id: $id, tenantId: $tenantId, userId: $userId, designation: $designation, isActive: $isActive, joinedAt: $joinedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    tenantId,
    userId,
    designation,
    isActive,
    joinedAt,
  );

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffImplCopyWith<_$StaffImpl> get copyWith =>
      __$$StaffImplCopyWithImpl<_$StaffImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffImplToJson(this);
  }
}

abstract class _Staff implements Staff {
  const factory _Staff({
    final String? id,
    @JsonKey(name: 'tenant_id') final String? tenantId,
    @JsonKey(name: 'user_id') final String? userId,
    final String? designation,
    @JsonKey(name: 'is_active') final bool? isActive,
    @JsonKey(name: 'joined_at') final String? joinedAt,
  }) = _$StaffImpl;

  factory _Staff.fromJson(Map<String, dynamic> json) = _$StaffImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'tenant_id')
  String? get tenantId;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  String? get designation;
  @override
  @JsonKey(name: 'is_active')
  bool? get isActive;
  @override
  @JsonKey(name: 'joined_at')
  String? get joinedAt;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffImplCopyWith<_$StaffImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateStaffRequest _$CreateStaffRequestFromJson(Map<String, dynamic> json) {
  return _CreateStaffRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateStaffRequest {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get designation => throw _privateConstructorUsedError;

  /// Serializes this CreateStaffRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateStaffRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateStaffRequestCopyWith<CreateStaffRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateStaffRequestCopyWith<$Res> {
  factory $CreateStaffRequestCopyWith(
    CreateStaffRequest value,
    $Res Function(CreateStaffRequest) then,
  ) = _$CreateStaffRequestCopyWithImpl<$Res, CreateStaffRequest>;
  @useResult
  $Res call({@JsonKey(name: 'user_id') String userId, String designation});
}

/// @nodoc
class _$CreateStaffRequestCopyWithImpl<$Res, $Val extends CreateStaffRequest>
    implements $CreateStaffRequestCopyWith<$Res> {
  _$CreateStaffRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateStaffRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null, Object? designation = null}) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            designation: null == designation
                ? _value.designation
                : designation // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateStaffRequestImplCopyWith<$Res>
    implements $CreateStaffRequestCopyWith<$Res> {
  factory _$$CreateStaffRequestImplCopyWith(
    _$CreateStaffRequestImpl value,
    $Res Function(_$CreateStaffRequestImpl) then,
  ) = __$$CreateStaffRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'user_id') String userId, String designation});
}

/// @nodoc
class __$$CreateStaffRequestImplCopyWithImpl<$Res>
    extends _$CreateStaffRequestCopyWithImpl<$Res, _$CreateStaffRequestImpl>
    implements _$$CreateStaffRequestImplCopyWith<$Res> {
  __$$CreateStaffRequestImplCopyWithImpl(
    _$CreateStaffRequestImpl _value,
    $Res Function(_$CreateStaffRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateStaffRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null, Object? designation = null}) {
    return _then(
      _$CreateStaffRequestImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        designation: null == designation
            ? _value.designation
            : designation // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateStaffRequestImpl implements _CreateStaffRequest {
  const _$CreateStaffRequestImpl({
    @JsonKey(name: 'user_id') required this.userId,
    required this.designation,
  });

  factory _$CreateStaffRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateStaffRequestImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String designation;

  @override
  String toString() {
    return 'CreateStaffRequest(userId: $userId, designation: $designation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateStaffRequestImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.designation, designation) ||
                other.designation == designation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, designation);

  /// Create a copy of CreateStaffRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateStaffRequestImplCopyWith<_$CreateStaffRequestImpl> get copyWith =>
      __$$CreateStaffRequestImplCopyWithImpl<_$CreateStaffRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateStaffRequestImplToJson(this);
  }
}

abstract class _CreateStaffRequest implements CreateStaffRequest {
  const factory _CreateStaffRequest({
    @JsonKey(name: 'user_id') required final String userId,
    required final String designation,
  }) = _$CreateStaffRequestImpl;

  factory _CreateStaffRequest.fromJson(Map<String, dynamic> json) =
      _$CreateStaffRequestImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get designation;

  /// Create a copy of CreateStaffRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateStaffRequestImplCopyWith<_$CreateStaffRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateStaffRequest _$UpdateStaffRequestFromJson(Map<String, dynamic> json) {
  return _UpdateStaffRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateStaffRequest {
  String? get designation => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool? get isActive => throw _privateConstructorUsedError;

  /// Serializes this UpdateStaffRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateStaffRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateStaffRequestCopyWith<UpdateStaffRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateStaffRequestCopyWith<$Res> {
  factory $UpdateStaffRequestCopyWith(
    UpdateStaffRequest value,
    $Res Function(UpdateStaffRequest) then,
  ) = _$UpdateStaffRequestCopyWithImpl<$Res, UpdateStaffRequest>;
  @useResult
  $Res call({String? designation, @JsonKey(name: 'is_active') bool? isActive});
}

/// @nodoc
class _$UpdateStaffRequestCopyWithImpl<$Res, $Val extends UpdateStaffRequest>
    implements $UpdateStaffRequestCopyWith<$Res> {
  _$UpdateStaffRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateStaffRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? designation = freezed, Object? isActive = freezed}) {
    return _then(
      _value.copyWith(
            designation: freezed == designation
                ? _value.designation
                : designation // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: freezed == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateStaffRequestImplCopyWith<$Res>
    implements $UpdateStaffRequestCopyWith<$Res> {
  factory _$$UpdateStaffRequestImplCopyWith(
    _$UpdateStaffRequestImpl value,
    $Res Function(_$UpdateStaffRequestImpl) then,
  ) = __$$UpdateStaffRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? designation, @JsonKey(name: 'is_active') bool? isActive});
}

/// @nodoc
class __$$UpdateStaffRequestImplCopyWithImpl<$Res>
    extends _$UpdateStaffRequestCopyWithImpl<$Res, _$UpdateStaffRequestImpl>
    implements _$$UpdateStaffRequestImplCopyWith<$Res> {
  __$$UpdateStaffRequestImplCopyWithImpl(
    _$UpdateStaffRequestImpl _value,
    $Res Function(_$UpdateStaffRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateStaffRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? designation = freezed, Object? isActive = freezed}) {
    return _then(
      _$UpdateStaffRequestImpl(
        designation: freezed == designation
            ? _value.designation
            : designation // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: freezed == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateStaffRequestImpl implements _UpdateStaffRequest {
  const _$UpdateStaffRequestImpl({
    this.designation,
    @JsonKey(name: 'is_active') this.isActive,
  });

  factory _$UpdateStaffRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateStaffRequestImplFromJson(json);

  @override
  final String? designation;
  @override
  @JsonKey(name: 'is_active')
  final bool? isActive;

  @override
  String toString() {
    return 'UpdateStaffRequest(designation: $designation, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateStaffRequestImpl &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, designation, isActive);

  /// Create a copy of UpdateStaffRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateStaffRequestImplCopyWith<_$UpdateStaffRequestImpl> get copyWith =>
      __$$UpdateStaffRequestImplCopyWithImpl<_$UpdateStaffRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateStaffRequestImplToJson(this);
  }
}

abstract class _UpdateStaffRequest implements UpdateStaffRequest {
  const factory _UpdateStaffRequest({
    final String? designation,
    @JsonKey(name: 'is_active') final bool? isActive,
  }) = _$UpdateStaffRequestImpl;

  factory _UpdateStaffRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateStaffRequestImpl.fromJson;

  @override
  String? get designation;
  @override
  @JsonKey(name: 'is_active')
  bool? get isActive;

  /// Create a copy of UpdateStaffRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateStaffRequestImplCopyWith<_$UpdateStaffRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
