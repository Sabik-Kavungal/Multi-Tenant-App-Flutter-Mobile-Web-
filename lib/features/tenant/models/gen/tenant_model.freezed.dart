// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../tenant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Tenant _$TenantFromJson(Map<String, dynamic> json) {
  return _Tenant.fromJson(json);
}

/// @nodoc
mixin _$Tenant {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'owner_user_id')
  String? get ownerUserId => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get timezone => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Tenant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TenantCopyWith<Tenant> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TenantCopyWith<$Res> {
  factory $TenantCopyWith(Tenant value, $Res Function(Tenant) then) =
      _$TenantCopyWithImpl<$Res, Tenant>;
  @useResult
  $Res call({
    String? id,
    String? name,
    String? type,
    @JsonKey(name: 'owner_user_id') String? ownerUserId,
    String? status,
    String? timezone,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

/// @nodoc
class _$TenantCopyWithImpl<$Res, $Val extends Tenant>
    implements $TenantCopyWith<$Res> {
  _$TenantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? type = freezed,
    Object? ownerUserId = freezed,
    Object? status = freezed,
    Object? timezone = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String?,
            ownerUserId: freezed == ownerUserId
                ? _value.ownerUserId
                : ownerUserId // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            timezone: freezed == timezone
                ? _value.timezone
                : timezone // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TenantImplCopyWith<$Res> implements $TenantCopyWith<$Res> {
  factory _$$TenantImplCopyWith(
    _$TenantImpl value,
    $Res Function(_$TenantImpl) then,
  ) = __$$TenantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? name,
    String? type,
    @JsonKey(name: 'owner_user_id') String? ownerUserId,
    String? status,
    String? timezone,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

/// @nodoc
class __$$TenantImplCopyWithImpl<$Res>
    extends _$TenantCopyWithImpl<$Res, _$TenantImpl>
    implements _$$TenantImplCopyWith<$Res> {
  __$$TenantImplCopyWithImpl(
    _$TenantImpl _value,
    $Res Function(_$TenantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? type = freezed,
    Object? ownerUserId = freezed,
    Object? status = freezed,
    Object? timezone = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$TenantImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
        ownerUserId: freezed == ownerUserId
            ? _value.ownerUserId
            : ownerUserId // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        timezone: freezed == timezone
            ? _value.timezone
            : timezone // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TenantImpl implements _Tenant {
  const _$TenantImpl({
    this.id,
    this.name,
    this.type,
    @JsonKey(name: 'owner_user_id') this.ownerUserId,
    this.status,
    this.timezone,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  });

  factory _$TenantImpl.fromJson(Map<String, dynamic> json) =>
      _$$TenantImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? type;
  @override
  @JsonKey(name: 'owner_user_id')
  final String? ownerUserId;
  @override
  final String? status;
  @override
  final String? timezone;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'Tenant(id: $id, name: $name, type: $type, ownerUserId: $ownerUserId, status: $status, timezone: $timezone, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TenantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.ownerUserId, ownerUserId) ||
                other.ownerUserId == ownerUserId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    type,
    ownerUserId,
    status,
    timezone,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TenantImplCopyWith<_$TenantImpl> get copyWith =>
      __$$TenantImplCopyWithImpl<_$TenantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TenantImplToJson(this);
  }
}

abstract class _Tenant implements Tenant {
  const factory _Tenant({
    final String? id,
    final String? name,
    final String? type,
    @JsonKey(name: 'owner_user_id') final String? ownerUserId,
    final String? status,
    final String? timezone,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'updated_at') final String? updatedAt,
  }) = _$TenantImpl;

  factory _Tenant.fromJson(Map<String, dynamic> json) = _$TenantImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get type;
  @override
  @JsonKey(name: 'owner_user_id')
  String? get ownerUserId;
  @override
  String? get status;
  @override
  String? get timezone;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TenantImplCopyWith<_$TenantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateTenantRequest _$CreateTenantRequestFromJson(Map<String, dynamic> json) {
  return _CreateTenantRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateTenantRequest {
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'owner_user_id')
  String get ownerUserId => throw _privateConstructorUsedError;
  String get timezone => throw _privateConstructorUsedError;

  /// Serializes this CreateTenantRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateTenantRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateTenantRequestCopyWith<CreateTenantRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateTenantRequestCopyWith<$Res> {
  factory $CreateTenantRequestCopyWith(
    CreateTenantRequest value,
    $Res Function(CreateTenantRequest) then,
  ) = _$CreateTenantRequestCopyWithImpl<$Res, CreateTenantRequest>;
  @useResult
  $Res call({
    String name,
    String type,
    @JsonKey(name: 'owner_user_id') String ownerUserId,
    String timezone,
  });
}

/// @nodoc
class _$CreateTenantRequestCopyWithImpl<$Res, $Val extends CreateTenantRequest>
    implements $CreateTenantRequestCopyWith<$Res> {
  _$CreateTenantRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateTenantRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? ownerUserId = null,
    Object? timezone = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            ownerUserId: null == ownerUserId
                ? _value.ownerUserId
                : ownerUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            timezone: null == timezone
                ? _value.timezone
                : timezone // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateTenantRequestImplCopyWith<$Res>
    implements $CreateTenantRequestCopyWith<$Res> {
  factory _$$CreateTenantRequestImplCopyWith(
    _$CreateTenantRequestImpl value,
    $Res Function(_$CreateTenantRequestImpl) then,
  ) = __$$CreateTenantRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String type,
    @JsonKey(name: 'owner_user_id') String ownerUserId,
    String timezone,
  });
}

/// @nodoc
class __$$CreateTenantRequestImplCopyWithImpl<$Res>
    extends _$CreateTenantRequestCopyWithImpl<$Res, _$CreateTenantRequestImpl>
    implements _$$CreateTenantRequestImplCopyWith<$Res> {
  __$$CreateTenantRequestImplCopyWithImpl(
    _$CreateTenantRequestImpl _value,
    $Res Function(_$CreateTenantRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateTenantRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? ownerUserId = null,
    Object? timezone = null,
  }) {
    return _then(
      _$CreateTenantRequestImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        ownerUserId: null == ownerUserId
            ? _value.ownerUserId
            : ownerUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        timezone: null == timezone
            ? _value.timezone
            : timezone // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateTenantRequestImpl implements _CreateTenantRequest {
  const _$CreateTenantRequestImpl({
    required this.name,
    required this.type,
    @JsonKey(name: 'owner_user_id') required this.ownerUserId,
    required this.timezone,
  });

  factory _$CreateTenantRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateTenantRequestImplFromJson(json);

  @override
  final String name;
  @override
  final String type;
  @override
  @JsonKey(name: 'owner_user_id')
  final String ownerUserId;
  @override
  final String timezone;

  @override
  String toString() {
    return 'CreateTenantRequest(name: $name, type: $type, ownerUserId: $ownerUserId, timezone: $timezone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTenantRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.ownerUserId, ownerUserId) ||
                other.ownerUserId == ownerUserId) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, type, ownerUserId, timezone);

  /// Create a copy of CreateTenantRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTenantRequestImplCopyWith<_$CreateTenantRequestImpl> get copyWith =>
      __$$CreateTenantRequestImplCopyWithImpl<_$CreateTenantRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateTenantRequestImplToJson(this);
  }
}

abstract class _CreateTenantRequest implements CreateTenantRequest {
  const factory _CreateTenantRequest({
    required final String name,
    required final String type,
    @JsonKey(name: 'owner_user_id') required final String ownerUserId,
    required final String timezone,
  }) = _$CreateTenantRequestImpl;

  factory _CreateTenantRequest.fromJson(Map<String, dynamic> json) =
      _$CreateTenantRequestImpl.fromJson;

  @override
  String get name;
  @override
  String get type;
  @override
  @JsonKey(name: 'owner_user_id')
  String get ownerUserId;
  @override
  String get timezone;

  /// Create a copy of CreateTenantRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateTenantRequestImplCopyWith<_$CreateTenantRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateTenantRequest _$UpdateTenantRequestFromJson(Map<String, dynamic> json) {
  return _UpdateTenantRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateTenantRequest {
  String? get name => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get timezone => throw _privateConstructorUsedError;

  /// Serializes this UpdateTenantRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateTenantRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateTenantRequestCopyWith<UpdateTenantRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateTenantRequestCopyWith<$Res> {
  factory $UpdateTenantRequestCopyWith(
    UpdateTenantRequest value,
    $Res Function(UpdateTenantRequest) then,
  ) = _$UpdateTenantRequestCopyWithImpl<$Res, UpdateTenantRequest>;
  @useResult
  $Res call({String? name, String? type, String? status, String? timezone});
}

/// @nodoc
class _$UpdateTenantRequestCopyWithImpl<$Res, $Val extends UpdateTenantRequest>
    implements $UpdateTenantRequestCopyWith<$Res> {
  _$UpdateTenantRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateTenantRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? type = freezed,
    Object? status = freezed,
    Object? timezone = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            timezone: freezed == timezone
                ? _value.timezone
                : timezone // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateTenantRequestImplCopyWith<$Res>
    implements $UpdateTenantRequestCopyWith<$Res> {
  factory _$$UpdateTenantRequestImplCopyWith(
    _$UpdateTenantRequestImpl value,
    $Res Function(_$UpdateTenantRequestImpl) then,
  ) = __$$UpdateTenantRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? type, String? status, String? timezone});
}

/// @nodoc
class __$$UpdateTenantRequestImplCopyWithImpl<$Res>
    extends _$UpdateTenantRequestCopyWithImpl<$Res, _$UpdateTenantRequestImpl>
    implements _$$UpdateTenantRequestImplCopyWith<$Res> {
  __$$UpdateTenantRequestImplCopyWithImpl(
    _$UpdateTenantRequestImpl _value,
    $Res Function(_$UpdateTenantRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateTenantRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? type = freezed,
    Object? status = freezed,
    Object? timezone = freezed,
  }) {
    return _then(
      _$UpdateTenantRequestImpl(
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        timezone: freezed == timezone
            ? _value.timezone
            : timezone // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateTenantRequestImpl implements _UpdateTenantRequest {
  const _$UpdateTenantRequestImpl({
    this.name,
    this.type,
    this.status,
    this.timezone,
  });

  factory _$UpdateTenantRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateTenantRequestImplFromJson(json);

  @override
  final String? name;
  @override
  final String? type;
  @override
  final String? status;
  @override
  final String? timezone;

  @override
  String toString() {
    return 'UpdateTenantRequest(name: $name, type: $type, status: $status, timezone: $timezone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateTenantRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, type, status, timezone);

  /// Create a copy of UpdateTenantRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateTenantRequestImplCopyWith<_$UpdateTenantRequestImpl> get copyWith =>
      __$$UpdateTenantRequestImplCopyWithImpl<_$UpdateTenantRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateTenantRequestImplToJson(this);
  }
}

abstract class _UpdateTenantRequest implements UpdateTenantRequest {
  const factory _UpdateTenantRequest({
    final String? name,
    final String? type,
    final String? status,
    final String? timezone,
  }) = _$UpdateTenantRequestImpl;

  factory _UpdateTenantRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateTenantRequestImpl.fromJson;

  @override
  String? get name;
  @override
  String? get type;
  @override
  String? get status;
  @override
  String? get timezone;

  /// Create a copy of UpdateTenantRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateTenantRequestImplCopyWith<_$UpdateTenantRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
