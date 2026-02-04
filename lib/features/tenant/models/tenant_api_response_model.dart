import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saasf/features/tenant/models/tenant_model.dart';

part 'gen/tenant_api_response_model.freezed.dart';
part 'gen/tenant_api_response_model.g.dart';

/// Generic API response wrapper for tenant API calls
@Freezed(genericArgumentFactories: true)
class TenantApiResponse<T> with _$TenantApiResponse<T> {
  const factory TenantApiResponse({
    required bool success,
    T? data,
    String? message,
    String? error,
  }) = _TenantApiResponse<T>;

  factory TenantApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$TenantApiResponseFromJson(json, fromJsonT);
}

/// Paginated response for tenant list (Super Admin)
@freezed
class TenantListResponse with _$TenantListResponse {
  const factory TenantListResponse({
    required List<Tenant> tenants,
    required int total,
    required int page,
    @JsonKey(name: 'page_size') required int pageSize,
    @JsonKey(name: 'total_pages') required int totalPages,
  }) = _TenantListResponse;

  factory TenantListResponse.fromJson(Map<String, dynamic> json) =>
      _$TenantListResponseFromJson(json);
}
