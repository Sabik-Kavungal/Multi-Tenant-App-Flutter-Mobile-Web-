// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Booking _$BookingFromJson(Map<String, dynamic> json) {
  return _Booking.fromJson(json);
}

/// @nodoc
mixin _$Booking {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  String? get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tenant_id')
  String? get tenantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tenant_name')
  String? get tenantName => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_id')
  String? get serviceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_name')
  String? get serviceName => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_date')
  String? get bookingDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_time')
  String? get bookingTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_minutes')
  int? get durationMinutes => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Booking to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingCopyWith<Booking> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingCopyWith<$Res> {
  factory $BookingCopyWith(Booking value, $Res Function(Booking) then) =
      _$BookingCopyWithImpl<$Res, Booking>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'customer_id') String? customerId,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'tenant_name') String? tenantName,
    @JsonKey(name: 'service_id') String? serviceId,
    @JsonKey(name: 'service_name') String? serviceName,
    @JsonKey(name: 'booking_date') String? bookingDate,
    @JsonKey(name: 'booking_time') String? bookingTime,
    @JsonKey(name: 'duration_minutes') int? durationMinutes,
    String? status,
    String? notes,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

/// @nodoc
class _$BookingCopyWithImpl<$Res, $Val extends Booking>
    implements $BookingCopyWith<$Res> {
  _$BookingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? customerId = freezed,
    Object? tenantId = freezed,
    Object? tenantName = freezed,
    Object? serviceId = freezed,
    Object? serviceName = freezed,
    Object? bookingDate = freezed,
    Object? bookingTime = freezed,
    Object? durationMinutes = freezed,
    Object? status = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            customerId: freezed == customerId
                ? _value.customerId
                : customerId // ignore: cast_nullable_to_non_nullable
                      as String?,
            tenantId: freezed == tenantId
                ? _value.tenantId
                : tenantId // ignore: cast_nullable_to_non_nullable
                      as String?,
            tenantName: freezed == tenantName
                ? _value.tenantName
                : tenantName // ignore: cast_nullable_to_non_nullable
                      as String?,
            serviceId: freezed == serviceId
                ? _value.serviceId
                : serviceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            serviceName: freezed == serviceName
                ? _value.serviceName
                : serviceName // ignore: cast_nullable_to_non_nullable
                      as String?,
            bookingDate: freezed == bookingDate
                ? _value.bookingDate
                : bookingDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            bookingTime: freezed == bookingTime
                ? _value.bookingTime
                : bookingTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            durationMinutes: freezed == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
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
abstract class _$$BookingImplCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$$BookingImplCopyWith(
    _$BookingImpl value,
    $Res Function(_$BookingImpl) then,
  ) = __$$BookingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'customer_id') String? customerId,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'tenant_name') String? tenantName,
    @JsonKey(name: 'service_id') String? serviceId,
    @JsonKey(name: 'service_name') String? serviceName,
    @JsonKey(name: 'booking_date') String? bookingDate,
    @JsonKey(name: 'booking_time') String? bookingTime,
    @JsonKey(name: 'duration_minutes') int? durationMinutes,
    String? status,
    String? notes,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

/// @nodoc
class __$$BookingImplCopyWithImpl<$Res>
    extends _$BookingCopyWithImpl<$Res, _$BookingImpl>
    implements _$$BookingImplCopyWith<$Res> {
  __$$BookingImplCopyWithImpl(
    _$BookingImpl _value,
    $Res Function(_$BookingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? customerId = freezed,
    Object? tenantId = freezed,
    Object? tenantName = freezed,
    Object? serviceId = freezed,
    Object? serviceName = freezed,
    Object? bookingDate = freezed,
    Object? bookingTime = freezed,
    Object? durationMinutes = freezed,
    Object? status = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$BookingImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        customerId: freezed == customerId
            ? _value.customerId
            : customerId // ignore: cast_nullable_to_non_nullable
                  as String?,
        tenantId: freezed == tenantId
            ? _value.tenantId
            : tenantId // ignore: cast_nullable_to_non_nullable
                  as String?,
        tenantName: freezed == tenantName
            ? _value.tenantName
            : tenantName // ignore: cast_nullable_to_non_nullable
                  as String?,
        serviceId: freezed == serviceId
            ? _value.serviceId
            : serviceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        serviceName: freezed == serviceName
            ? _value.serviceName
            : serviceName // ignore: cast_nullable_to_non_nullable
                  as String?,
        bookingDate: freezed == bookingDate
            ? _value.bookingDate
            : bookingDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        bookingTime: freezed == bookingTime
            ? _value.bookingTime
            : bookingTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        durationMinutes: freezed == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
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
class _$BookingImpl implements _Booking {
  const _$BookingImpl({
    this.id,
    @JsonKey(name: 'customer_id') this.customerId,
    @JsonKey(name: 'tenant_id') this.tenantId,
    @JsonKey(name: 'tenant_name') this.tenantName,
    @JsonKey(name: 'service_id') this.serviceId,
    @JsonKey(name: 'service_name') this.serviceName,
    @JsonKey(name: 'booking_date') this.bookingDate,
    @JsonKey(name: 'booking_time') this.bookingTime,
    @JsonKey(name: 'duration_minutes') this.durationMinutes,
    this.status,
    this.notes,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  });

  factory _$BookingImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'customer_id')
  final String? customerId;
  @override
  @JsonKey(name: 'tenant_id')
  final String? tenantId;
  @override
  @JsonKey(name: 'tenant_name')
  final String? tenantName;
  @override
  @JsonKey(name: 'service_id')
  final String? serviceId;
  @override
  @JsonKey(name: 'service_name')
  final String? serviceName;
  @override
  @JsonKey(name: 'booking_date')
  final String? bookingDate;
  @override
  @JsonKey(name: 'booking_time')
  final String? bookingTime;
  @override
  @JsonKey(name: 'duration_minutes')
  final int? durationMinutes;
  @override
  final String? status;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'Booking(id: $id, customerId: $customerId, tenantId: $tenantId, tenantName: $tenantName, serviceId: $serviceId, serviceName: $serviceName, bookingDate: $bookingDate, bookingTime: $bookingTime, durationMinutes: $durationMinutes, status: $status, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.tenantName, tenantName) ||
                other.tenantName == tenantName) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.bookingDate, bookingDate) ||
                other.bookingDate == bookingDate) &&
            (identical(other.bookingTime, bookingTime) ||
                other.bookingTime == bookingTime) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
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
    customerId,
    tenantId,
    tenantName,
    serviceId,
    serviceName,
    bookingDate,
    bookingTime,
    durationMinutes,
    status,
    notes,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingImplCopyWith<_$BookingImpl> get copyWith =>
      __$$BookingImplCopyWithImpl<_$BookingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingImplToJson(this);
  }
}

abstract class _Booking implements Booking {
  const factory _Booking({
    final String? id,
    @JsonKey(name: 'customer_id') final String? customerId,
    @JsonKey(name: 'tenant_id') final String? tenantId,
    @JsonKey(name: 'tenant_name') final String? tenantName,
    @JsonKey(name: 'service_id') final String? serviceId,
    @JsonKey(name: 'service_name') final String? serviceName,
    @JsonKey(name: 'booking_date') final String? bookingDate,
    @JsonKey(name: 'booking_time') final String? bookingTime,
    @JsonKey(name: 'duration_minutes') final int? durationMinutes,
    final String? status,
    final String? notes,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'updated_at') final String? updatedAt,
  }) = _$BookingImpl;

  factory _Booking.fromJson(Map<String, dynamic> json) = _$BookingImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'customer_id')
  String? get customerId;
  @override
  @JsonKey(name: 'tenant_id')
  String? get tenantId;
  @override
  @JsonKey(name: 'tenant_name')
  String? get tenantName;
  @override
  @JsonKey(name: 'service_id')
  String? get serviceId;
  @override
  @JsonKey(name: 'service_name')
  String? get serviceName;
  @override
  @JsonKey(name: 'booking_date')
  String? get bookingDate;
  @override
  @JsonKey(name: 'booking_time')
  String? get bookingTime;
  @override
  @JsonKey(name: 'duration_minutes')
  int? get durationMinutes;
  @override
  String? get status;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingImplCopyWith<_$BookingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateBookingRequest _$CreateBookingRequestFromJson(Map<String, dynamic> json) {
  return _CreateBookingRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateBookingRequest {
  @JsonKey(name: 'tenant_id')
  String get tenantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_id')
  String get serviceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_date')
  String get bookingDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_time')
  String get bookingTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this CreateBookingRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateBookingRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateBookingRequestCopyWith<CreateBookingRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateBookingRequestCopyWith<$Res> {
  factory $CreateBookingRequestCopyWith(
    CreateBookingRequest value,
    $Res Function(CreateBookingRequest) then,
  ) = _$CreateBookingRequestCopyWithImpl<$Res, CreateBookingRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'tenant_id') String tenantId,
    @JsonKey(name: 'service_id') String serviceId,
    @JsonKey(name: 'booking_date') String bookingDate,
    @JsonKey(name: 'booking_time') String bookingTime,
    @JsonKey(name: 'duration_minutes') int durationMinutes,
    String? notes,
  });
}

/// @nodoc
class _$CreateBookingRequestCopyWithImpl<
  $Res,
  $Val extends CreateBookingRequest
>
    implements $CreateBookingRequestCopyWith<$Res> {
  _$CreateBookingRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateBookingRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tenantId = null,
    Object? serviceId = null,
    Object? bookingDate = null,
    Object? bookingTime = null,
    Object? durationMinutes = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            tenantId: null == tenantId
                ? _value.tenantId
                : tenantId // ignore: cast_nullable_to_non_nullable
                      as String,
            serviceId: null == serviceId
                ? _value.serviceId
                : serviceId // ignore: cast_nullable_to_non_nullable
                      as String,
            bookingDate: null == bookingDate
                ? _value.bookingDate
                : bookingDate // ignore: cast_nullable_to_non_nullable
                      as String,
            bookingTime: null == bookingTime
                ? _value.bookingTime
                : bookingTime // ignore: cast_nullable_to_non_nullable
                      as String,
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateBookingRequestImplCopyWith<$Res>
    implements $CreateBookingRequestCopyWith<$Res> {
  factory _$$CreateBookingRequestImplCopyWith(
    _$CreateBookingRequestImpl value,
    $Res Function(_$CreateBookingRequestImpl) then,
  ) = __$$CreateBookingRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'tenant_id') String tenantId,
    @JsonKey(name: 'service_id') String serviceId,
    @JsonKey(name: 'booking_date') String bookingDate,
    @JsonKey(name: 'booking_time') String bookingTime,
    @JsonKey(name: 'duration_minutes') int durationMinutes,
    String? notes,
  });
}

/// @nodoc
class __$$CreateBookingRequestImplCopyWithImpl<$Res>
    extends _$CreateBookingRequestCopyWithImpl<$Res, _$CreateBookingRequestImpl>
    implements _$$CreateBookingRequestImplCopyWith<$Res> {
  __$$CreateBookingRequestImplCopyWithImpl(
    _$CreateBookingRequestImpl _value,
    $Res Function(_$CreateBookingRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateBookingRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tenantId = null,
    Object? serviceId = null,
    Object? bookingDate = null,
    Object? bookingTime = null,
    Object? durationMinutes = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$CreateBookingRequestImpl(
        tenantId: null == tenantId
            ? _value.tenantId
            : tenantId // ignore: cast_nullable_to_non_nullable
                  as String,
        serviceId: null == serviceId
            ? _value.serviceId
            : serviceId // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingDate: null == bookingDate
            ? _value.bookingDate
            : bookingDate // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingTime: null == bookingTime
            ? _value.bookingTime
            : bookingTime // ignore: cast_nullable_to_non_nullable
                  as String,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateBookingRequestImpl implements _CreateBookingRequest {
  const _$CreateBookingRequestImpl({
    @JsonKey(name: 'tenant_id') required this.tenantId,
    @JsonKey(name: 'service_id') required this.serviceId,
    @JsonKey(name: 'booking_date') required this.bookingDate,
    @JsonKey(name: 'booking_time') required this.bookingTime,
    @JsonKey(name: 'duration_minutes') required this.durationMinutes,
    this.notes,
  });

  factory _$CreateBookingRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateBookingRequestImplFromJson(json);

  @override
  @JsonKey(name: 'tenant_id')
  final String tenantId;
  @override
  @JsonKey(name: 'service_id')
  final String serviceId;
  @override
  @JsonKey(name: 'booking_date')
  final String bookingDate;
  @override
  @JsonKey(name: 'booking_time')
  final String bookingTime;
  @override
  @JsonKey(name: 'duration_minutes')
  final int durationMinutes;
  @override
  final String? notes;

  @override
  String toString() {
    return 'CreateBookingRequest(tenantId: $tenantId, serviceId: $serviceId, bookingDate: $bookingDate, bookingTime: $bookingTime, durationMinutes: $durationMinutes, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateBookingRequestImpl &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.bookingDate, bookingDate) ||
                other.bookingDate == bookingDate) &&
            (identical(other.bookingTime, bookingTime) ||
                other.bookingTime == bookingTime) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tenantId,
    serviceId,
    bookingDate,
    bookingTime,
    durationMinutes,
    notes,
  );

  /// Create a copy of CreateBookingRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateBookingRequestImplCopyWith<_$CreateBookingRequestImpl>
  get copyWith =>
      __$$CreateBookingRequestImplCopyWithImpl<_$CreateBookingRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateBookingRequestImplToJson(this);
  }
}

abstract class _CreateBookingRequest implements CreateBookingRequest {
  const factory _CreateBookingRequest({
    @JsonKey(name: 'tenant_id') required final String tenantId,
    @JsonKey(name: 'service_id') required final String serviceId,
    @JsonKey(name: 'booking_date') required final String bookingDate,
    @JsonKey(name: 'booking_time') required final String bookingTime,
    @JsonKey(name: 'duration_minutes') required final int durationMinutes,
    final String? notes,
  }) = _$CreateBookingRequestImpl;

  factory _CreateBookingRequest.fromJson(Map<String, dynamic> json) =
      _$CreateBookingRequestImpl.fromJson;

  @override
  @JsonKey(name: 'tenant_id')
  String get tenantId;
  @override
  @JsonKey(name: 'service_id')
  String get serviceId;
  @override
  @JsonKey(name: 'booking_date')
  String get bookingDate;
  @override
  @JsonKey(name: 'booking_time')
  String get bookingTime;
  @override
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes;
  @override
  String? get notes;

  /// Create a copy of CreateBookingRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateBookingRequestImplCopyWith<_$CreateBookingRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UpdateBookingRequest _$UpdateBookingRequestFromJson(Map<String, dynamic> json) {
  return _UpdateBookingRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateBookingRequest {
  @JsonKey(name: 'booking_date')
  String? get bookingDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_time')
  String? get bookingTime => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this UpdateBookingRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateBookingRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateBookingRequestCopyWith<UpdateBookingRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateBookingRequestCopyWith<$Res> {
  factory $UpdateBookingRequestCopyWith(
    UpdateBookingRequest value,
    $Res Function(UpdateBookingRequest) then,
  ) = _$UpdateBookingRequestCopyWithImpl<$Res, UpdateBookingRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'booking_date') String? bookingDate,
    @JsonKey(name: 'booking_time') String? bookingTime,
    String? notes,
  });
}

/// @nodoc
class _$UpdateBookingRequestCopyWithImpl<
  $Res,
  $Val extends UpdateBookingRequest
>
    implements $UpdateBookingRequestCopyWith<$Res> {
  _$UpdateBookingRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateBookingRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingDate = freezed,
    Object? bookingTime = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            bookingDate: freezed == bookingDate
                ? _value.bookingDate
                : bookingDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            bookingTime: freezed == bookingTime
                ? _value.bookingTime
                : bookingTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateBookingRequestImplCopyWith<$Res>
    implements $UpdateBookingRequestCopyWith<$Res> {
  factory _$$UpdateBookingRequestImplCopyWith(
    _$UpdateBookingRequestImpl value,
    $Res Function(_$UpdateBookingRequestImpl) then,
  ) = __$$UpdateBookingRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'booking_date') String? bookingDate,
    @JsonKey(name: 'booking_time') String? bookingTime,
    String? notes,
  });
}

/// @nodoc
class __$$UpdateBookingRequestImplCopyWithImpl<$Res>
    extends _$UpdateBookingRequestCopyWithImpl<$Res, _$UpdateBookingRequestImpl>
    implements _$$UpdateBookingRequestImplCopyWith<$Res> {
  __$$UpdateBookingRequestImplCopyWithImpl(
    _$UpdateBookingRequestImpl _value,
    $Res Function(_$UpdateBookingRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateBookingRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingDate = freezed,
    Object? bookingTime = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _$UpdateBookingRequestImpl(
        bookingDate: freezed == bookingDate
            ? _value.bookingDate
            : bookingDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        bookingTime: freezed == bookingTime
            ? _value.bookingTime
            : bookingTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateBookingRequestImpl implements _UpdateBookingRequest {
  const _$UpdateBookingRequestImpl({
    @JsonKey(name: 'booking_date') this.bookingDate,
    @JsonKey(name: 'booking_time') this.bookingTime,
    this.notes,
  });

  factory _$UpdateBookingRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateBookingRequestImplFromJson(json);

  @override
  @JsonKey(name: 'booking_date')
  final String? bookingDate;
  @override
  @JsonKey(name: 'booking_time')
  final String? bookingTime;
  @override
  final String? notes;

  @override
  String toString() {
    return 'UpdateBookingRequest(bookingDate: $bookingDate, bookingTime: $bookingTime, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateBookingRequestImpl &&
            (identical(other.bookingDate, bookingDate) ||
                other.bookingDate == bookingDate) &&
            (identical(other.bookingTime, bookingTime) ||
                other.bookingTime == bookingTime) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, bookingDate, bookingTime, notes);

  /// Create a copy of UpdateBookingRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateBookingRequestImplCopyWith<_$UpdateBookingRequestImpl>
  get copyWith =>
      __$$UpdateBookingRequestImplCopyWithImpl<_$UpdateBookingRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateBookingRequestImplToJson(this);
  }
}

abstract class _UpdateBookingRequest implements UpdateBookingRequest {
  const factory _UpdateBookingRequest({
    @JsonKey(name: 'booking_date') final String? bookingDate,
    @JsonKey(name: 'booking_time') final String? bookingTime,
    final String? notes,
  }) = _$UpdateBookingRequestImpl;

  factory _UpdateBookingRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateBookingRequestImpl.fromJson;

  @override
  @JsonKey(name: 'booking_date')
  String? get bookingDate;
  @override
  @JsonKey(name: 'booking_time')
  String? get bookingTime;
  @override
  String? get notes;

  /// Create a copy of UpdateBookingRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateBookingRequestImplCopyWith<_$UpdateBookingRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

BookingListResponse _$BookingListResponseFromJson(Map<String, dynamic> json) {
  return _BookingListResponse.fromJson(json);
}

/// @nodoc
mixin _$BookingListResponse {
  List<Booking> get bookings => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_size')
  int get pageSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_pages')
  int get totalPages => throw _privateConstructorUsedError;

  /// Serializes this BookingListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookingListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingListResponseCopyWith<BookingListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingListResponseCopyWith<$Res> {
  factory $BookingListResponseCopyWith(
    BookingListResponse value,
    $Res Function(BookingListResponse) then,
  ) = _$BookingListResponseCopyWithImpl<$Res, BookingListResponse>;
  @useResult
  $Res call({
    List<Booking> bookings,
    int total,
    int page,
    @JsonKey(name: 'page_size') int pageSize,
    @JsonKey(name: 'total_pages') int totalPages,
  });
}

/// @nodoc
class _$BookingListResponseCopyWithImpl<$Res, $Val extends BookingListResponse>
    implements $BookingListResponseCopyWith<$Res> {
  _$BookingListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookings = null,
    Object? total = null,
    Object? page = null,
    Object? pageSize = null,
    Object? totalPages = null,
  }) {
    return _then(
      _value.copyWith(
            bookings: null == bookings
                ? _value.bookings
                : bookings // ignore: cast_nullable_to_non_nullable
                      as List<Booking>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            pageSize: null == pageSize
                ? _value.pageSize
                : pageSize // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPages: null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BookingListResponseImplCopyWith<$Res>
    implements $BookingListResponseCopyWith<$Res> {
  factory _$$BookingListResponseImplCopyWith(
    _$BookingListResponseImpl value,
    $Res Function(_$BookingListResponseImpl) then,
  ) = __$$BookingListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Booking> bookings,
    int total,
    int page,
    @JsonKey(name: 'page_size') int pageSize,
    @JsonKey(name: 'total_pages') int totalPages,
  });
}

/// @nodoc
class __$$BookingListResponseImplCopyWithImpl<$Res>
    extends _$BookingListResponseCopyWithImpl<$Res, _$BookingListResponseImpl>
    implements _$$BookingListResponseImplCopyWith<$Res> {
  __$$BookingListResponseImplCopyWithImpl(
    _$BookingListResponseImpl _value,
    $Res Function(_$BookingListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookingListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookings = null,
    Object? total = null,
    Object? page = null,
    Object? pageSize = null,
    Object? totalPages = null,
  }) {
    return _then(
      _$BookingListResponseImpl(
        bookings: null == bookings
            ? _value._bookings
            : bookings // ignore: cast_nullable_to_non_nullable
                  as List<Booking>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        pageSize: null == pageSize
            ? _value.pageSize
            : pageSize // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPages: null == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingListResponseImpl implements _BookingListResponse {
  const _$BookingListResponseImpl({
    required final List<Booking> bookings,
    required this.total,
    required this.page,
    @JsonKey(name: 'page_size') required this.pageSize,
    @JsonKey(name: 'total_pages') required this.totalPages,
  }) : _bookings = bookings;

  factory _$BookingListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingListResponseImplFromJson(json);

  final List<Booking> _bookings;
  @override
  List<Booking> get bookings {
    if (_bookings is EqualUnmodifiableListView) return _bookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookings);
  }

  @override
  final int total;
  @override
  final int page;
  @override
  @JsonKey(name: 'page_size')
  final int pageSize;
  @override
  @JsonKey(name: 'total_pages')
  final int totalPages;

  @override
  String toString() {
    return 'BookingListResponse(bookings: $bookings, total: $total, page: $page, pageSize: $pageSize, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingListResponseImpl &&
            const DeepCollectionEquality().equals(other._bookings, _bookings) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_bookings),
    total,
    page,
    pageSize,
    totalPages,
  );

  /// Create a copy of BookingListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingListResponseImplCopyWith<_$BookingListResponseImpl> get copyWith =>
      __$$BookingListResponseImplCopyWithImpl<_$BookingListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingListResponseImplToJson(this);
  }
}

abstract class _BookingListResponse implements BookingListResponse {
  const factory _BookingListResponse({
    required final List<Booking> bookings,
    required final int total,
    required final int page,
    @JsonKey(name: 'page_size') required final int pageSize,
    @JsonKey(name: 'total_pages') required final int totalPages,
  }) = _$BookingListResponseImpl;

  factory _BookingListResponse.fromJson(Map<String, dynamic> json) =
      _$BookingListResponseImpl.fromJson;

  @override
  List<Booking> get bookings;
  @override
  int get total;
  @override
  int get page;
  @override
  @JsonKey(name: 'page_size')
  int get pageSize;
  @override
  @JsonKey(name: 'total_pages')
  int get totalPages;

  /// Create a copy of BookingListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingListResponseImplCopyWith<_$BookingListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
