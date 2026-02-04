// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../tenant_api_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TenantApiResponseImpl<T> _$$TenantApiResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _$TenantApiResponseImpl<T>(
  success: json['success'] as bool,
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
  message: json['message'] as String?,
  error: json['error'] as String?,
);

Map<String, dynamic> _$$TenantApiResponseImplToJson<T>(
  _$TenantApiResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'success': instance.success,
  if (_$nullableGenericToJson(instance.data, toJsonT) case final value?)
    'data': value,
  if (instance.message case final value?) 'message': value,
  if (instance.error case final value?) 'error': value,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

_$TenantListResponseImpl _$$TenantListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$TenantListResponseImpl(
  tenants: (json['tenants'] as List<dynamic>)
      .map((e) => Tenant.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  pageSize: (json['page_size'] as num).toInt(),
  totalPages: (json['total_pages'] as num).toInt(),
);

Map<String, dynamic> _$$TenantListResponseImplToJson(
  _$TenantListResponseImpl instance,
) => <String, dynamic>{
  'tenants': instance.tenants.map((e) => e.toJson()).toList(),
  'total': instance.total,
  'page': instance.page,
  'page_size': instance.pageSize,
  'total_pages': instance.totalPages,
};
