import 'package:flutter/material.dart';
import 'package:saasf/core/api/api_endpoints.dart';
import 'package:saasf/core/api/api_service.dart';
import 'package:saasf/features/catalog/models/service_model.dart';
import 'package:saasf/features/tenant/models/tenant_api_response_model.dart';

/// Service API Service – Catalog Service API
/// Base: /api/v1, X-Tenant-ID header. Response: { success, data, error }
class ServiceApiService {
  final ApiService _apiService = ApiService();

  Map<String, String> _headers(String tenantId) => {'X-Tenant-ID': tenantId};

  /// GET /services?category_id= & is_active= (optional)
  Future<TenantApiResponse<List<Service>>> listServices({
    required String tenantId,
    String? categoryId,
    bool? isActive,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final q = <String>[];
      if (categoryId != null && categoryId.isNotEmpty) {
        q.add('category_id=$categoryId');
      }
      if (isActive != null) {
        q.add('is_active=$isActive');
      }
      String endpoint = ApiEndpoints.services;
      if (q.isNotEmpty) endpoint = '$endpoint?${q.join('&')}';

      final response = await _apiService.request(
        endpoint,
        method: 'GET',
        token: accessToken,
        context: context,
        extraHeaders: _headers(tenantId),
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response['success'] == true && response['data'] != null) {
          final list = response['data'] is List
              ? (response['data'] as List)
                  .map((e) => Service.fromJson(e as Map<String, dynamic>))
                  .toList()
              : <Service>[];
          return TenantApiResponse(success: true, data: list);
        }
        return TenantApiResponse(
          success: false,
          error: (response['error'] ?? 'Failed to get services').toString(),
        );
      }
      return TenantApiResponse(
        success: false,
        error: 'Failed to get services - no response data',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// GET /services/:id
  Future<TenantApiResponse<Service>> getService({
    required String tenantId,
    required String serviceId,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.service(serviceId),
        method: 'GET',
        token: accessToken,
        context: context,
        extraHeaders: _headers(tenantId),
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response['success'] == true && response['data'] != null) {
          final s = Service.fromJson(
            response['data'] as Map<String, dynamic>,
          );
          return TenantApiResponse(success: true, data: s);
        }
        return TenantApiResponse(
          success: false,
          error: (response['error'] ?? 'Failed to get service').toString(),
        );
      }
      return TenantApiResponse(
        success: false,
        error: 'Failed to get service',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// POST /services
  Future<TenantApiResponse<Service>> createService({
    required String tenantId,
    required CreateServiceRequest request,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.services,
        method: 'POST',
        body: request.toJson(),
        token: accessToken,
        context: context,
        extraHeaders: _headers(tenantId),
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response['success'] == true && response['data'] != null) {
          final s = Service.fromJson(
            response['data'] as Map<String, dynamic>,
          );
          return TenantApiResponse(
            success: true,
            data: s,
            message: 'Service created successfully',
          );
        }
        return TenantApiResponse(
          success: false,
          error: (response['error'] ?? 'Failed to create service').toString(),
        );
      }
      return TenantApiResponse(
        success: false,
        error: 'Failed to create service - no response data',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// PUT /services/:id
  Future<TenantApiResponse<Service>> updateService({
    required String tenantId,
    required String serviceId,
    required UpdateServiceRequest request,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.service(serviceId),
        method: 'PUT',
        body: request.toJson(),
        token: accessToken,
        context: context,
        extraHeaders: _headers(tenantId),
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response['success'] == true && response['data'] != null) {
          final s = Service.fromJson(
            response['data'] as Map<String, dynamic>,
          );
          return TenantApiResponse(
            success: true,
            data: s,
            message: 'Service updated successfully',
          );
        }
        return TenantApiResponse(
          success: false,
          error: (response['error'] ?? 'Failed to update service').toString(),
        );
      }
      return TenantApiResponse(
        success: false,
        error: 'Failed to update service',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// DELETE /services/:id (soft delete)
  Future<TenantApiResponse<void>> deleteService({
    required String tenantId,
    required String serviceId,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.service(serviceId),
        method: 'DELETE',
        token: accessToken,
        context: context,
        extraHeaders: _headers(tenantId),
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response['success'] == true) {
          return TenantApiResponse(
            success: true,
            message: (response['data'] is Map
                    ? (response['data'] as Map)['message']
                    : null) as String? ??
                'Service deleted',
          );
        }
        return TenantApiResponse(
          success: false,
          error: (response['error'] ?? 'Failed to delete service').toString(),
        );
      }
      return TenantApiResponse(
        success: false,
        error: 'Failed to delete service',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }
}
