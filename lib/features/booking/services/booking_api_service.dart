import 'package:flutter/material.dart';
import 'package:saasf/core/api/api_endpoints.dart';
import 'package:saasf/core/api/api_service.dart';
import 'package:saasf/features/booking/models/booking_model.dart';
import 'package:saasf/features/tenant/models/tenant_api_response_model.dart';

/// Booking API Service – Booking Service API
/// Base: /api/v1. Response: { success, data, error }. JWT required; Kong forwards X-Tenant-ID, X-User-ID.
class BookingApiService {
  final ApiService _api = ApiService();

  /// GET /health (no auth)
  Future<TenantApiResponse<Map<String, dynamic>?>> health() async {
    try {
      final response = await _api.request(
        ApiEndpoints.health,
        method: 'GET',
      );
      if (response != null && response is Map<String, dynamic>) {
        if (response['success'] == true) {
          return TenantApiResponse(
            success: true,
            data: response['data'] as Map<String, dynamic>?,
          );
        }
        return TenantApiResponse(
          success: false,
          error: (response['error'] ?? 'Health check failed').toString(),
        );
      }
      return TenantApiResponse(success: false, error: 'No response');
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// X-Tenant-ID header. Required for CUSTOMER (JWT has no tenant_id). Optional for ADMIN/STAFF when Kong sets it from JWT.
  Map<String, String>? _tenantHeader(String? xTenantId) =>
      (xTenantId != null && xTenantId.isNotEmpty) ? {'X-Tenant-ID': xTenantId} : null;

  /// POST /bookings
  Future<TenantApiResponse<Booking>> create({
    required CreateBookingRequest request,
    required String accessToken,
    BuildContext? context,
    String? xTenantId,
  }) async {
    try {
      final response = await _api.request(
        ApiEndpoints.bookings,
        method: 'POST',
        body: request.toApiJson(),
        token: accessToken,
        context: context,
        extraHeaders: _tenantHeader(xTenantId),
      );
      if (response != null && response is Map<String, dynamic>) {
        if (response['success'] == true && response['data'] != null) {
          final b = Booking.fromJson(
            response['data'] as Map<String, dynamic>,
          );
          return TenantApiResponse(
            success: true,
            data: b,
            message: 'Booking created',
          );
        }
        return TenantApiResponse(
          success: false,
          error: (response['error'] ?? 'Failed to create booking').toString(),
        );
      }
      return TenantApiResponse(
        success: false,
        error: 'Failed to create booking - no response',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// GET /bookings?limit=&offset=
  /// [xTenantId] Required for CUSTOMER. Optional for ADMIN/STAFF.
  Future<TenantApiResponse<BookingListResult>> list({
    int limit = 20,
    int offset = 0,
    required String accessToken,
    BuildContext? context,
    String? xTenantId,
  }) async {
    try {
      final endpoint =
          '${ApiEndpoints.bookings}?limit=$limit&offset=$offset';
      final response = await _api.request(
        endpoint,
        method: 'GET',
        token: accessToken,
        context: context,
        extraHeaders: _tenantHeader(xTenantId),
      );
      if (response != null && response is Map<String, dynamic>) {
        if (response['success'] == true && response['data'] != null) {
          final d = response['data'] as Map<String, dynamic>?;
          final items = (d?['items'] as List?)
                  ?.map((e) => Booking.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [];
          final total = (d?['total'] as num?)?.toInt() ?? 0;
          return TenantApiResponse(
            success: true,
            data: BookingListResult(items: items, total: total),
          );
        }
        return TenantApiResponse(
          success: false,
          error: (response['error'] ?? 'Failed to list bookings').toString(),
        );
      }
      return TenantApiResponse(
        success: false,
        error: 'Failed to list bookings - no response',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// GET /bookings/:id
  /// [xTenantId] Required for CUSTOMER. Optional for ADMIN/STAFF.
  Future<TenantApiResponse<Booking>> getById({
    required String id,
    required String accessToken,
    BuildContext? context,
    String? xTenantId,
  }) async {
    try {
      final response = await _api.request(
        ApiEndpoints.booking(id),
        method: 'GET',
        token: accessToken,
        context: context,
        extraHeaders: _tenantHeader(xTenantId),
      );
      if (response != null && response is Map<String, dynamic>) {
        if (response['success'] == true && response['data'] != null) {
          final b = Booking.fromJson(
            response['data'] as Map<String, dynamic>,
          );
          return TenantApiResponse(success: true, data: b);
        }
        return TenantApiResponse(
          success: false,
          error: (response['error'] ?? 'Failed to get booking').toString(),
        );
      }
      return TenantApiResponse(
        success: false,
        error: 'Failed to get booking - no response',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// PUT /bookings/:id/cancel
  /// [xTenantId] Required for CUSTOMER. Optional for ADMIN/STAFF.
  Future<TenantApiResponse<void>> cancel({
    required String id,
    required String accessToken,
    BuildContext? context,
    String? xTenantId,
  }) async {
    try {
      final response = await _api.request(
        ApiEndpoints.bookingCancel(id),
        method: 'PUT',
        body: <String, dynamic>{},
        token: accessToken,
        context: context,
        extraHeaders: _tenantHeader(xTenantId),
      );
      if (response != null && response is Map<String, dynamic>) {
        if (response['success'] == true) {
          return TenantApiResponse(
            success: true,
            message: (response['data'] is Map
                    ? (response['data'] as Map)['message']
                    : null) as String? ??
                'Booking cancelled',
          );
        }
        return TenantApiResponse(
          success: false,
          error: (response['error'] ?? 'Failed to cancel booking').toString(),
        );
      }
      return TenantApiResponse(
        success: false,
        error: 'Failed to cancel booking - no response',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// PUT /bookings/:id/complete
  /// [xTenantId] Required for CUSTOMER. Optional for ADMIN/STAFF.
  Future<TenantApiResponse<void>> complete({
    required String id,
    required String accessToken,
    BuildContext? context,
    String? xTenantId,
  }) async {
    try {
      final response = await _api.request(
        ApiEndpoints.bookingComplete(id),
        method: 'PUT',
        body: <String, dynamic>{},
        token: accessToken,
        context: context,
        extraHeaders: _tenantHeader(xTenantId),
      );
      if (response != null && response is Map<String, dynamic>) {
        if (response['success'] == true) {
          return TenantApiResponse(
            success: true,
            message: (response['data'] is Map
                    ? (response['data'] as Map)['message']
                    : null) as String? ??
                'Booking completed',
          );
        }
        return TenantApiResponse(
          success: false,
          error: (response['error'] ?? 'Failed to complete booking').toString(),
        );
      }
      return TenantApiResponse(
        success: false,
        error: 'Failed to complete booking - no response',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }
}
