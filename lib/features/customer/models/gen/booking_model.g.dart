// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingImpl _$$BookingImplFromJson(Map<String, dynamic> json) =>
    _$BookingImpl(
      id: json['id'] as String?,
      customerId: json['customer_id'] as String?,
      tenantId: json['tenant_id'] as String?,
      tenantName: json['tenant_name'] as String?,
      serviceId: json['service_id'] as String?,
      serviceName: json['service_name'] as String?,
      bookingDate: json['booking_date'] as String?,
      bookingTime: json['booking_time'] as String?,
      durationMinutes: (json['duration_minutes'] as num?)?.toInt(),
      status: json['status'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$BookingImplToJson(_$BookingImpl instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.customerId case final value?) 'customer_id': value,
      if (instance.tenantId case final value?) 'tenant_id': value,
      if (instance.tenantName case final value?) 'tenant_name': value,
      if (instance.serviceId case final value?) 'service_id': value,
      if (instance.serviceName case final value?) 'service_name': value,
      if (instance.bookingDate case final value?) 'booking_date': value,
      if (instance.bookingTime case final value?) 'booking_time': value,
      if (instance.durationMinutes case final value?) 'duration_minutes': value,
      if (instance.status case final value?) 'status': value,
      if (instance.notes case final value?) 'notes': value,
      if (instance.createdAt case final value?) 'created_at': value,
      if (instance.updatedAt case final value?) 'updated_at': value,
    };

_$CreateBookingRequestImpl _$$CreateBookingRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateBookingRequestImpl(
  tenantId: json['tenant_id'] as String,
  serviceId: json['service_id'] as String,
  bookingDate: json['booking_date'] as String,
  bookingTime: json['booking_time'] as String,
  durationMinutes: (json['duration_minutes'] as num).toInt(),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$$CreateBookingRequestImplToJson(
  _$CreateBookingRequestImpl instance,
) => <String, dynamic>{
  'tenant_id': instance.tenantId,
  'service_id': instance.serviceId,
  'booking_date': instance.bookingDate,
  'booking_time': instance.bookingTime,
  'duration_minutes': instance.durationMinutes,
  if (instance.notes case final value?) 'notes': value,
};

_$UpdateBookingRequestImpl _$$UpdateBookingRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateBookingRequestImpl(
  bookingDate: json['booking_date'] as String?,
  bookingTime: json['booking_time'] as String?,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$$UpdateBookingRequestImplToJson(
  _$UpdateBookingRequestImpl instance,
) => <String, dynamic>{
  if (instance.bookingDate case final value?) 'booking_date': value,
  if (instance.bookingTime case final value?) 'booking_time': value,
  if (instance.notes case final value?) 'notes': value,
};

_$BookingListResponseImpl _$$BookingListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$BookingListResponseImpl(
  bookings: (json['bookings'] as List<dynamic>)
      .map((e) => Booking.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  pageSize: (json['page_size'] as num).toInt(),
  totalPages: (json['total_pages'] as num).toInt(),
);

Map<String, dynamic> _$$BookingListResponseImplToJson(
  _$BookingListResponseImpl instance,
) => <String, dynamic>{
  'bookings': instance.bookings.map((e) => e.toJson()).toList(),
  'total': instance.total,
  'page': instance.page,
  'page_size': instance.pageSize,
  'total_pages': instance.totalPages,
};
