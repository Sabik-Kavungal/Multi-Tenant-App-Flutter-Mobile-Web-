import 'package:flutter/material.dart';
import 'package:saasf/core/api/api_endpoints.dart';
import 'package:saasf/core/api/api_service.dart';
import 'package:saasf/features/customer/models/booking_model.dart';
import 'package:saasf/features/customer/models/customer_api_response_model.dart';
import 'package:saasf/features/tenant/models/tenant_model.dart';
import 'package:saasf/features/tenant/models/tenant_api_response_model.dart';
import 'package:saasf/features/tenant/models/working_hours_model.dart';
import 'package:saasf/features/tenant/models/holiday_model.dart';

/// Customer API Service
/// Handles all customer-related API calls
/// Implements full Customer Role API:
/// - Browse Tenants/Businesses
/// - View Tenant Details, Working Hours, Holidays
/// - Create, View, Update, Cancel Bookings
class CustomerApiService {
  final ApiService _apiService = ApiService();

  // ============================================
  // TENANT/BUSINESS BROWSING
  // ============================================

  /// Browse all tenants/businesses
  /// GET /api/v1/tenants
  /// Query params: page, page_size, type, status
  Future<CustomerApiResponse<TenantListResponse>> browseTenants({
    int page = 1,
    int pageSize = 20,
    String? type,
    String? status,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      // Build query parameters
      final queryParams = <String, String>{
        'page': page.toString(),
        'page_size': pageSize.toString(),
      };
      if (type != null && type.isNotEmpty) {
        queryParams['type'] = type;
      }
      if (status != null && status.isNotEmpty) {
        queryParams['status'] = status;
      }

      // Build URL with query params
      String endpoint = ApiEndpoints.tenants;
      if (queryParams.isNotEmpty) {
        final queryString = queryParams.entries
            .map((e) => '${e.key}=${e.value}')
            .join('&');
        endpoint = '$endpoint?$queryString';
      }

      final response = await _apiService.request(
        endpoint,
        method: 'GET',
        token: accessToken,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        // Check if it's an error response
        if (response.containsKey('error')) {
          return CustomerApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to browse tenants',
          );
        }

        // Parse tenant list response
        final tenantListResponse = TenantListResponse.fromJson(response);
        return CustomerApiResponse(success: true, data: tenantListResponse);
      }

      return CustomerApiResponse(
        success: false,
        error: 'Failed to browse tenants',
      );
    } catch (e) {
      return CustomerApiResponse(success: false, error: e.toString());
    }
  }

  /// Get tenant details
  /// GET /api/v1/tenants/:id
  Future<CustomerApiResponse<Tenant>> getTenant({
    required String tenantId,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.tenant(tenantId),
        method: 'GET',
        token: accessToken,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        // Check if it's an error response
        if (response.containsKey('error')) {
          return CustomerApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to get tenant',
          );
        }

        // Parse tenant response
        final tenant = Tenant.fromJson(response);
        return CustomerApiResponse(success: true, data: tenant);
      }

      return CustomerApiResponse(success: false, error: 'Failed to get tenant');
    } catch (e) {
      return CustomerApiResponse(success: false, error: e.toString());
    }
  }

  /// Get tenant working hours
  /// GET /api/v1/tenants/:id/hours
  Future<CustomerApiResponse<List<WorkingHours>>> getTenantHours({
    required String tenantId,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.workingHours(tenantId),
        method: 'GET',
        token: accessToken,
        context: context,
      );

      if (response != null) {
        // Check if it's an error response
        if (response is Map<String, dynamic> && response.containsKey('error')) {
          return CustomerApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to get working hours',
          );
        }

        // Parse working hours list (array response)
        if (response is List) {
          final hours = response
              .map(
                (json) => WorkingHours.fromJson(json as Map<String, dynamic>),
              )
              .toList();
          return CustomerApiResponse(success: true, data: hours);
        }
      }

      return CustomerApiResponse(
        success: false,
        error: 'Failed to get working hours',
      );
    } catch (e) {
      return CustomerApiResponse(success: false, error: e.toString());
    }
  }

  /// Get tenant holidays
  /// GET /api/v1/tenants/:id/holidays
  Future<CustomerApiResponse<List<Holiday>>> getTenantHolidays({
    required String tenantId,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.holidays(tenantId),
        method: 'GET',
        token: accessToken,
        context: context,
      );

      if (response != null) {
        // Check if it's an error response
        if (response is Map<String, dynamic> && response.containsKey('error')) {
          return CustomerApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to get holidays',
          );
        }

        // Parse holidays list (array response)
        if (response is List) {
          final holidays = response
              .map((json) => Holiday.fromJson(json as Map<String, dynamic>))
              .toList();
          return CustomerApiResponse(success: true, data: holidays);
        }
      }

      return CustomerApiResponse(
        success: false,
        error: 'Failed to get holidays',
      );
    } catch (e) {
      return CustomerApiResponse(success: false, error: e.toString());
    }
  }

  // ============================================
  // BOOKING OPERATIONS
  // ============================================

  /// Create a new booking
  /// POST /api/v1/bookings
  Future<CustomerApiResponse<Booking>> createBooking({
    required CreateBookingRequest request,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final body = <String, dynamic>{
        'tenant_id': request.tenantId,
        'service_id': request.serviceId,
        'booking_date': request.bookingDate,
        'booking_time': request.bookingTime,
        'duration_minutes': request.durationMinutes,
      };
      if (request.notes != null && request.notes!.isNotEmpty) {
        body['notes'] = request.notes;
      }

      final response = await _apiService.request(
        ApiEndpoints.bookings,
        method: 'POST',
        token: accessToken,
        body: body,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        // Check if it's an error response
        if (response.containsKey('error')) {
          return CustomerApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to create booking',
          );
        }

        // Parse booking response
        final booking = Booking.fromJson(response);
        return CustomerApiResponse(
          success: true,
          data: booking,
          message: 'Booking created successfully',
        );
      }

      return CustomerApiResponse(
        success: false,
        error: 'Failed to create booking',
      );
    } catch (e) {
      return CustomerApiResponse(success: false, error: e.toString());
    }
  }

  /// Get my bookings (for authenticated customer)
  /// GET /api/v1/bookings
  /// Query params: status, tenant_id, page, page_size
  Future<CustomerApiResponse<BookingListResponse>> getMyBookings({
    String? status,
    String? tenantId,
    int page = 1,
    int pageSize = 20,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      // Build query parameters
      final queryParams = <String, String>{
        'page': page.toString(),
        'page_size': pageSize.toString(),
      };
      if (status != null && status.isNotEmpty) {
        queryParams['status'] = status;
      }
      if (tenantId != null && tenantId.isNotEmpty) {
        queryParams['tenant_id'] = tenantId;
      }

      // Build URL with query params
      String endpoint = ApiEndpoints.bookings;
      if (queryParams.isNotEmpty) {
        final queryString = queryParams.entries
            .map((e) => '${e.key}=${e.value}')
            .join('&');
        endpoint = '$endpoint?$queryString';
      }

      final response = await _apiService.request(
        endpoint,
        method: 'GET',
        token: accessToken,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        // Check if it's an error response
        if (response.containsKey('error')) {
          return CustomerApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to get bookings',
          );
        }

        // Parse booking list response
        final bookingListResponse = BookingListResponse.fromJson(response);
        return CustomerApiResponse(success: true, data: bookingListResponse);
      }

      return CustomerApiResponse(
        success: false,
        error: 'Failed to get bookings',
      );
    } catch (e) {
      return CustomerApiResponse(success: false, error: e.toString());
    }
  }

  /// Update a booking
  /// PUT /api/v1/bookings/:id
  Future<CustomerApiResponse<Booking>> updateBooking({
    required String bookingId,
    required UpdateBookingRequest request,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (request.bookingDate != null && request.bookingDate!.isNotEmpty) {
        body['booking_date'] = request.bookingDate;
      }
      if (request.bookingTime != null && request.bookingTime!.isNotEmpty) {
        body['booking_time'] = request.bookingTime;
      }
      if (request.notes != null) {
        body['notes'] = request.notes;
      }

      final response = await _apiService.request(
        ApiEndpoints.booking(bookingId),
        method: 'PUT',
        token: accessToken,
        body: body,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        // Check if it's an error response
        if (response.containsKey('error')) {
          return CustomerApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to update booking',
          );
        }

        // Parse booking response
        final booking = Booking.fromJson(response);
        return CustomerApiResponse(
          success: true,
          data: booking,
          message: 'Booking updated successfully',
        );
      }

      return CustomerApiResponse(
        success: false,
        error: 'Failed to update booking',
      );
    } catch (e) {
      return CustomerApiResponse(success: false, error: e.toString());
    }
  }

  /// Cancel a booking
  /// DELETE /api/v1/bookings/:id
  Future<CustomerApiResponse<void>> cancelBooking({
    required String bookingId,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.booking(bookingId),
        method: 'DELETE',
        token: accessToken,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        // Check if it's an error response
        if (response.containsKey('error')) {
          return CustomerApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to cancel booking',
          );
        }

        return CustomerApiResponse(
          success: true,
          message: response['message'] ?? 'Booking cancelled successfully',
        );
      }

      return CustomerApiResponse(
        success: false,
        error: 'Failed to cancel booking',
      );
    } catch (e) {
      return CustomerApiResponse(success: false, error: e.toString());
    }
  }
}
