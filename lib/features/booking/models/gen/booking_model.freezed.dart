// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_element, deprecated_member_use, deprecated_member_use_from_same_package

part of '../booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed.',
);

Booking _$BookingFromJson(Map<String, dynamic> json) {
  return _Booking.fromJson(json);
}

mixin _$Booking {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'tenant_id') String? get tenantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id') String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_id') String? get serviceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_type') String? get bookingType => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_date') String? get bookingDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time') String? get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time') String? get endTime => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at') String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at') String? get updatedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingCopyWith<Booking> get copyWith => throw _privateConstructorUsedError;
}

abstract class $BookingCopyWith<$Res> {
  factory $BookingCopyWith(Booking value, $Res Function(Booking) then) =
      _$BookingCopyWithImpl<$Res, Booking>;
  $Res call({
    String? id,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'service_id') String? serviceId,
    @JsonKey(name: 'booking_type') String? bookingType,
    @JsonKey(name: 'booking_date') String? bookingDate,
    @JsonKey(name: 'start_time') String? startTime,
    @JsonKey(name: 'end_time') String? endTime,
    int? quantity,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

class _$BookingCopyWithImpl<$Res, $Val extends Booking>
    implements $BookingCopyWith<$Res> {
  _$BookingCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? userId = freezed,
    Object? serviceId = freezed,
    Object? bookingType = freezed,
    Object? bookingDate = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? quantity = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id ? _value.id : id as String?,
      tenantId: freezed == tenantId ? _value.tenantId : tenantId as String?,
      userId: freezed == userId ? _value.userId : userId as String?,
      serviceId: freezed == serviceId ? _value.serviceId : serviceId as String?,
      bookingType: freezed == bookingType ? _value.bookingType : bookingType as String?,
      bookingDate: freezed == bookingDate ? _value.bookingDate : bookingDate as String?,
      startTime: freezed == startTime ? _value.startTime : startTime as String?,
      endTime: freezed == endTime ? _value.endTime : endTime as String?,
      quantity: freezed == quantity ? _value.quantity : quantity as int?,
      status: freezed == status ? _value.status : status as String?,
      createdAt: freezed == createdAt ? _value.createdAt : createdAt as String?,
      updatedAt: freezed == updatedAt ? _value.updatedAt : updatedAt as String?,
    ) as $Val);
  }
}

abstract class _$$BookingImplCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$$BookingImplCopyWith(_$BookingImpl value, $Res Function(_$BookingImpl) then) =
      __$$BookingImplCopyWithImpl<$Res>;
  @override
  $Res call({
    String? id,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'service_id') String? serviceId,
    @JsonKey(name: 'booking_type') String? bookingType,
    @JsonKey(name: 'booking_date') String? bookingDate,
    @JsonKey(name: 'start_time') String? startTime,
    @JsonKey(name: 'end_time') String? endTime,
    int? quantity,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

class __$$BookingImplCopyWithImpl<$Res>
    extends _$BookingCopyWithImpl<$Res, _$BookingImpl>
    implements _$$BookingImplCopyWith<$Res> {
  __$$BookingImplCopyWithImpl(_$BookingImpl _value, $Res Function(_$BookingImpl) _then)
      : super(_value, _then);

  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? userId = freezed,
    Object? serviceId = freezed,
    Object? bookingType = freezed,
    Object? bookingDate = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? quantity = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$BookingImpl(
      id: freezed == id ? _value.id : id as String?,
      tenantId: freezed == tenantId ? _value.tenantId : tenantId as String?,
      userId: freezed == userId ? _value.userId : userId as String?,
      serviceId: freezed == serviceId ? _value.serviceId : serviceId as String?,
      bookingType: freezed == bookingType ? _value.bookingType : bookingType as String?,
      bookingDate: freezed == bookingDate ? _value.bookingDate : bookingDate as String?,
      startTime: freezed == startTime ? _value.startTime : startTime as String?,
      endTime: freezed == endTime ? _value.endTime : endTime as String?,
      quantity: freezed == quantity ? _value.quantity : quantity as int?,
      status: freezed == status ? _value.status : status as String?,
      createdAt: freezed == createdAt ? _value.createdAt : createdAt as String?,
      updatedAt: freezed == updatedAt ? _value.updatedAt : updatedAt as String?,
    ));
  }
}

@JsonSerializable()
class _$BookingImpl implements _Booking {
  const _$BookingImpl({
    this.id,
    @JsonKey(name: 'tenant_id') this.tenantId,
    @JsonKey(name: 'user_id') this.userId,
    @JsonKey(name: 'service_id') this.serviceId,
    @JsonKey(name: 'booking_type') this.bookingType,
    @JsonKey(name: 'booking_date') this.bookingDate,
    @JsonKey(name: 'start_time') this.startTime,
    @JsonKey(name: 'end_time') this.endTime,
    this.quantity,
    this.status,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  });

  factory _$BookingImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'tenant_id')
  final String? tenantId;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @JsonKey(name: 'service_id')
  final String? serviceId;
  @override
  @JsonKey(name: 'booking_type')
  final String? bookingType;
  @override
  @JsonKey(name: 'booking_date')
  final String? bookingDate;
  @override
  @JsonKey(name: 'start_time')
  final String? startTime;
  @override
  @JsonKey(name: 'end_time')
  final String? endTime;
  @override
  final int? quantity;
  @override
  final String? status;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() =>
      'Booking(id: $id, tenantId: $tenantId, userId: $userId, serviceId: $serviceId, bookingType: $bookingType, bookingDate: $bookingDate, startTime: $startTime, endTime: $endTime, quantity: $quantity, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _$BookingImpl &&
          (identical(other.id, id) || other.id == id) &&
          (identical(other.tenantId, tenantId) || other.tenantId == tenantId) &&
          (identical(other.userId, userId) || other.userId == userId) &&
          (identical(other.serviceId, serviceId) || other.serviceId == serviceId) &&
          (identical(other.bookingType, bookingType) || other.bookingType == bookingType) &&
          (identical(other.bookingDate, bookingDate) || other.bookingDate == bookingDate) &&
          (identical(other.startTime, startTime) || other.startTime == startTime) &&
          (identical(other.endTime, endTime) || other.endTime == endTime) &&
          (identical(other.quantity, quantity) || other.quantity == quantity) &&
          (identical(other.status, status) || other.status == status) &&
          (identical(other.createdAt, createdAt) || other.createdAt == createdAt) &&
          (identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, tenantId, userId, serviceId, bookingType, bookingDate, startTime, endTime, quantity, status, createdAt, updatedAt);

  @override
  @pragma('vm:prefer-inline')
  _$$BookingImplCopyWith<_$BookingImpl> get copyWith =>
      __$$BookingImplCopyWithImpl<_$BookingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() => _$$BookingImplToJson(this);
}

abstract class _Booking implements Booking {
  const factory _Booking({
    final String? id,
    @JsonKey(name: 'tenant_id') final String? tenantId,
    @JsonKey(name: 'user_id') final String? userId,
    @JsonKey(name: 'service_id') final String? serviceId,
    @JsonKey(name: 'booking_type') final String? bookingType,
    @JsonKey(name: 'booking_date') final String? bookingDate,
    @JsonKey(name: 'start_time') final String? startTime,
    @JsonKey(name: 'end_time') final String? endTime,
    final int? quantity,
    final String? status,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'updated_at') final String? updatedAt,
  }) = _$BookingImpl;

  factory _Booking.fromJson(Map<String, dynamic> json) = _$BookingImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'tenant_id')
  String? get tenantId;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  @JsonKey(name: 'service_id')
  String? get serviceId;
  @override
  @JsonKey(name: 'booking_type')
  String? get bookingType;
  @override
  @JsonKey(name: 'booking_date')
  String? get bookingDate;
  @override
  @JsonKey(name: 'start_time')
  String? get startTime;
  @override
  @JsonKey(name: 'end_time')
  String? get endTime;
  @override
  int? get quantity;
  @override
  String? get status;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingImplCopyWith<_$BookingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
