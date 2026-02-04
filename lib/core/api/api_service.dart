import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:saasf/core/api/api_endpoints.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';

/// Simple API Service Repository
/// Handles all HTTP requests with token refresh logic
/// Similar to working ServiceRepo pattern
class ApiService {
  final String baseUrl = ApiEndpoints.baseUrl;

  /// Main request method - handles all HTTP methods
  /// Returns parsed JSON response or null on error
  /// [extraHeaders] e.g. {'X-Tenant-ID': tenantId} for Catalog Service
  Future<dynamic> request(
    String endpoint, {
    required String method,
    Map<String, dynamic>? body,
    String? token,
    BuildContext? context, // For token refresh
    Map<String, String>? extraHeaders,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');

    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    if (extraHeaders != null) headers.addAll(extraHeaders);

    try {
      http.Response response;

      switch (method.toUpperCase()) {
        case 'POST':
          response = await http
              .post(
                url,
                headers: headers,
                body: body != null ? jsonEncode(body) : null,
              )
              .timeout(const Duration(seconds: 15));
          break;
        case 'GET':
          response = await http
              .get(url, headers: headers)
              .timeout(const Duration(seconds: 15));
          break;
        case 'PUT':
          response = await http
              .put(
                url,
                headers: headers,
                body: body != null ? jsonEncode(body) : null,
              )
              .timeout(const Duration(seconds: 15));
          break;
        case 'PATCH':
          response = await http
              .patch(
                url,
                headers: headers,
                body: body != null ? jsonEncode(body) : null,
              )
              .timeout(const Duration(seconds: 15));
          break;
        case 'DELETE':
          response = await http
              .delete(url, headers: headers)
              .timeout(const Duration(seconds: 15));
          break;
        default:
          throw Exception("Unsupported HTTP method: $method");
      }

      // Handle successful responses (2xx) and partial content (207)
      if ((response.statusCode >= 200 && response.statusCode < 300) ||
          response.statusCode == 207) {
        // Print raw response for debugging
        print('========== API RESPONSE ==========');
        print('Status Code: ${response.statusCode}');
        print('Headers: ${response.headers}');
        print('Response Body (Raw):');
        print(response.body);
        print('Response Body Length: ${response.body.length}');

        if (response.body.isNotEmpty) {
          // Handle case where API returns the string "null" (4 characters)
          // This is a valid JSON null value, not an error
          if (response.body.trim() == 'null') {
            print('Response body is JSON null (no data)');
            print('================================');
            return null;
          }

          try {
            final decoded = jsonDecode(response.body);
            print('Decoded JSON:');
            print(decoded);
            print('================================');
            return decoded;
          } catch (e) {
            print('ERROR decoding JSON: $e');
            print('Raw body: ${response.body}');
            print('================================');
            return null;
          }
        } else {
          print('Response body is empty');
          print('================================');
          return null;
        }
      } else if (response.statusCode == 401) {
        print('Unauthorized request (401): ${response.body}');

        // Try to refresh token if context is available and this is not a refresh request
        if (context != null && !endpoint.contains('refresh')) {
          print('Attempting to refresh token due to 401 error...');
          try {
            // Check if context is still mounted before using it
            // This prevents "Looking up a deactivated widget's ancestor" errors
            // Try to access Navigator to verify context is valid
            // Navigator.maybeOf will return null if context is deactivated
            final navigator = Navigator.maybeOf(context);
            if (navigator == null) {
              print(
                'Context is not valid (no Navigator), skipping token refresh',
              );
              return null;
            }

            // Try to get AuthViewModel - this will throw if context is deactivated
            AuthViewModel? authViewModel;
            try {
              authViewModel = Provider.of<AuthViewModel>(
                context,
                listen: false,
              );
            } catch (e) {
              // Context is deactivated, cannot access Provider
              print('Cannot access AuthViewModel: context is deactivated');
              return null;
            }

            final refreshed = await authViewModel.refreshToken();

            if (refreshed && authViewModel.token != null) {
              print('Token refreshed, retrying request...');
              // Retry the request with new token
              final newHeaders = <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer ${authViewModel.token!.accessToken}',
              };
              if (extraHeaders != null) newHeaders.addAll(extraHeaders);

              http.Response retryResponse;
              switch (method.toUpperCase()) {
                case 'POST':
                  retryResponse = await http
                      .post(
                        url,
                        headers: newHeaders,
                        body: body != null ? jsonEncode(body) : null,
                      )
                      .timeout(const Duration(seconds: 15));
                  break;
                case 'GET':
                  retryResponse = await http
                      .get(url, headers: newHeaders)
                      .timeout(const Duration(seconds: 15));
                  break;
                case 'PUT':
                  retryResponse = await http
                      .put(
                        url,
                        headers: newHeaders,
                        body: body != null ? jsonEncode(body) : null,
                      )
                      .timeout(const Duration(seconds: 15));
                  break;
                case 'PATCH':
                  retryResponse = await http
                      .patch(
                        url,
                        headers: newHeaders,
                        body: body != null ? jsonEncode(body) : null,
                      )
                      .timeout(const Duration(seconds: 15));
                  break;
                case 'DELETE':
                  retryResponse = await http
                      .delete(url, headers: newHeaders)
                      .timeout(const Duration(seconds: 15));
                  break;
                default:
                  return null;
              }

              if (retryResponse.statusCode >= 200 &&
                  retryResponse.statusCode < 300) {
                print('Request succeeded after token refresh');
                return retryResponse.body.isNotEmpty
                    ? jsonDecode(retryResponse.body)
                    : null;
              }
            }
          } catch (e) {
            // Context is deactivated or Provider lookup failed
            print('Token refresh failed: $e');
          }
        }

        return null;
      } else if (response.statusCode == 429) {
        // Handle 429 Too Many Requests - Rate limit exceeded
        print('Rate limit exceeded (429): ${response.body}');
        try {
          if (response.body.isNotEmpty) {
            final errorData = jsonDecode(response.body);
            final message =
                errorData['message'] as String? ??
                'API rate limit exceeded. Please try again later.';
            print('Rate limit error message: $message');
          }
        } catch (e) {
          print('Failed to parse 429 response body: $e');
        }
        return null;
      } else if (response.statusCode == 400) {
        // Handle 400 Bad Request - may contain useful error details
        print('Request failed with status 400: ${response.body}');
        try {
          if (response.body.isNotEmpty) {
            return jsonDecode(response.body);
          }
        } catch (e) {
          print('Failed to parse 400 response body: $e');
        }
        return null;
      } else if (response.statusCode == 500) {
        // Handle 500 Internal Server Error
        print('Request failed with status 500: ${response.body}');
        try {
          if (response.body.isNotEmpty) {
            return jsonDecode(response.body);
          }
        } catch (e) {
          print('Failed to parse 500 response body: $e');
        }
        return null;
      } else {
        print(
          'Request failed with status ${response.statusCode}: ${response.body}',
        );
        return null;
      }
    } catch (error, stack) {
      print('Request error: $error\n$stack');
      return null;
    }
  }
}
