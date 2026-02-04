// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../tenant_api_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreatedUser _$CreatedUserFromJson(Map<String, dynamic> json) {
  return _CreatedUser.fromJson(json);
}

/// @nodoc
mixin _$CreatedUser {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'tenant_id')
  String get tenantId => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String get lastName => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this CreatedUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreatedUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatedUserCopyWith<CreatedUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatedUserCopyWith<$Res> {
  factory $CreatedUserCopyWith(
    CreatedUser value,
    $Res Function(CreatedUser) then,
  ) = _$CreatedUserCopyWithImpl<$Res, CreatedUser>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'tenant_id') String tenantId,
    String email,
    @JsonKey(name: 'first_name') String firstName,
    @JsonKey(name: 'last_name') String lastName,
    String role,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$CreatedUserCopyWithImpl<$Res, $Val extends CreatedUser>
    implements $CreatedUserCopyWith<$Res> {
  _$CreatedUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatedUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tenantId = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? role = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            tenantId: null == tenantId
                ? _value.tenantId
                : tenantId // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreatedUserImplCopyWith<$Res>
    implements $CreatedUserCopyWith<$Res> {
  factory _$$CreatedUserImplCopyWith(
    _$CreatedUserImpl value,
    $Res Function(_$CreatedUserImpl) then,
  ) = __$$CreatedUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'tenant_id') String tenantId,
    String email,
    @JsonKey(name: 'first_name') String firstName,
    @JsonKey(name: 'last_name') String lastName,
    String role,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$CreatedUserImplCopyWithImpl<$Res>
    extends _$CreatedUserCopyWithImpl<$Res, _$CreatedUserImpl>
    implements _$$CreatedUserImplCopyWith<$Res> {
  __$$CreatedUserImplCopyWithImpl(
    _$CreatedUserImpl _value,
    $Res Function(_$CreatedUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreatedUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tenantId = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? role = null,
    Object? isActive = null,
  }) {
    return _then(
      _$CreatedUserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        tenantId: null == tenantId
            ? _value.tenantId
            : tenantId // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatedUserImpl implements _CreatedUser {
  const _$CreatedUserImpl({
    required this.id,
    @JsonKey(name: 'tenant_id') required this.tenantId,
    required this.email,
    @JsonKey(name: 'first_name') required this.firstName,
    @JsonKey(name: 'last_name') required this.lastName,
    required this.role,
    @JsonKey(name: 'is_active') this.isActive = true,
  });

  factory _$CreatedUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatedUserImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'tenant_id')
  final String tenantId;
  @override
  final String email;
  @override
  @JsonKey(name: 'first_name')
  final String firstName;
  @override
  @JsonKey(name: 'last_name')
  final String lastName;
  @override
  final String role;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'CreatedUser(id: $id, tenantId: $tenantId, email: $email, firstName: $firstName, lastName: $lastName, role: $role, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatedUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    tenantId,
    email,
    firstName,
    lastName,
    role,
    isActive,
  );

  /// Create a copy of CreatedUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatedUserImplCopyWith<_$CreatedUserImpl> get copyWith =>
      __$$CreatedUserImplCopyWithImpl<_$CreatedUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatedUserImplToJson(this);
  }
}

abstract class _CreatedUser implements CreatedUser {
  const factory _CreatedUser({
    required final String id,
    @JsonKey(name: 'tenant_id') required final String tenantId,
    required final String email,
    @JsonKey(name: 'first_name') required final String firstName,
    @JsonKey(name: 'last_name') required final String lastName,
    required final String role,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$CreatedUserImpl;

  factory _CreatedUser.fromJson(Map<String, dynamic> json) =
      _$CreatedUserImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'tenant_id')
  String get tenantId;
  @override
  String get email;
  @override
  @JsonKey(name: 'first_name')
  String get firstName;
  @override
  @JsonKey(name: 'last_name')
  String get lastName;
  @override
  String get role;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of CreatedUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatedUserImplCopyWith<_$CreatedUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserListResponse _$UserListResponseFromJson(Map<String, dynamic> json) {
  return _UserListResponse.fromJson(json);
}

/// @nodoc
mixin _$UserListResponse {
  List<CreatedUser> get users => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  /// Serializes this UserListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserListResponseCopyWith<UserListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserListResponseCopyWith<$Res> {
  factory $UserListResponseCopyWith(
    UserListResponse value,
    $Res Function(UserListResponse) then,
  ) = _$UserListResponseCopyWithImpl<$Res, UserListResponse>;
  @useResult
  $Res call({List<CreatedUser> users, int total});
}

/// @nodoc
class _$UserListResponseCopyWithImpl<$Res, $Val extends UserListResponse>
    implements $UserListResponseCopyWith<$Res> {
  _$UserListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? users = null, Object? total = null}) {
    return _then(
      _value.copyWith(
            users: null == users
                ? _value.users
                : users // ignore: cast_nullable_to_non_nullable
                      as List<CreatedUser>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserListResponseImplCopyWith<$Res>
    implements $UserListResponseCopyWith<$Res> {
  factory _$$UserListResponseImplCopyWith(
    _$UserListResponseImpl value,
    $Res Function(_$UserListResponseImpl) then,
  ) = __$$UserListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CreatedUser> users, int total});
}

/// @nodoc
class __$$UserListResponseImplCopyWithImpl<$Res>
    extends _$UserListResponseCopyWithImpl<$Res, _$UserListResponseImpl>
    implements _$$UserListResponseImplCopyWith<$Res> {
  __$$UserListResponseImplCopyWithImpl(
    _$UserListResponseImpl _value,
    $Res Function(_$UserListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? users = null, Object? total = null}) {
    return _then(
      _$UserListResponseImpl(
        users: null == users
            ? _value._users
            : users // ignore: cast_nullable_to_non_nullable
                  as List<CreatedUser>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserListResponseImpl implements _UserListResponse {
  const _$UserListResponseImpl({
    required final List<CreatedUser> users,
    required this.total,
  }) : _users = users;

  factory _$UserListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserListResponseImplFromJson(json);

  final List<CreatedUser> _users;
  @override
  List<CreatedUser> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  final int total;

  @override
  String toString() {
    return 'UserListResponse(users: $users, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserListResponseImpl &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_users),
    total,
  );

  /// Create a copy of UserListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserListResponseImplCopyWith<_$UserListResponseImpl> get copyWith =>
      __$$UserListResponseImplCopyWithImpl<_$UserListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserListResponseImplToJson(this);
  }
}

abstract class _UserListResponse implements UserListResponse {
  const factory _UserListResponse({
    required final List<CreatedUser> users,
    required final int total,
  }) = _$UserListResponseImpl;

  factory _UserListResponse.fromJson(Map<String, dynamic> json) =
      _$UserListResponseImpl.fromJson;

  @override
  List<CreatedUser> get users;
  @override
  int get total;

  /// Create a copy of UserListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserListResponseImplCopyWith<_$UserListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
