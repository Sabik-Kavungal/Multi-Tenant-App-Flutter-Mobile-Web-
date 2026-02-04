// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return _Category.fromJson(json);
}

/// @nodoc
mixin _$Category {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'tenant_id')
  String? get tenantId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool? get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Category to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryCopyWith<Category> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryCopyWith<$Res> {
  factory $CategoryCopyWith(Category value, $Res Function(Category) then) =
      _$CategoryCopyWithImpl<$Res, Category>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'tenant_id') String? tenantId,
    String? name,
    @JsonKey(name: 'is_active') bool? isActive,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class _$CategoryCopyWithImpl<$Res, $Val extends Category>
    implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? name = freezed,
    Object? isActive = freezed,
    Object? createdAt = freezed,
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
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: freezed == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategoryImplCopyWith<$Res>
    implements $CategoryCopyWith<$Res> {
  factory _$$CategoryImplCopyWith(
    _$CategoryImpl value,
    $Res Function(_$CategoryImpl) then,
  ) = __$$CategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'tenant_id') String? tenantId,
    String? name,
    @JsonKey(name: 'is_active') bool? isActive,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class __$$CategoryImplCopyWithImpl<$Res>
    extends _$CategoryCopyWithImpl<$Res, _$CategoryImpl>
    implements _$$CategoryImplCopyWith<$Res> {
  __$$CategoryImplCopyWithImpl(
    _$CategoryImpl _value,
    $Res Function(_$CategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? name = freezed,
    Object? isActive = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$CategoryImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        tenantId: freezed == tenantId
            ? _value.tenantId
            : tenantId // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: freezed == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryImpl implements _Category {
  const _$CategoryImpl({
    this.id,
    @JsonKey(name: 'tenant_id') this.tenantId,
    this.name,
    @JsonKey(name: 'is_active') this.isActive,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$CategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'tenant_id')
  final String? tenantId;
  @override
  final String? name;
  @override
  @JsonKey(name: 'is_active')
  final bool? isActive;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString() {
    return 'Category(id: $id, tenantId: $tenantId, name: $name, isActive: $isActive, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, tenantId, name, isActive, createdAt);

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      __$$CategoryImplCopyWithImpl<_$CategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryImplToJson(this);
  }
}

abstract class _Category implements Category {
  const factory _Category({
    final String? id,
    @JsonKey(name: 'tenant_id') final String? tenantId,
    final String? name,
    @JsonKey(name: 'is_active') final bool? isActive,
    @JsonKey(name: 'created_at') final String? createdAt,
  }) = _$CategoryImpl;

  factory _Category.fromJson(Map<String, dynamic> json) =
      _$CategoryImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'tenant_id')
  String? get tenantId;
  @override
  String? get name;
  @override
  @JsonKey(name: 'is_active')
  bool? get isActive;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateCategoryRequest _$CreateCategoryRequestFromJson(
  Map<String, dynamic> json,
) {
  return _CreateCategoryRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateCategoryRequest {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool? get isActive => throw _privateConstructorUsedError;

  /// Serializes this CreateCategoryRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateCategoryRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateCategoryRequestCopyWith<CreateCategoryRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateCategoryRequestCopyWith<$Res> {
  factory $CreateCategoryRequestCopyWith(
    CreateCategoryRequest value,
    $Res Function(CreateCategoryRequest) then,
  ) = _$CreateCategoryRequestCopyWithImpl<$Res, CreateCategoryRequest>;
  @useResult
  $Res call({String name, @JsonKey(name: 'is_active') bool? isActive});
}

/// @nodoc
class _$CreateCategoryRequestCopyWithImpl<
  $Res,
  $Val extends CreateCategoryRequest
>
    implements $CreateCategoryRequestCopyWith<$Res> {
  _$CreateCategoryRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateCategoryRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? isActive = freezed}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$CreateCategoryRequestImplCopyWith<$Res>
    implements $CreateCategoryRequestCopyWith<$Res> {
  factory _$$CreateCategoryRequestImplCopyWith(
    _$CreateCategoryRequestImpl value,
    $Res Function(_$CreateCategoryRequestImpl) then,
  ) = __$$CreateCategoryRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, @JsonKey(name: 'is_active') bool? isActive});
}

/// @nodoc
class __$$CreateCategoryRequestImplCopyWithImpl<$Res>
    extends
        _$CreateCategoryRequestCopyWithImpl<$Res, _$CreateCategoryRequestImpl>
    implements _$$CreateCategoryRequestImplCopyWith<$Res> {
  __$$CreateCategoryRequestImplCopyWithImpl(
    _$CreateCategoryRequestImpl _value,
    $Res Function(_$CreateCategoryRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateCategoryRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? isActive = freezed}) {
    return _then(
      _$CreateCategoryRequestImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$CreateCategoryRequestImpl implements _CreateCategoryRequest {
  const _$CreateCategoryRequestImpl({
    required this.name,
    @JsonKey(name: 'is_active') this.isActive,
  });

  factory _$CreateCategoryRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateCategoryRequestImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'is_active')
  final bool? isActive;

  @override
  String toString() {
    return 'CreateCategoryRequest(name: $name, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateCategoryRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, isActive);

  /// Create a copy of CreateCategoryRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateCategoryRequestImplCopyWith<_$CreateCategoryRequestImpl>
  get copyWith =>
      __$$CreateCategoryRequestImplCopyWithImpl<_$CreateCategoryRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateCategoryRequestImplToJson(this);
  }
}

abstract class _CreateCategoryRequest implements CreateCategoryRequest {
  const factory _CreateCategoryRequest({
    required final String name,
    @JsonKey(name: 'is_active') final bool? isActive,
  }) = _$CreateCategoryRequestImpl;

  factory _CreateCategoryRequest.fromJson(Map<String, dynamic> json) =
      _$CreateCategoryRequestImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'is_active')
  bool? get isActive;

  /// Create a copy of CreateCategoryRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateCategoryRequestImplCopyWith<_$CreateCategoryRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UpdateCategoryRequest _$UpdateCategoryRequestFromJson(
  Map<String, dynamic> json,
) {
  return _UpdateCategoryRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateCategoryRequest {
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool? get isActive => throw _privateConstructorUsedError;

  /// Serializes this UpdateCategoryRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateCategoryRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateCategoryRequestCopyWith<UpdateCategoryRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateCategoryRequestCopyWith<$Res> {
  factory $UpdateCategoryRequestCopyWith(
    UpdateCategoryRequest value,
    $Res Function(UpdateCategoryRequest) then,
  ) = _$UpdateCategoryRequestCopyWithImpl<$Res, UpdateCategoryRequest>;
  @useResult
  $Res call({String? name, @JsonKey(name: 'is_active') bool? isActive});
}

/// @nodoc
class _$UpdateCategoryRequestCopyWithImpl<
  $Res,
  $Val extends UpdateCategoryRequest
>
    implements $UpdateCategoryRequestCopyWith<$Res> {
  _$UpdateCategoryRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateCategoryRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = freezed, Object? isActive = freezed}) {
    return _then(
      _value.copyWith(
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
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
abstract class _$$UpdateCategoryRequestImplCopyWith<$Res>
    implements $UpdateCategoryRequestCopyWith<$Res> {
  factory _$$UpdateCategoryRequestImplCopyWith(
    _$UpdateCategoryRequestImpl value,
    $Res Function(_$UpdateCategoryRequestImpl) then,
  ) = __$$UpdateCategoryRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, @JsonKey(name: 'is_active') bool? isActive});
}

/// @nodoc
class __$$UpdateCategoryRequestImplCopyWithImpl<$Res>
    extends
        _$UpdateCategoryRequestCopyWithImpl<$Res, _$UpdateCategoryRequestImpl>
    implements _$$UpdateCategoryRequestImplCopyWith<$Res> {
  __$$UpdateCategoryRequestImplCopyWithImpl(
    _$UpdateCategoryRequestImpl _value,
    $Res Function(_$UpdateCategoryRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateCategoryRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = freezed, Object? isActive = freezed}) {
    return _then(
      _$UpdateCategoryRequestImpl(
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
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
class _$UpdateCategoryRequestImpl implements _UpdateCategoryRequest {
  const _$UpdateCategoryRequestImpl({
    this.name,
    @JsonKey(name: 'is_active') this.isActive,
  });

  factory _$UpdateCategoryRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateCategoryRequestImplFromJson(json);

  @override
  final String? name;
  @override
  @JsonKey(name: 'is_active')
  final bool? isActive;

  @override
  String toString() {
    return 'UpdateCategoryRequest(name: $name, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateCategoryRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, isActive);

  /// Create a copy of UpdateCategoryRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateCategoryRequestImplCopyWith<_$UpdateCategoryRequestImpl>
  get copyWith =>
      __$$UpdateCategoryRequestImplCopyWithImpl<_$UpdateCategoryRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateCategoryRequestImplToJson(this);
  }
}

abstract class _UpdateCategoryRequest implements UpdateCategoryRequest {
  const factory _UpdateCategoryRequest({
    final String? name,
    @JsonKey(name: 'is_active') final bool? isActive,
  }) = _$UpdateCategoryRequestImpl;

  factory _UpdateCategoryRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateCategoryRequestImpl.fromJson;

  @override
  String? get name;
  @override
  @JsonKey(name: 'is_active')
  bool? get isActive;

  /// Create a copy of UpdateCategoryRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateCategoryRequestImplCopyWith<_$UpdateCategoryRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
