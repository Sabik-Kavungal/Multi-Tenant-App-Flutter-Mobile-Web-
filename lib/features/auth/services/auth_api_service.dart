import 'package:saasf/core/api/api_service.dart';
import 'package:saasf/core/api/api_endpoints.dart';
import 'package:saasf/features/auth/models/user_model.dart';
import 'package:saasf/features/auth/models/token_model.dart';
import 'package:saasf/features/auth/models/auth_response_model.dart';
import 'package:flutter/material.dart';

/// Auth API Service
/// Handles all authentication-related API calls
/// Implements full Auth Service API:
/// - Register, Login, Refresh Token, Logout
/// - Get Current User, Change Password
class AuthApiService {
  final ApiService _apiService = ApiService();

  /// Health Check - Check if auth service is running
  /// GET /api/v1/health
  Future<bool> healthCheck() async {
    final response = await _apiService.request(
      ApiEndpoints.health,
      method: 'GET',
    );
    return response != null && response['status'] == 'healthy';
  }

  /// Register a new CUSTOMER user
  /// POST /api/v1/auth/register
  /// Only CUSTOMER role allowed for self-registration
  /// Super Admin, Admin, Staff accounts are created by administrators
  /// Returns User and Token on success
  Future<AuthResponse> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String role, // Should always be 'CUSTOMER' for self-registration
    BuildContext? context,
  }) async {
    final body = <String, dynamic>{
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'role': role, // CUSTOMER for self-registration
    };

    final response = await _apiService.request(
      ApiEndpoints.register,
      method: 'POST',
      body: body,
      context: context,
    );

    print('========== REGISTER API RESPONSE ==========');
    print('Full Response: $response');
    print('==========================================');

    if (response != null) {
      // Check for error response
      if (response['error'] != null) {
        return AuthResponse(
          success: false,
          error: response['message'] as String? ?? 'Registration failed',
          errorCode: response['error'] as String?,
        );
      }

      try {
        // Success response includes user and tokens
        final user = User.fromJson(response['user']);
        final token = Token.fromJson(response);
        final message = response['message'] as String?;

        print('User registered: ${user.email}, Role: ${user.role}');
        return AuthResponse(
          success: true,
          user: user,
          token: token,
          message: message,
        );
      } catch (e) {
        print('ERROR parsing register response: $e');
        return AuthResponse(
          success: false,
          error: 'Failed to parse response: $e',
        );
      }
    }

    return AuthResponse(
      success: false,
      error: 'Registration failed',
    );
  }

  /// Login with email and password
  /// POST /api/v1/auth/login
  /// Returns User and Token on success
  Future<AuthResponse> login({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    final response = await _apiService.request(
      ApiEndpoints.login,
      method: 'POST',
      body: {'email': email, 'password': password},
      context: context,
    );

    print('========== LOGIN API RESPONSE ==========');
    print('Full Response: $response');
    if (response != null) {
      print('Response Keys: ${response.keys}');
    }
    print('========================================');

    if (response != null) {
      // Check for error response
      if (response['error'] != null) {
        return AuthResponse(
          success: false,
          error: response['message'] as String? ?? 'Login failed',
          errorCode: response['error'] as String?,
        );
      }

      try {
        // API returns: success, message, access_token, refresh_token, token_type, expires_in, user
        final user = User.fromJson(response['user']);
        final token = Token.fromJson(response);
        final message = response['message'] as String?;

        print('User logged in: ${user.email}, Role: ${user.role}');
        print('Token expires_in: ${token.expiresIn} seconds');

        return AuthResponse(
          success: true,
          user: user,
          token: token,
          message: message,
        );
      } catch (e) {
        print('ERROR parsing login response: $e');
        return AuthResponse(
          success: false,
          error: 'Failed to parse response: $e',
        );
      }
    }

    return AuthResponse(
      success: false,
      error: 'Login failed',
    );
  }

  /// Refresh access token using refresh token
  /// POST /api/v1/auth/refresh
  /// Returns new Token on success
  Future<AuthResponse> refreshToken(String refreshToken) async {
    final response = await _apiService.request(
      ApiEndpoints.refreshToken,
      method: 'POST',
      body: {'refresh_token': refreshToken},
    );

    print('========== REFRESH TOKEN RESPONSE ==========');
    print('Full Response: $response');
    print('============================================');

    if (response != null) {
      // Check for error response
      if (response['error'] != null) {
        return AuthResponse(
          success: false,
          error: response['message'] as String? ?? 'Token refresh failed',
          errorCode: response['error'] as String?,
        );
      }

      try {
        // Refresh response includes new tokens and user info
        final token = Token.fromJson(response);
        User? user;
        if (response['user'] != null) {
          user = User.fromJson(response['user']);
        }
        final message = response['message'] as String?;

        return AuthResponse(
          success: true,
          token: token,
          user: user,
          message: message,
        );
      } catch (e) {
        print('ERROR parsing refresh response: $e');
        return AuthResponse(
          success: false,
          error: 'Failed to parse response: $e',
        );
      }
    }

    return AuthResponse(
      success: false,
      error: 'Token refresh failed',
    );
  }

  /// Logout - invalidate tokens on server
  /// POST /api/v1/auth/logout
  /// Requires access token in header
  Future<AuthResponse> logout(
    String accessToken, {
    BuildContext? context,
  }) async {
    final response = await _apiService.request(
      ApiEndpoints.logout,
      method: 'POST',
      token: accessToken,
      context: context,
    );

    print('========== LOGOUT RESPONSE ==========');
    print('Full Response: $response');
    print('=====================================');

    if (response != null) {
      if (response['error'] != null) {
        return AuthResponse(
          success: false,
          error: response['message'] as String? ?? 'Logout failed',
          errorCode: response['error'] as String?,
        );
      }
      return AuthResponse(
        success: true,
        message: response['message'] as String?,
      );
    }

    // Even if response is null, consider logout successful locally
    return AuthResponse(
      success: true,
      message: 'Logged out',
    );
  }

  /// Get current user info
  /// GET /api/v1/auth/me
  /// Requires access token
  Future<AuthResponse> getCurrentUser({
    required String accessToken,
    BuildContext? context,
  }) async {
    final response = await _apiService.request(
      ApiEndpoints.me,
      method: 'GET',
      token: accessToken,
      context: context,
    );

    print('========== GET ME RESPONSE ==========');
    print('Full Response: $response');
    print('=====================================');

    if (response != null) {
      if (response['error'] != null) {
        return AuthResponse(
          success: false,
          error: response['message'] as String? ?? 'Failed to get user',
          errorCode: response['error'] as String?,
        );
      }

      try {
        final user = User.fromJson(response);
        return AuthResponse(
          success: true,
          user: user,
        );
      } catch (e) {
        print('ERROR parsing user response: $e');
        return AuthResponse(
          success: false,
          error: 'Failed to parse user: $e',
        );
      }
    }

    return AuthResponse(
      success: false,
      error: 'Failed to get user',
    );
  }

  /// Change password
  /// POST /api/v1/auth/change-password
  /// Requires access token
  /// Note: After password change, all sessions are revoked. User must login again.
  Future<AuthResponse> changePassword({
    required String accessToken,
    required String currentPassword,
    required String newPassword,
    BuildContext? context,
  }) async {
    final response = await _apiService.request(
      ApiEndpoints.changePassword,
      method: 'POST',
      token: accessToken,
      body: {'current_password': currentPassword, 'new_password': newPassword},
      context: context,
    );

    print('========== CHANGE PASSWORD RESPONSE ==========');
    print('Full Response: $response');
    print('==============================================');

    if (response != null) {
      if (response['error'] != null) {
        return AuthResponse(
          success: false,
          error: response['message'] as String? ?? 'Password change failed',
          errorCode: response['error'] as String?,
        );
      }
      return AuthResponse(
        success: true,
        message:
            response['message'] as String? ?? 'Password changed successfully',
      );
    }

    return AuthResponse(
      success: false,
      error: 'Password change failed',
    );
  }
}
