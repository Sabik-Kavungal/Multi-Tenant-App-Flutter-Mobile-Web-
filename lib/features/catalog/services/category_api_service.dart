import 'package:flutter/material.dart';
import 'package:saasf/core/api/api_endpoints.dart';
import 'package:saasf/core/api/api_service.dart';
import 'package:saasf/features/catalog/models/category_model.dart';
import 'package:saasf/features/tenant/models/tenant_api_response_model.dart';

/// Category API Service – Catalog Service API
/// Base: /api/v1, X-Tenant-ID header. Response: { success, data, error }
class CategoryApiService {
  final ApiService _apiService = ApiService();

  Map<String, String> _headers(String tenantId) => {'X-Tenant-ID': tenantId};

  /// GET /categories?is_active=true|false (optional)
  Future<TenantApiResponse<List<Category>>> listCategories({
    required String tenantId,
    bool? isActive,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      String endpoint = ApiEndpoints.categories;
      if (isActive != null) {
        endpoint = '$endpoint?is_active=$isActive';
      }
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
                  .map((e) => Category.fromJson(e as Map<String, dynamic>))
                  .toList()
              : <Category>[];
          return TenantApiResponse(success: true, data: list);
        }
        return TenantApiResponse(
          success: false,
          error: (response['error'] ?? 'Failed to get categories').toString(),
        );
      }
      return TenantApiResponse(
        success: false,
        error: 'Failed to get categories - no response data',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// GET /categories/:id
  Future<TenantApiResponse<Category>> getCategory({
    required String tenantId,
    required String categoryId,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.category(categoryId),
        method: 'GET',
        token: accessToken,
        context: context,
        extraHeaders: _headers(tenantId),
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response['success'] == true && response['data'] != null) {
          final c = Category.fromJson(
            response['data'] as Map<String, dynamic>,
          );
          return TenantApiResponse(success: true, data: c);
        }
        return TenantApiResponse(
          success: false,
          error: (response['error'] ?? 'Failed to get category').toString(),
        );
      }
      return TenantApiResponse(
        success: false,
        error: 'Failed to get category',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// POST /categories
  Future<TenantApiResponse<Category>> createCategory({
    required String tenantId,
    required CreateCategoryRequest request,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.categories,
        method: 'POST',
        body: request.toJson(),
        token: accessToken,
        context: context,
        extraHeaders: _headers(tenantId),
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response['success'] == true && response['data'] != null) {
          final c = Category.fromJson(
            response['data'] as Map<String, dynamic>,
          );
          return TenantApiResponse(
            success: true,
            data: c,
            message: 'Category created successfully',
          );
        }
        return TenantApiResponse(
          success: false,
          error: (response['error'] ?? 'Failed to create category').toString(),
        );
      }
      return TenantApiResponse(
        success: false,
        error: 'Failed to create category - no response data',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// PUT /categories/:id
  Future<TenantApiResponse<Category>> updateCategory({
    required String tenantId,
    required String categoryId,
    required UpdateCategoryRequest request,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.category(categoryId),
        method: 'PUT',
        body: request.toJson(),
        token: accessToken,
        context: context,
        extraHeaders: _headers(tenantId),
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response['success'] == true && response['data'] != null) {
          final c = Category.fromJson(
            response['data'] as Map<String, dynamic>,
          );
          return TenantApiResponse(
            success: true,
            data: c,
            message: 'Category updated successfully',
          );
        }
        return TenantApiResponse(
          success: false,
          error: (response['error'] ?? 'Failed to update category').toString(),
        );
      }
      return TenantApiResponse(
        success: false,
        error: 'Failed to update category',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// DELETE /categories/:id (soft delete; fails if category has services)
  Future<TenantApiResponse<void>> deleteCategory({
    required String tenantId,
    required String categoryId,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.category(categoryId),
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
                'Category deleted',
          );
        }
        return TenantApiResponse(
          success: false,
          error: (response['error'] ?? 'Failed to delete category').toString(),
        );
      }
      return TenantApiResponse(
        success: false,
        error: 'Failed to delete category',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }
}
