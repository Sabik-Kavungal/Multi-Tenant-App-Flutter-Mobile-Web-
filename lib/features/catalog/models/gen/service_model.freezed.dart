// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../service_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return _Service.fromJson(json);
}

/// @nodoc
mixin _$Service {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'tenant_id')
  String? get tenantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String? get categoryId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_type')
  String? get bookingType => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_minutes')
  int? get durationMinutes => throw _privateConstructorUsedError;
  int? get capacity => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool? get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Service to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Service
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceCopyWith<Service> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceCopyWith<$Res> {
  factory $ServiceCopyWith(Service value, $Res Function(Service) then) =
      _$ServiceCopyWithImpl<$Res, Service>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'category_id') String? categoryId,
    String? name,
    String? description,
    @JsonKey(name: 'booking_type') String? bookingType,
    @JsonKey(name: 'duration_minutes') int? durationMinutes,
    int? capacity,
    double? price,
    @JsonKey(name: 'is_active') bool? isActive,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class _$ServiceCopyWithImpl<$Res, $Val extends Service>
    implements $ServiceCopyWith<$Res> {
  _$ServiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Service
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? categoryId = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? bookingType = freezed,
    Object? durationMinutes = freezed,
    Object? capacity = freezed,
    Object? price = freezed,
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
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            bookingType: freezed == bookingType
                ? _value.bookingType
                : bookingType // ignore: cast_nullable_to_non_nullable
                      as String?,
            durationMinutes: freezed == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            capacity: freezed == capacity
                ? _value.capacity
                : capacity // ignore: cast_nullable_to_non_nullable
                      as int?,
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double?,
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
abstract class _$$ServiceImplCopyWith<$Res> implements $ServiceCopyWith<$Res> {
  factory _$$ServiceImplCopyWith(
    _$ServiceImpl value,
    $Res Function(_$ServiceImpl) then,
  ) = __$$ServiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'category_id') String? categoryId,
    String? name,
    String? description,
    @JsonKey(name: 'booking_type') String? bookingType,
    @JsonKey(name: 'duration_minutes') int? durationMinutes,
    int? capacity,
    double? price,
    @JsonKey(name: 'is_active') bool? isActive,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class __$$ServiceImplCopyWithImpl<$Res>
    extends _$ServiceCopyWithImpl<$Res, _$ServiceImpl>
    implements _$$ServiceImplCopyWith<$Res> {
  __$$ServiceImplCopyWithImpl(
    _$ServiceImpl _value,
    $Res Function(_$ServiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Service
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? categoryId = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? bookingType = freezed,
    Object? durationMinutes = freezed,
    Object? capacity = freezed,
    Object? price = freezed,
    Object? isActive = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$ServiceImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        tenantId: freezed == tenantId
            ? _value.tenantId
            : tenantId // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        bookingType: freezed == bookingType
            ? _value.bookingType
            : bookingType // ignore: cast_nullable_to_non_nullable
                  as String?,
        durationMinutes: freezed == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        capacity: freezed == capacity
            ? _value.capacity
            : capacity // ignore: cast_nullable_to_non_nullable
                  as int?,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double?,
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
class _$ServiceImpl implements _Service {
  const _$ServiceImpl({
    this.id,
    @JsonKey(name: 'tenant_id') this.tenantId,
    @JsonKey(name: 'category_id') this.categoryId,
    this.name,
    this.description,
    @JsonKey(name: 'booking_type') this.bookingType,
    @JsonKey(name: 'duration_minutes') this.durationMinutes,
    this.capacity,
    this.price,
    @JsonKey(name: 'is_active') this.isActive,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$ServiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'tenant_id')
  final String? tenantId;
  @override
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @override
  final String? name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'booking_type')
  final String? bookingType;
  @override
  @JsonKey(name: 'duration_minutes')
  final int? durationMinutes;
  @override
  final int? capacity;
  @override
  final double? price;
  @override
  @JsonKey(name: 'is_active')
  final bool? isActive;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString() {
    return 'Service(id: $id, tenantId: $tenantId, categoryId: $categoryId, name: $name, description: $description, bookingType: $bookingType, durationMinutes: $durationMinutes, capacity: $capacity, price: $price, isActive: $isActive, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.bookingType, bookingType) ||
                other.bookingType == bookingType) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    tenantId,
    categoryId,
    name,
    description,
    bookingType,
    durationMinutes,
    capacity,
    price,
    isActive,
    createdAt,
  );

  /// Create a copy of Service
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceImplCopyWith<_$ServiceImpl> get copyWith =>
      __$$ServiceImplCopyWithImpl<_$ServiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceImplToJson(this);
  }
}

abstract class _Service implements Service {
  const factory _Service({
    final String? id,
    @JsonKey(name: 'tenant_id') final String? tenantId,
    @JsonKey(name: 'category_id') final String? categoryId,
    final String? name,
    final String? description,
    @JsonKey(name: 'booking_type') final String? bookingType,
    @JsonKey(name: 'duration_minutes') final int? durationMinutes,
    final int? capacity,
    final double? price,
    @JsonKey(name: 'is_active') final bool? isActive,
    @JsonKey(name: 'created_at') final String? createdAt,
  }) = _$ServiceImpl;

  factory _Service.fromJson(Map<String, dynamic> json) = _$ServiceImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'tenant_id')
  String? get tenantId;
  @override
  @JsonKey(name: 'category_id')
  String? get categoryId;
  @override
  String? get name;
  @override
  String? get description;
  @override
  @JsonKey(name: 'booking_type')
  String? get bookingType;
  @override
  @JsonKey(name: 'duration_minutes')
  int? get durationMinutes;
  @override
  int? get capacity;
  @override
  double? get price;
  @override
  @JsonKey(name: 'is_active')
  bool? get isActive;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;

  /// Create a copy of Service
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceImplCopyWith<_$ServiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateServiceRequest _$CreateServiceRequestFromJson(Map<String, dynamic> json) {
  return _CreateServiceRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateServiceRequest {
  @JsonKey(name: 'category_id')
  String get categoryId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_type')
  String get bookingType => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_minutes')
  int? get durationMinutes => throw _privateConstructorUsedError;
  int? get capacity => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool? get isActive => throw _privateConstructorUsedError;

  /// Serializes this CreateServiceRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateServiceRequestCopyWith<CreateServiceRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateServiceRequestCopyWith<$Res> {
  factory $CreateServiceRequestCopyWith(
    CreateServiceRequest value,
    $Res Function(CreateServiceRequest) then,
  ) = _$CreateServiceRequestCopyWithImpl<$Res, CreateServiceRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'category_id') String categoryId,
    String name,
    String? description,
    @JsonKey(name: 'booking_type') String bookingType,
    @JsonKey(name: 'duration_minutes') int? durationMinutes,
    int? capacity,
    double price,
    @JsonKey(name: 'is_active') bool? isActive,
  });
}

/// @nodoc
class _$CreateServiceRequestCopyWithImpl<
  $Res,
  $Val extends CreateServiceRequest
>
    implements $CreateServiceRequestCopyWith<$Res> {
  _$CreateServiceRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? name = null,
    Object? description = freezed,
    Object? bookingType = null,
    Object? durationMinutes = freezed,
    Object? capacity = freezed,
    Object? price = null,
    Object? isActive = freezed,
  }) {
    return _then(
      _value.copyWith(
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            bookingType: null == bookingType
                ? _value.bookingType
                : bookingType // ignore: cast_nullable_to_non_nullable
                      as String,
            durationMinutes: freezed == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            capacity: freezed == capacity
                ? _value.capacity
                : capacity // ignore: cast_nullable_to_non_nullable
                      as int?,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
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
abstract class _$$CreateServiceRequestImplCopyWith<$Res>
    implements $CreateServiceRequestCopyWith<$Res> {
  factory _$$CreateServiceRequestImplCopyWith(
    _$CreateServiceRequestImpl value,
    $Res Function(_$CreateServiceRequestImpl) then,
  ) = __$$CreateServiceRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'category_id') String categoryId,
    String name,
    String? description,
    @JsonKey(name: 'booking_type') String bookingType,
    @JsonKey(name: 'duration_minutes') int? durationMinutes,
    int? capacity,
    double price,
    @JsonKey(name: 'is_active') bool? isActive,
  });
}

/// @nodoc
class __$$CreateServiceRequestImplCopyWithImpl<$Res>
    extends _$CreateServiceRequestCopyWithImpl<$Res, _$CreateServiceRequestImpl>
    implements _$$CreateServiceRequestImplCopyWith<$Res> {
  __$$CreateServiceRequestImplCopyWithImpl(
    _$CreateServiceRequestImpl _value,
    $Res Function(_$CreateServiceRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? name = null,
    Object? description = freezed,
    Object? bookingType = null,
    Object? durationMinutes = freezed,
    Object? capacity = freezed,
    Object? price = null,
    Object? isActive = freezed,
  }) {
    return _then(
      _$CreateServiceRequestImpl(
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        bookingType: null == bookingType
            ? _value.bookingType
            : bookingType // ignore: cast_nullable_to_non_nullable
                  as String,
        durationMinutes: freezed == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        capacity: freezed == capacity
            ? _value.capacity
            : capacity // ignore: cast_nullable_to_non_nullable
                  as int?,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
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
class _$CreateServiceRequestImpl implements _CreateServiceRequest {
  const _$CreateServiceRequestImpl({
    @JsonKey(name: 'category_id') required this.categoryId,
    required this.name,
    this.description,
    @JsonKey(name: 'booking_type') required this.bookingType,
    @JsonKey(name: 'duration_minutes') this.durationMinutes,
    this.capacity,
    required this.price,
    @JsonKey(name: 'is_active') this.isActive,
  });

  factory _$CreateServiceRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateServiceRequestImplFromJson(json);

  @override
  @JsonKey(name: 'category_id')
  final String categoryId;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'booking_type')
  final String bookingType;
  @override
  @JsonKey(name: 'duration_minutes')
  final int? durationMinutes;
  @override
  final int? capacity;
  @override
  final double price;
  @override
  @JsonKey(name: 'is_active')
  final bool? isActive;

  @override
  String toString() {
    return 'CreateServiceRequest(categoryId: $categoryId, name: $name, description: $description, bookingType: $bookingType, durationMinutes: $durationMinutes, capacity: $capacity, price: $price, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateServiceRequestImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.bookingType, bookingType) ||
                other.bookingType == bookingType) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    categoryId,
    name,
    description,
    bookingType,
    durationMinutes,
    capacity,
    price,
    isActive,
  );

  /// Create a copy of CreateServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateServiceRequestImplCopyWith<_$CreateServiceRequestImpl>
  get copyWith =>
      __$$CreateServiceRequestImplCopyWithImpl<_$CreateServiceRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateServiceRequestImplToJson(this);
  }
}

abstract class _CreateServiceRequest implements CreateServiceRequest {
  const factory _CreateServiceRequest({
    @JsonKey(name: 'category_id') required final String categoryId,
    required final String name,
    final String? description,
    @JsonKey(name: 'booking_type') required final String bookingType,
    @JsonKey(name: 'duration_minutes') final int? durationMinutes,
    final int? capacity,
    required final double price,
    @JsonKey(name: 'is_active') final bool? isActive,
  }) = _$CreateServiceRequestImpl;

  factory _CreateServiceRequest.fromJson(Map<String, dynamic> json) =
      _$CreateServiceRequestImpl.fromJson;

  @override
  @JsonKey(name: 'category_id')
  String get categoryId;
  @override
  String get name;
  @override
  String? get description;
  @override
  @JsonKey(name: 'booking_type')
  String get bookingType;
  @override
  @JsonKey(name: 'duration_minutes')
  int? get durationMinutes;
  @override
  int? get capacity;
  @override
  double get price;
  @override
  @JsonKey(name: 'is_active')
  bool? get isActive;

  /// Create a copy of CreateServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateServiceRequestImplCopyWith<_$CreateServiceRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UpdateServiceRequest _$UpdateServiceRequestFromJson(Map<String, dynamic> json) {
  return _UpdateServiceRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateServiceRequest {
  @JsonKey(name: 'category_id')
  String? get categoryId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_type')
  String? get bookingType => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_minutes')
  int? get durationMinutes => throw _privateConstructorUsedError;
  int? get capacity => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool? get isActive => throw _privateConstructorUsedError;

  /// Serializes this UpdateServiceRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateServiceRequestCopyWith<UpdateServiceRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateServiceRequestCopyWith<$Res> {
  factory $UpdateServiceRequestCopyWith(
    UpdateServiceRequest value,
    $Res Function(UpdateServiceRequest) then,
  ) = _$UpdateServiceRequestCopyWithImpl<$Res, UpdateServiceRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'category_id') String? categoryId,
    String? name,
    String? description,
    @JsonKey(name: 'booking_type') String? bookingType,
    @JsonKey(name: 'duration_minutes') int? durationMinutes,
    int? capacity,
    double? price,
    @JsonKey(name: 'is_active') bool? isActive,
  });
}

/// @nodoc
class _$UpdateServiceRequestCopyWithImpl<
  $Res,
  $Val extends UpdateServiceRequest
>
    implements $UpdateServiceRequestCopyWith<$Res> {
  _$UpdateServiceRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? bookingType = freezed,
    Object? durationMinutes = freezed,
    Object? capacity = freezed,
    Object? price = freezed,
    Object? isActive = freezed,
  }) {
    return _then(
      _value.copyWith(
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            bookingType: freezed == bookingType
                ? _value.bookingType
                : bookingType // ignore: cast_nullable_to_non_nullable
                      as String?,
            durationMinutes: freezed == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            capacity: freezed == capacity
                ? _value.capacity
                : capacity // ignore: cast_nullable_to_non_nullable
                      as int?,
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double?,
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
abstract class _$$UpdateServiceRequestImplCopyWith<$Res>
    implements $UpdateServiceRequestCopyWith<$Res> {
  factory _$$UpdateServiceRequestImplCopyWith(
    _$UpdateServiceRequestImpl value,
    $Res Function(_$UpdateServiceRequestImpl) then,
  ) = __$$UpdateServiceRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'category_id') String? categoryId,
    String? name,
    String? description,
    @JsonKey(name: 'booking_type') String? bookingType,
    @JsonKey(name: 'duration_minutes') int? durationMinutes,
    int? capacity,
    double? price,
    @JsonKey(name: 'is_active') bool? isActive,
  });
}

/// @nodoc
class __$$UpdateServiceRequestImplCopyWithImpl<$Res>
    extends _$UpdateServiceRequestCopyWithImpl<$Res, _$UpdateServiceRequestImpl>
    implements _$$UpdateServiceRequestImplCopyWith<$Res> {
  __$$UpdateServiceRequestImplCopyWithImpl(
    _$UpdateServiceRequestImpl _value,
    $Res Function(_$UpdateServiceRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? bookingType = freezed,
    Object? durationMinutes = freezed,
    Object? capacity = freezed,
    Object? price = freezed,
    Object? isActive = freezed,
  }) {
    return _then(
      _$UpdateServiceRequestImpl(
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        bookingType: freezed == bookingType
            ? _value.bookingType
            : bookingType // ignore: cast_nullable_to_non_nullable
                  as String?,
        durationMinutes: freezed == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        capacity: freezed == capacity
            ? _value.capacity
            : capacity // ignore: cast_nullable_to_non_nullable
                  as int?,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double?,
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
class _$UpdateServiceRequestImpl implements _UpdateServiceRequest {
  const _$UpdateServiceRequestImpl({
    @JsonKey(name: 'category_id') this.categoryId,
    this.name,
    this.description,
    @JsonKey(name: 'booking_type') this.bookingType,
    @JsonKey(name: 'duration_minutes') this.durationMinutes,
    this.capacity,
    this.price,
    @JsonKey(name: 'is_active') this.isActive,
  });

  factory _$UpdateServiceRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateServiceRequestImplFromJson(json);

  @override
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @override
  final String? name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'booking_type')
  final String? bookingType;
  @override
  @JsonKey(name: 'duration_minutes')
  final int? durationMinutes;
  @override
  final int? capacity;
  @override
  final double? price;
  @override
  @JsonKey(name: 'is_active')
  final bool? isActive;

  @override
  String toString() {
    return 'UpdateServiceRequest(categoryId: $categoryId, name: $name, description: $description, bookingType: $bookingType, durationMinutes: $durationMinutes, capacity: $capacity, price: $price, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateServiceRequestImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.bookingType, bookingType) ||
                other.bookingType == bookingType) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    categoryId,
    name,
    description,
    bookingType,
    durationMinutes,
    capacity,
    price,
    isActive,
  );

  /// Create a copy of UpdateServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateServiceRequestImplCopyWith<_$UpdateServiceRequestImpl>
  get copyWith =>
      __$$UpdateServiceRequestImplCopyWithImpl<_$UpdateServiceRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateServiceRequestImplToJson(this);
  }
}

abstract class _UpdateServiceRequest implements UpdateServiceRequest {
  const factory _UpdateServiceRequest({
    @JsonKey(name: 'category_id') final String? categoryId,
    final String? name,
    final String? description,
    @JsonKey(name: 'booking_type') final String? bookingType,
    @JsonKey(name: 'duration_minutes') final int? durationMinutes,
    final int? capacity,
    final double? price,
    @JsonKey(name: 'is_active') final bool? isActive,
  }) = _$UpdateServiceRequestImpl;

  factory _UpdateServiceRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateServiceRequestImpl.fromJson;

  @override
  @JsonKey(name: 'category_id')
  String? get categoryId;
  @override
  String? get name;
  @override
  String? get description;
  @override
  @JsonKey(name: 'booking_type')
  String? get bookingType;
  @override
  @JsonKey(name: 'duration_minutes')
  int? get durationMinutes;
  @override
  int? get capacity;
  @override
  double? get price;
  @override
  @JsonKey(name: 'is_active')
  bool? get isActive;

  /// Create a copy of UpdateServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateServiceRequestImplCopyWith<_$UpdateServiceRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
