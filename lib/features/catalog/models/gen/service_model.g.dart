// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceImpl _$$ServiceImplFromJson(Map<String, dynamic> json) =>
    _$ServiceImpl(
      id: json['id'] as String?,
      tenantId: json['tenant_id'] as String?,
      categoryId: json['category_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      bookingType: json['booking_type'] as String?,
      durationMinutes: (json['duration_minutes'] as num?)?.toInt(),
      capacity: (json['capacity'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$ServiceImplToJson(_$ServiceImpl instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.tenantId case final value?) 'tenant_id': value,
      if (instance.categoryId case final value?) 'category_id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.description case final value?) 'description': value,
      if (instance.bookingType case final value?) 'booking_type': value,
      if (instance.durationMinutes case final value?) 'duration_minutes': value,
      if (instance.capacity case final value?) 'capacity': value,
      if (instance.price case final value?) 'price': value,
      if (instance.isActive case final value?) 'is_active': value,
      if (instance.createdAt case final value?) 'created_at': value,
    };

_$CreateServiceRequestImpl _$$CreateServiceRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateServiceRequestImpl(
  categoryId: json['category_id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  bookingType: json['booking_type'] as String,
  durationMinutes: (json['duration_minutes'] as num?)?.toInt(),
  capacity: (json['capacity'] as num?)?.toInt(),
  price: (json['price'] as num).toDouble(),
  isActive: json['is_active'] as bool?,
);

Map<String, dynamic> _$$CreateServiceRequestImplToJson(
  _$CreateServiceRequestImpl instance,
) => <String, dynamic>{
  'category_id': instance.categoryId,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  'booking_type': instance.bookingType,
  if (instance.durationMinutes case final value?) 'duration_minutes': value,
  if (instance.capacity case final value?) 'capacity': value,
  'price': instance.price,
  if (instance.isActive case final value?) 'is_active': value,
};

_$UpdateServiceRequestImpl _$$UpdateServiceRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateServiceRequestImpl(
  categoryId: json['category_id'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  bookingType: json['booking_type'] as String?,
  durationMinutes: (json['duration_minutes'] as num?)?.toInt(),
  capacity: (json['capacity'] as num?)?.toInt(),
  price: (json['price'] as num?)?.toDouble(),
  isActive: json['is_active'] as bool?,
);

Map<String, dynamic> _$$UpdateServiceRequestImplToJson(
  _$UpdateServiceRequestImpl instance,
) => <String, dynamic>{
  if (instance.categoryId case final value?) 'category_id': value,
  if (instance.name case final value?) 'name': value,
  if (instance.description case final value?) 'description': value,
  if (instance.bookingType case final value?) 'booking_type': value,
  if (instance.durationMinutes case final value?) 'duration_minutes': value,
  if (instance.capacity case final value?) 'capacity': value,
  if (instance.price case final value?) 'price': value,
  if (instance.isActive case final value?) 'is_active': value,
};
