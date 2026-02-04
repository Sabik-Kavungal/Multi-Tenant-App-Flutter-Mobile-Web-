import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/features/auth/services/auth_api_service.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';
import 'package:saasf/features/auth/views/login_page.dart';
import 'package:saasf/features/auth/views/splash_page.dart';
import 'package:saasf/features/auth/views/register_page.dart';
import 'package:saasf/features/auth/views/change_password_page.dart';

/// Auth Module
/// Provides AuthViewModel and Auth-related routes
/// 
/// API Endpoints:
/// - POST /api/v1/auth/register - Register new user
/// - POST /api/v1/auth/login - Login user
/// - POST /api/v1/auth/refresh - Refresh token
/// - POST /api/v1/auth/logout - Logout user
/// - GET /api/v1/auth/me - Get current user
/// - POST /api/v1/auth/change-password - Change password
class AuthModule {
  /// Get Auth providers
  static List<ChangeNotifierProvider> getProviders() {
    final authApiService = AuthApiService();
    final authVm = AuthViewModel(authApiService);

    return [ChangeNotifierProvider<AuthViewModel>.value(value: authVm)];
  }

  /// Get Auth routes
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/splash': (context) => const SplashPage(),
      '/login': (context) => const LoginPage(),
      '/register': (context) => const RegisterPage(),
      '/change-password': (context) => const ChangePasswordPage(),
    };
  }
}
