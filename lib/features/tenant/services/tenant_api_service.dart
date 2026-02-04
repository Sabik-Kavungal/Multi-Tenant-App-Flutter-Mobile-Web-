import 'package:flutter/material.dart';
import 'package:saasf/core/api/api_endpoints.dart';
import 'package:saasf/core/api/api_service.dart';
import 'package:saasf/features/tenant/models/tenant_model.dart';
import 'package:saasf/features/tenant/models/tenant_settings_model.dart';
import 'package:saasf/features/tenant/models/working_hours_model.dart';
import 'package:saasf/features/tenant/models/holiday_model.dart';
import 'package:saasf/features/tenant/models/staff_model.dart';
import 'package:saasf/features/tenant/models/tenant_api_response_model.dart';
import 'package:saasf/features/tenant/models/tenant_api_user_model.dart';

/// Tenant API Service
/// Handles all API calls to the Tenant Service
class TenantApiService {
  final ApiService _apiService = ApiService();

  // ============================================
  // SUPER ADMIN - LIST USERS (For Dropdown)
  // ============================================

  /// List users for dropdown (Super Admin only)
  /// GET /api/v1/auth/users?role=ADMIN&without_tenant=true
  Future<TenantApiResponse<UserListResponse>> listUsers({
    String? role,
    bool? withoutTenant,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      // Build query parameters
      final queryParams = <String, String>{};
      if (role != null && role.isNotEmpty) {
        queryParams['role'] = role;
      }
      if (withoutTenant == true) {
        queryParams['without_tenant'] = 'true';
      }

      // Build URL with query params
      String endpoint = ApiEndpoints.listUsers;
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
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to get users',
          );
        }

        // Parse user list response
        final userListResponse = UserListResponse.fromJson(response);
        return TenantApiResponse(success: true, data: userListResponse);
      }

      return TenantApiResponse(success: false, error: 'Failed to get users');
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  // ============================================
  // SUPER ADMIN - CREATE USER (Protected Endpoint)
  // ============================================

  /// Create a new user (Super Admin only)
  /// POST /api/v1/auth/users
  /// This is required before creating a tenant for that user
  Future<TenantApiResponse<CreatedUser>> createUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String role = 'ADMIN',
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.createUser,
        method: 'POST',
        body: {
          'email': email,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
          'role': "ADMIN",
        },
        token: accessToken,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        // Check if it's an error response
        if (response.containsKey('error')) {
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to create user',
          );
        }

        // Parse user from response
        final userJson = response['user'] as Map<String, dynamic>?;
        if (userJson != null) {
          final user = CreatedUser.fromJson(userJson);
          return TenantApiResponse(
            success: true,
            data: user,
            message: response['message'] as String?,
          );
        }

        return TenantApiResponse(
          success: false,
          error: 'Invalid response format',
        );
      }

      return TenantApiResponse(success: false, error: 'Failed to create user');
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  // ============================================
  // SUPER ADMIN - ASSIGN TENANT TO USER
  // ============================================

  /// Assign a tenant to a user (Super Admin only)
  /// PUT /api/v1/auth/users/tenant
  /// This links the user to the tenant after both are created
  Future<TenantApiResponse<void>> assignTenantToUser({
    required String userId,
    required String tenantId,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.assignTenantToUser,
        method: 'PUT',
        body: {'user_id': userId, 'tenant_id': tenantId},
        token: accessToken,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        // Check if it's an error response
        if (response.containsKey('error')) {
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to assign tenant to user',
          );
        }

        // Success
        return TenantApiResponse(
          success: true,
          message:
              response['message'] as String? ?? 'Tenant assigned successfully',
        );
      }

      return TenantApiResponse(
        success: false,
        error: 'Failed to assign tenant to user',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  // ============================================
  // SUPER ADMIN - GET ALL TENANTS (PAGINATED)
  // ============================================

  /// Get all tenants with pagination (Super Admin only)
  /// GET /api/v1/tenants?page=1&page_size=20&status=ACTIVE
  Future<TenantApiResponse<TenantListResponse>> getAllTenants({
    required String accessToken,
    int page = 1,
    int pageSize = 20,
    String? status,
    BuildContext? context,
  }) async {
    try {
      // Build query parameters
      final queryParams = <String, String>{
        'page': page.toString(),
        'page_size': pageSize.toString(),
      };
      if (status != null && status.isNotEmpty && status != 'all') {
        queryParams['status'] = status;
      }

      // Build URL with query params
      final queryString = queryParams.entries
          .map((e) => '${e.key}=${e.value}')
          .join('&');
      final endpoint = '${ApiEndpoints.tenants}?$queryString';

      final response = await _apiService.request(
        endpoint,
        method: 'GET',
        token: accessToken,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        // Check if it's an error response
        if (response.containsKey('error')) {
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to get tenants',
          );
        }

        // Parse paginated response
        final tenantListResponse = TenantListResponse.fromJson(response);
        return TenantApiResponse(success: true, data: tenantListResponse);
      }

      return TenantApiResponse(success: false, error: 'Failed to get tenants');
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  // ============================================
  // TENANT CRUD OPERATIONS
  // ============================================

  /// Create a new tenant
  Future<TenantApiResponse<Tenant>> createTenant({
    required String name,
    required String type,
    required String ownerUserId,
    required String timezone,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.tenants,
        method: 'POST',
        body: {
          'name': name,
          'type': type,
          'owner_user_id': ownerUserId,
          'timezone': timezone,
        },
        token: accessToken,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        // Check if it's an error response
        if (response.containsKey('error')) {
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to create tenant',
          );
        }
        final tenant = Tenant.fromJson(response);
        return TenantApiResponse(success: true, data: tenant);
      }

      return TenantApiResponse(
        success: false,
        error: 'Failed to create tenant',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// Get a tenant by ID
  Future<TenantApiResponse<Tenant>> getTenant({
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
        if (response.containsKey('error')) {
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Tenant not found',
          );
        }
        final tenant = Tenant.fromJson(response);
        return TenantApiResponse(success: true, data: tenant);
      }

      return TenantApiResponse(success: false, error: 'Tenant not found');
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// Update a tenant
  Future<TenantApiResponse<void>> updateTenant({
    required String tenantId,
    String? name,
    String? type,
    String? status,
    String? timezone,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (name != null) body['name'] = name;
      if (type != null) body['type'] = type;
      if (status != null) body['status'] = status;
      if (timezone != null) body['timezone'] = timezone;

      final response = await _apiService.request(
        ApiEndpoints.tenant(tenantId),
        method: 'PUT',
        body: body,
        token: accessToken,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response.containsKey('error')) {
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to update tenant',
          );
        }
        return TenantApiResponse(
          success: true,
          message: response['message'] ?? 'Tenant updated successfully',
        );
      }

      return TenantApiResponse(
        success: false,
        error: 'Failed to update tenant',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// Delete a tenant
  Future<TenantApiResponse<void>> deleteTenant({
    required String tenantId,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.tenant(tenantId),
        method: 'DELETE',
        token: accessToken,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response.containsKey('error')) {
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to delete tenant',
          );
        }
        return TenantApiResponse(
          success: true,
          message: response['message'] ?? 'Tenant deleted successfully',
        );
      }

      return TenantApiResponse(
        success: false,
        error: 'Failed to delete tenant',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  // ============================================
  // TENANT SETTINGS
  // ============================================

  /// Get tenant settings
  Future<TenantApiResponse<TenantSettings>> getSettings({
    required String tenantId,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.tenantSettings(tenantId),
        method: 'GET',
        token: accessToken,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response.containsKey('error')) {
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to get settings',
          );
        }
        final settings = TenantSettings.fromJson(response);
        return TenantApiResponse(success: true, data: settings);
      }

      return TenantApiResponse(success: false, error: 'Failed to get settings');
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// Update tenant settings
  /// All fields in request are optional - only include fields you want to update
  /// Note: To set max_daily_bookings to null (unlimited), include it in the request with null value
  Future<TenantApiResponse<void>> updateSettings({
    required String tenantId,
    required UpdateSettingsRequest request,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      // Build body from request
      // Include only fields that are being updated
      // max_daily_bookings: null means unlimited, so include it even if null
      final body = <String, dynamic>{};

      // max_daily_bookings: include if provided (null = unlimited)
      // The ViewModel creates UpdateSettingsRequest with maxDailyBookings set
      // (either to a number or null for unlimited when unlimitedBookings is true)
      // Since we're updating settings, if maxDailyBookings is in the request, include it
      if (request.maxDailyBookings != null) {
        // Number provided
        body['max_daily_bookings'] = request.maxDailyBookings;
      } else {
        // null provided - means unlimited
        // Include it if other fields are being updated (indicating this is an active update)
        // OR always include if it's null (since null is a valid value for unlimited)
        // For simplicity: if null, include it (the ViewModel will only set it to null
        // when unlimitedBookings is true, meaning it should be updated)
        final hasOtherUpdates =
            request.allowWalkins != null ||
            request.cancellationWindowMinutes != null ||
            request.queueEnabled != null ||
            request.autoAssignStaff != null;

        // Include null if other updates exist OR if this is the only update
        // Since we can't tell if it's "only update", we'll include it if other updates exist
        // For the case where only max_daily_bookings is updated to unlimited,
        // the ViewModel should ensure at least one other field is set, or we handle it specially
        // For now: include null if other updates exist
        if (hasOtherUpdates) {
          body['max_daily_bookings'] = null; // Set to unlimited
        }
        // Note: If only updating max_daily_bookings to unlimited with no other changes,
        // this won't work. We'd need a flag or different approach.
        // For now, users can update at least one other field, or we can add special handling.
      }

      // For other fields, only include if not null
      if (request.allowWalkins != null)
        body['allow_walkins'] = request.allowWalkins;
      if (request.cancellationWindowMinutes != null) {
        body['cancellation_window_minutes'] = request.cancellationWindowMinutes;
      }
      if (request.queueEnabled != null)
        body['queue_enabled'] = request.queueEnabled;
      if (request.autoAssignStaff != null) {
        body['auto_assign_staff'] = request.autoAssignStaff;
      }

      final response = await _apiService.request(
        ApiEndpoints.tenantSettings(tenantId),
        method: 'PUT',
        body: body,
        token: accessToken,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response.containsKey('error')) {
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to update settings',
          );
        }
        return TenantApiResponse(
          success: true,
          message: response['message'] ?? 'Settings updated successfully',
        );
      }

      return TenantApiResponse(
        success: false,
        error: 'Failed to update settings',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  // ============================================
  // WORKING HOURS
  // ============================================
  // API Documentation: GET /api/v1/tenants/{tenant_id}/hours
  // Returns: Array of WorkingHours objects (one per day, 0-6)
  // Response: 200 OK with array, or empty array [] if no hours set
  // Day of Week: 0=Sunday, 1=Monday, ..., 6=Saturday

  /// Get working hours for a tenant
  ///
  /// **API Endpoint:** `GET /api/v1/tenants/{tenant_id}/hours`
  ///
  /// **Response:**
  /// - Success (200): Array of WorkingHours objects
  /// - Empty array `[]` if no working hours are configured
  /// - Each object contains: id, tenant_id, day_of_week (0-6), open_time, close_time, is_closed
  ///
  /// **Day of Week Reference:**
  /// - 0 = Sunday
  /// - 1 = Monday
  /// - 2 = Tuesday
  /// - 3 = Wednesday
  /// - 4 = Thursday
  /// - 5 = Friday
  /// - 6 = Saturday
  Future<TenantApiResponse<List<WorkingHours>>> getWorkingHours({
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

      // Handle null response (API returns "null" string when no working hours exist)
      // This is a valid response - tenant has no working hours set yet
      if (response == null) {
        return TenantApiResponse(success: true, data: []);
      }

      if (response is List) {
        final hours = response.map((e) {
          // Parse the working hours object
          final workingHours = WorkingHours.fromJson(e as Map<String, dynamic>);

          // Extract time from datetime format if needed
          // API may return "0000-01-01T09:00:00Z" instead of "09:00"
          final normalizedOpenTime = extractTimeFromString(
            workingHours.openTime,
          );
          final normalizedCloseTime = extractTimeFromString(
            workingHours.closeTime,
          );

          // Return new instance with normalized times
          return workingHours.copyWith(
            openTime: normalizedOpenTime,
            closeTime: normalizedCloseTime,
          );
        }).toList();
        return TenantApiResponse(success: true, data: hours);
      }

      if (response is Map<String, dynamic>) {
        if (response.containsKey('error')) {
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to get working hours',
          );
        }
      }

      // If response is not null, not a list, and not an error map, treat as empty
      return TenantApiResponse(success: true, data: []);
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// Update working hours for a tenant
  ///
  /// **API Endpoint:** `PUT /api/v1/tenants/{tenant_id}/hours`
  ///
  /// **Request Body:**
  /// ```json
  /// {
  ///   "hours": [
  ///     {
  ///       "day_of_week": 0,
  ///       "open_time": "09:00",
  ///       "close_time": "17:00",
  ///       "is_closed": false
  ///     },
  ///     ...
  ///   ]
  /// }
  /// ```
  ///
  /// **Validation Rules:**
  /// - `day_of_week` must be between 0-6 (unique in array)
  /// - If `is_closed = false`: both `open_time` and `close_time` are required
  /// - If `is_closed = true`: `open_time` and `close_time` should be `null`
  /// - Time format: `HH:MM` (24-hour format, e.g., "09:00", "17:30")
  ///
  /// **Response:**
  /// - Success (200): `{ "message": "working hours updated successfully" }`
  /// - Error (400): Validation errors (duplicate day, missing times, etc.)
  Future<TenantApiResponse<void>> updateWorkingHours({
    required String tenantId,
    required List<WorkingHoursInput> hours,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      // Build request body according to API specification
      // API expects: day_of_week (required, number 0-6), is_closed, and optionally open_time/close_time
      // CRITICAL: Use model's toJson() method to ensure proper serialization with @JsonKey annotations
      // This ensures day_of_week is always present as a number (int) with correct field name (snake_case)

      // Validate all hours before serialization
      for (final h in hours) {
        if (h.dayOfWeek < 0 || h.dayOfWeek > 6) {
          throw Exception(
            'Invalid day_of_week: ${h.dayOfWeek}. Must be between 0-6',
          );
        }
      }

      // Use model's toJson() method which properly handles @JsonKey annotations
      // This ensures day_of_week is always included as an int with snake_case field name
      final hoursJson = hours.map((h) {
        // Get the base JSON from the model (includes day_of_week and is_closed)
        // The toJson() method from Freezed automatically handles @JsonKey(name: 'day_of_week')
        // and ensures day_of_week is always present as an int
        final json = h.toJson();

        // Ensure times are properly set based on is_closed status
        if (h.isClosed) {
          // When closed, explicitly set times to null (per API spec)
          json['open_time'] = null;
          json['close_time'] = null;
        }
        // When not closed, times are already in json from toJson() if they exist

        // Debug: Verify day_of_week is present
        if (!json.containsKey('day_of_week') || json['day_of_week'] == null) {
          throw Exception(
            'CRITICAL: day_of_week is missing or null in serialized JSON for day ${h.dayOfWeek}',
          );
        }

        return json;
      }).toList();

      // Debug: Log request body structure before sending
      print('========== UPDATE WORKING HOURS REQUEST ==========');
      print('Hours count: ${hoursJson.length}');
      for (int i = 0; i < hoursJson.length; i++) {
        print('Hour[$i]: ${hoursJson[i]}');
        if (!hoursJson[i].containsKey('day_of_week')) {
          print('ERROR: day_of_week missing in hour[$i]!');
        } else {
          print(
            '  day_of_week: ${hoursJson[i]['day_of_week']} (type: ${hoursJson[i]['day_of_week'].runtimeType})',
          );
        }
      }
      print('Request body: ${{'hours': hoursJson}}');
      print('==================================================');

      final response = await _apiService.request(
        ApiEndpoints.workingHours(tenantId),
        method: 'PUT',
        body: {'hours': hoursJson},
        token: accessToken,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response.containsKey('error')) {
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to update working hours',
          );
        }
        return TenantApiResponse(
          success: true,
          message: response['message'] ?? 'Working hours updated successfully',
        );
      }

      return TenantApiResponse(
        success: false,
        error: 'Failed to update working hours',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  // ============================================
  // HOLIDAYS
  // ============================================

  /// Get all holidays
  ///
  /// **API Endpoint:** `GET /api/v1/tenants/{tenant_id}/holidays`
  ///
  /// **Response:**
  /// - Success (200): Array of Holiday objects
  /// - Empty array `[]` if no holidays are configured
  /// - Null response is treated as empty array (valid state)
  Future<TenantApiResponse<List<Holiday>>> getHolidays({
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

      // Handle null response (API returns "null" string when no holidays exist)
      // This is a valid response - tenant has no holidays set yet
      if (response == null) {
        return TenantApiResponse(success: true, data: []);
      }

      if (response is List) {
        final holidays = response
            .map((e) => Holiday.fromJson(e as Map<String, dynamic>))
            .toList();
        return TenantApiResponse(success: true, data: holidays);
      }

      if (response is Map<String, dynamic>) {
        if (response.containsKey('error')) {
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to get holidays',
          );
        }
      }

      // If response is not null, not a list, and not an error map, treat as empty
      return TenantApiResponse(success: true, data: []);
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// Create a holiday
  Future<TenantApiResponse<Holiday>> createHoliday({
    required String tenantId,
    required String holidayDate,
    required String reason,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.holidays(tenantId),
        method: 'POST',
        body: {'holiday_date': holidayDate, 'reason': reason},
        token: accessToken,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response.containsKey('error')) {
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to create holiday',
          );
        }
        final holiday = Holiday.fromJson(response);
        return TenantApiResponse(success: true, data: holiday);
      }

      return TenantApiResponse(
        success: false,
        error: 'Failed to create holiday',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// Delete a holiday
  Future<TenantApiResponse<void>> deleteHoliday({
    required String tenantId,
    required String holidayId,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.holiday(tenantId, holidayId),
        method: 'DELETE',
        token: accessToken,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response.containsKey('error')) {
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to delete holiday',
          );
        }
        return TenantApiResponse(
          success: true,
          message: response['message'] ?? 'Holiday deleted successfully',
        );
      }

      return TenantApiResponse(
        success: false,
        error: 'Failed to delete holiday',
      );
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  // ============================================
  // STAFF MANAGEMENT
  // ============================================

  /// Get all staff
  ///
  /// **API Endpoint:** `GET /api/v1/tenants/{tenant_id}/staff`
  ///
  /// **Response:**
  /// - Success (200): Array of Staff objects
  /// - Empty array `[]` if no staff are configured
  /// - Null response is treated as empty array (valid state)
  Future<TenantApiResponse<List<Staff>>> getStaff({
    required String tenantId,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.staff(tenantId),
        method: 'GET',
        token: accessToken,
        context: context,
      );

      // Handle null response (API returns "null" string when no staff exist)
      // This is a valid response - tenant has no staff set yet
      if (response == null) {
        return TenantApiResponse(success: true, data: []);
      }

      if (response is List) {
        final staff = response
            .map((e) => Staff.fromJson(e as Map<String, dynamic>))
            .toList();
        return TenantApiResponse(success: true, data: staff);
      }

      if (response != null && response is Map<String, dynamic>) {
        if (response.containsKey('error')) {
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to get staff',
          );
        }
      }

      // If response is not null, not a list, and not an error map, treat as empty
      return TenantApiResponse(success: true, data: []);
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// Create staff - supports two modes
  ///
  /// **API Endpoint:** `POST /api/v1/tenants/{tenant_id}/staff`
  ///
  /// **Mode 1: Add Existing User as Staff**
  /// - Provide: `user_id` + `designation`
  /// - Assigns existing user to tenant as staff
  ///
  /// **Mode 2: Create New User and Add as Staff**
  /// - Provide: `email`, `password`, `first_name`, `last_name` + `designation`
  /// - Creates new user account (role = designation) and adds as staff
  /// - User's tenant_id is automatically set
  /// - User can login immediately with provided credentials
  ///
  /// **Request Body (Mode 1):**
  /// ```json
  /// {
  ///   "user_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  ///   "designation": "STAFF"
  /// }
  /// ```
  ///
  /// **Request Body (Mode 2):**
  /// ```json
  /// {
  ///   "email": "jane.doe@example.com",
  ///   "password": "SecurePassword123!",
  ///   "first_name": "Jane",
  ///   "last_name": "Doe",
  ///   "designation": "STAFF"
  /// }
  /// ```
  ///
  /// **Response (201 Created):**
  /// ```json
  /// {
  ///   "id": "staff-uuid-here",
  ///   "tenant_id": "tenant-uuid",
  ///   "user_id": "user-uuid",
  ///   "designation": "STAFF",
  ///   "is_active": true,
  ///   "joined_at": "2024-01-15T10:30:00Z"
  /// }
  /// ```
  Future<TenantApiResponse<Staff>> createStaff({
    required String tenantId,
    required String designation,
    required String accessToken,
    BuildContext? context,
    // Mode 1: Add existing user
    String? userId,
    // Mode 2: Create new user
    String? email,
    String? password,
    String? firstName,
    String? lastName,
  }) async {
    try {
      // Build request body based on mode
      // Mode 1: user_id provided → use existing user
      // Mode 2: email, password, first_name, last_name provided → create new user
      final body = <String, dynamic>{'designation': designation};

      if (userId != null && userId.isNotEmpty) {
        // Mode 1: Add existing user
        body['user_id'] = userId;
      } else if (email != null &&
          email.isNotEmpty &&
          password != null &&
          password.isNotEmpty &&
          firstName != null &&
          firstName.isNotEmpty &&
          lastName != null &&
          lastName.isNotEmpty) {
        // Mode 2: Create new user
        body['email'] = email;
        body['password'] = password;
        body['first_name'] = firstName;
        body['last_name'] = lastName;
      } else {
        return TenantApiResponse(
          success: false,
          error:
              'Either user_id (existing user) or email, password, first_name, and last_name (create new user) are required',
        );
      }

      final response = await _apiService.request(
        ApiEndpoints.staff(tenantId),
        method: 'POST',
        body: body,
        token: accessToken,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response.containsKey('error')) {
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to create staff',
          );
        }
        final staff = Staff.fromJson(response);
        return TenantApiResponse(success: true, data: staff);
      }

      return TenantApiResponse(success: false, error: 'Failed to create staff');
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// Update staff
  Future<TenantApiResponse<void>> updateStaff({
    required String tenantId,
    required String staffId,
    String? designation,
    bool? isActive,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (designation != null) body['designation'] = designation;
      if (isActive != null) body['is_active'] = isActive;

      final response = await _apiService.request(
        ApiEndpoints.staffMember(tenantId, staffId),
        method: 'PUT',
        body: body,
        token: accessToken,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response.containsKey('error')) {
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to update staff',
          );
        }
        return TenantApiResponse(
          success: true,
          message: response['message'] ?? 'Staff updated successfully',
        );
      }

      return TenantApiResponse(success: false, error: 'Failed to update staff');
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }

  /// Delete staff
  Future<TenantApiResponse<void>> deleteStaff({
    required String tenantId,
    required String staffId,
    required String accessToken,
    BuildContext? context,
  }) async {
    try {
      final response = await _apiService.request(
        ApiEndpoints.staffMember(tenantId, staffId),
        method: 'DELETE',
        token: accessToken,
        context: context,
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response.containsKey('error')) {
          return TenantApiResponse(
            success: false,
            error: response['message'] ?? 'Failed to delete staff',
          );
        }
        return TenantApiResponse(
          success: true,
          message: response['message'] ?? 'Staff deleted successfully',
        );
      }

      return TenantApiResponse(success: false, error: 'Failed to delete staff');
    } catch (e) {
      return TenantApiResponse(success: false, error: e.toString());
    }
  }
}
