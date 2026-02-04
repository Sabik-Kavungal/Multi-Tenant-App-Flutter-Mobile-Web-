// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingImpl _$$BookingImplFromJson(Map<String, dynamic> json) =>
    _$BookingImpl(
      id: json['id'] as String?,
      tenantId: json['tenant_id'] as String?,
      userId: json['user_id'] as String?,
      serviceId: json['service_id'] as String?,
      bookingType: json['booking_type'] as String?,
      bookingDate: json['booking_date'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$BookingImplToJson(_$BookingImpl instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.tenantId case final value?) 'tenant_id': value,
      if (instance.userId case final value?) 'user_id': value,
      if (instance.serviceId case final value?) 'service_id': value,
      if (instance.bookingType case final value?) 'booking_type': value,
      if (instance.bookingDate case final value?) 'booking_date': value,
      if (instance.startTime case final value?) 'start_time': value,
      if (instance.endTime case final value?) 'end_time': value,
      if (instance.quantity case final value?) 'quantity': value,
      if (instance.status case final value?) 'status': value,
      if (instance.createdAt case final value?) 'created_at': value,
      if (instance.updatedAt case final value?) 'updated_at': value,
    };
