import 'package:flutter/material.dart';
import 'package:saasf/core/storage/hive_service.dart';
import 'package:saasf/core/utils/validators.dart';
import 'package:saasf/core/constants/roles.dart';
import 'package:saasf/features/auth/models/user_model.dart';
import 'package:saasf/features/auth/models/token_model.dart';
import 'package:saasf/features/auth/services/auth_api_service.dart';

/// Auth ViewModel
/// STRICT MVVM: All business logic, state management, and navigation decisions here
/// UI only renders state - zero logic in widgets
///
/// Handles:
/// - Login, Register, Logout
/// - Token refresh
/// - Session management
/// - Change password
class AuthViewModel extends ChangeNotifier {
  final AuthApiService _authApiService;

  // Authenticated user state
  User? _user;
  Token? _token;

  // Login form state
  User _loginUser = const User();
  String _password = '';

  // Register form state
  User _registerUser = const User();
  String _registerPassword = '';
  String _confirmPassword = '';

  // Change password state
  String _currentPassword = '';
  String _newPassword = '';
  String _confirmNewPassword = '';

  // Forgot password state
  String _forgotPasswordEmail = '';
  bool _emailSent = false;

  // UI state
  bool _isLoading = false;
  String? _error;
  String? _successMessage;
  bool _obscurePassword = true;
  bool _obscureNewPassword = true;
  bool _showLoginSuccess = false;

  // Navigation callback - ViewModel decides navigation, UI executes
  Function(String route)? onNavigate;

  // BuildContext for API calls
  BuildContext? _context;

  AuthViewModel(this._authApiService);

  // ============================================
  // GETTERS - UI reads state through these
  // ============================================

  User? get user => _user;
  Token? get token => _token;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get successMessage => _successMessage;
  bool get obscurePassword => _obscurePassword;
  bool get obscureNewPassword => _obscureNewPassword;
  bool get isAuthenticated => _token != null && _user != null;
  bool get showLoginSuccess => _showLoginSuccess;

  // Login form getters
  User get loginUser => _loginUser;
  String get loginEmail => _loginUser.email ?? '';
  String get loginPassword => _password;

  // Register form getters
  User get registerUser => _registerUser;
  String get registerEmail => _registerUser.email ?? '';
  String get registerFirstName => _registerUser.firstName ?? '';
  String get registerLastName => _registerUser.lastName ?? '';
  String get registerPassword => _registerPassword;
  String get confirmPassword => _confirmPassword;

  // Change password getters
  String get currentPassword => _currentPassword;
  String get newPassword => _newPassword;
  String get confirmNewPassword => _confirmNewPassword;

  // Forgot password getters
  String get forgotPasswordEmail => _forgotPasswordEmail;
  bool get emailSent => _emailSent;
  String? get forgotPasswordEmailError => _validateForgotPasswordEmail();
  bool get isForgotPasswordFormValid => forgotPasswordEmailError == null;

  // Role helpers
  bool get isCustomer => Roles.isCustomer(_user?.role);
  bool get isStaff => Roles.isStaff(_user?.role);
  bool get isAdmin => Roles.isAdmin(_user?.role);
  bool get isSuperAdmin => Roles.isSuperAdmin(_user?.role);
  bool get hasAdminPrivileges => Roles.hasAdminPrivileges(_user?.role);
  String get roleDisplayName => Roles.getDisplayName(_user?.role);

  // Validation state
  String? get emailError => _validateEmail();
  String? get passwordError => _validatePassword();
  bool get isLoginFormValid => emailError == null && passwordError == null;

  String? get registerEmailError => _validateRegisterEmail();
  String? get registerPasswordError => _validateRegisterPassword();
  String? get confirmPasswordError => _validateConfirmPassword();
  String? get firstNameError => _validateFirstName();
  String? get lastNameError => _validateLastName();
  bool get isRegisterFormValid =>
      registerEmailError == null &&
      registerPasswordError == null &&
      confirmPasswordError == null &&
      firstNameError == null &&
      lastNameError == null;

  String? get currentPasswordError =>
      _currentPassword.isEmpty ? 'Current password is required' : null;
  String? get newPasswordError => _validateNewPassword();
  String? get confirmNewPasswordError => _validateConfirmNewPassword();
  bool get isChangePasswordFormValid =>
      currentPasswordError == null &&
      newPasswordError == null &&
      confirmNewPasswordError == null;

  // ============================================
  // FORM UPDATE METHODS
  // ============================================

  void setContext(BuildContext context) {
    _context = context;
  }

  // Login form updates
  void updateEmail(String value) {
    _loginUser = _loginUser.copyWith(email: value.trim());
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }

  // Register form updates
  void updateRegisterEmail(String value) {
    _registerUser = _registerUser.copyWith(email: value.trim());
    notifyListeners();
  }

  void updateRegisterFirstName(String value) {
    _registerUser = _registerUser.copyWith(firstName: value.trim());
    notifyListeners();
  }

  void updateRegisterLastName(String value) {
    _registerUser = _registerUser.copyWith(lastName: value.trim());
    notifyListeners();
  }

  void updateRegisterPassword(String value) {
    _registerPassword = value;
    notifyListeners();
  }

  void updateConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  // Change password updates
  void updateCurrentPassword(String value) {
    _currentPassword = value;
    notifyListeners();
  }

  void updateNewPassword(String value) {
    _newPassword = value;
    notifyListeners();
  }

  void updateConfirmNewPassword(String value) {
    _confirmNewPassword = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    _obscureNewPassword = !_obscureNewPassword;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearSuccess() {
    _successMessage = null;
    notifyListeners();
  }

  void clearLoginSuccess() {
    _showLoginSuccess = false;
    notifyListeners();
  }

  // Forgot password methods
  void updateForgotPasswordEmail(String value) {
    _forgotPasswordEmail = value.trim();
    notifyListeners();
  }

  void resetForgotPasswordForm() {
    _forgotPasswordEmail = '';
    _emailSent = false;
    _error = null;
    notifyListeners();
  }

  /// Handle forgot password request
  Future<void> handleForgotPassword() async {
    if (!isForgotPasswordFormValid) {
      _setError('Please enter a valid email');
      notifyListeners();
      return;
    }

    _setLoading(true);
    _setError(null);
    notifyListeners();

    try {
      final email = forgotPasswordEmail;
      if (email.isEmpty) {
        _setError('Email is required');
        _setLoading(false);
        notifyListeners();
        return;
      }

      // TODO: Replace with actual API call when endpoint is available
      // For now, simulate API call
      await Future.delayed(const Duration(seconds: 2));

      _emailSent = true;
      _setLoading(false);
      _setError(null);
      notifyListeners();
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      _setLoading(false);
      notifyListeners();
    }
  }

  // ============================================
  // AUTH ACTIONS
  // ============================================

  /// Login with email and password
  Future<void> handleLogin() async {
    if (!isLoginFormValid) {
      _setError('Please fix form errors');
      notifyListeners();
      return;
    }

    _setLoading(true);
    _setError(null);
    notifyListeners();

    try {
      final email = _loginUser.email ?? '';
      if (email.isEmpty) {
        _setError('Email is required');
        _setLoading(false);
        notifyListeners();
        return;
      }

      final response = await _authApiService.login(
        email: email,
        password: _password,
        context: _context,
      );

      if (response.success && response.user != null && response.token != null) {
        _user = response.user;
        _token = response.token;

        await _saveTokens(_token!);
        await _saveUser(_user!);

        _setLoading(false);
        _showLoginSuccess = true;
        notifyListeners();

        await Future.delayed(const Duration(milliseconds: 800));
        onNavigate?.call('/home');
      } else {
        _setError(response.error ?? 'Login failed');
        _setLoading(false);
        notifyListeners();
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      _setLoading(false);
      notifyListeners();
    }
  }

  /// Register new user as CUSTOMER
  /// Only CUSTOMER role is allowed for self-registration
  /// Super Admin, Admin, and Staff are created by administrators
  Future<void> handleRegister() async {
    if (!isRegisterFormValid) {
      _setError('Please fix form errors');
      notifyListeners();
      return;
    }

    _setLoading(true);
    _setError(null);
    notifyListeners();

    try {
      // Always register as CUSTOMER - other roles created by admin
      final response = await _authApiService.register(
        email: _registerUser.email ?? '',
        password: _registerPassword,
        firstName: _registerUser.firstName ?? '',
        lastName: _registerUser.lastName ?? '',
        role: Roles.customer, // Always CUSTOMER for self-registration
        context: _context,
      );

      if (response.success && response.user != null && response.token != null) {
        _user = response.user;
        _token = response.token;

        await _saveTokens(_token!);
        await _saveUser(_user!);

        _setLoading(false);
        _showLoginSuccess = true;
        _successMessage = response.message;
        notifyListeners();

        await Future.delayed(const Duration(milliseconds: 800));
        onNavigate?.call('/home');
      } else {
        _setError(response.error ?? 'Registration failed');
        _setLoading(false);
        notifyListeners();
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      _setLoading(false);
      notifyListeners();
    }
  }

  /// Logout user
  Future<void> handleLogout() async {
    _setLoading(true);
    notifyListeners();

    try {
      if (_token != null && _token!.accessToken != null) {
        await _authApiService.logout(_token!.accessToken!, context: _context);
      }

      await _clearTokens();
      await _clearUser();

      _user = null;
      _token = null;
      _resetForms();
      _setError(null);
      _setLoading(false);

      notifyListeners();
      onNavigate?.call('/login');
    } catch (e) {
      await _clearTokens();
      await _clearUser();
      _user = null;
      _token = null;
      _resetForms();
      _setLoading(false);
      notifyListeners();
      onNavigate?.call('/login');
    }
  }

  /// Change password
  /// Note: After success, all sessions are revoked. User must login again.
  Future<bool> handleChangePassword() async {
    if (!isChangePasswordFormValid) {
      _setError('Please fix form errors');
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _setError(null);
    notifyListeners();

    try {
      if (_token?.accessToken == null) {
        _setError('Not authenticated');
        _setLoading(false);
        notifyListeners();
        return false;
      }

      final response = await _authApiService.changePassword(
        accessToken: _token!.accessToken!,
        currentPassword: _currentPassword,
        newPassword: _newPassword,
        context: _context,
      );

      _setLoading(false);

      if (response.success) {
        _successMessage = response.message ?? 'Password changed successfully';
        _clearChangePasswordForm();
        notifyListeners();

        // After password change, sessions are revoked
        // User must login again
        await Future.delayed(const Duration(seconds: 2));
        await handleLogout();
        return true;
      } else {
        _setError(response.error ?? 'Password change failed');
        notifyListeners();
        return false;
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  /// Refresh current user info from API
  Future<void> refreshUserInfo() async {
    if (_token?.accessToken == null) return;

    try {
      final response = await _authApiService.getCurrentUser(
        accessToken: _token!.accessToken!,
        context: _context,
      );

      if (response.success && response.user != null) {
        _user = response.user;
        await _saveUser(_user!);
        notifyListeners();
      }
    } catch (e) {
      print('Failed to refresh user info: $e');
    }
  }

  /// Restore session on app startup
  Future<void> restoreSession() async {
    _setLoading(true);
    notifyListeners();

    try {
      final accessToken = HiveService.get<String>('access_token');
      final refreshTokenStr = HiveService.get<String>('refresh_token');
      final expiresAtStr = HiveService.get<String>('token_expires_at');
      final tokenType = HiveService.get<String>('token_type') ?? 'Bearer';
      final userJson = HiveService.get<Map>('user');

      if (accessToken == null || refreshTokenStr == null || userJson == null) {
        _setLoading(false);
        notifyListeners();
        onNavigate?.call('/login');
        return;
      }

      DateTime? expiresAt;
      if (expiresAtStr != null) {
        expiresAt = DateTime.fromMillisecondsSinceEpoch(
          int.parse(expiresAtStr),
        );
      }

      final isExpired = expiresAt == null || expiresAt.isBefore(DateTime.now());
      final expiresSoon =
          expiresAt != null &&
          expiresAt.difference(DateTime.now()).inMinutes < 2;

      if (isExpired || expiresSoon) {
        final refreshResponse = await _authApiService.refreshToken(
          refreshTokenStr,
        );
        if (refreshResponse.success && refreshResponse.token != null) {
          _token = refreshResponse.token;
          await _saveTokens(refreshResponse.token!);

          // Update user if returned in refresh response
          if (refreshResponse.user != null) {
            _user = refreshResponse.user;
            await _saveUser(_user!);
          }
        } else {
          await _clearTokens();
          await _clearUser();
          _setLoading(false);
          notifyListeners();
          onNavigate?.call('/login');
          return;
        }
      } else {
        final expiresIn = expiresAt.difference(DateTime.now()).inSeconds;
        _token = Token(
          accessToken: accessToken,
          refreshToken: refreshTokenStr,
          tokenType: tokenType,
          expiresIn: expiresIn > 0 ? expiresIn : 900,
        );
      }

      _user = User.fromJson(Map<String, dynamic>.from(userJson));

      _setLoading(false);
      notifyListeners();
      onNavigate?.call('/home');
    } catch (e) {
      await _clearTokens();
      await _clearUser();
      _setLoading(false);
      notifyListeners();
      onNavigate?.call('/login');
    }
  }

  /// Refresh access token
  Future<bool> refreshToken() async {
    if (_token == null || _token!.refreshToken == null) return false;

    try {
      final response = await _authApiService.refreshToken(
        _token!.refreshToken!,
      );

      if (response.success && response.token != null) {
        _token = response.token;
        await _saveTokens(response.token!);

        if (response.user != null) {
          _user = response.user;
          await _saveUser(_user!);
        }

        notifyListeners();
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  // ============================================
  // VALIDATION METHODS
  // ============================================

  String? _validateEmail() {
    final email = _loginUser.email ?? '';
    if (email.isEmpty) return 'Email is required';
    return Validators.email(email);
  }

  String? _validatePassword() {
    if (_password.isEmpty) return 'Password is required';
    return Validators.password(_password);
  }

  String? _validateRegisterEmail() {
    final email = _registerUser.email ?? '';
    if (email.isEmpty) return 'Email is required';
    return Validators.email(email);
  }

  String? _validateFirstName() {
    final name = _registerUser.firstName ?? '';
    if (name.isEmpty) return 'First name is required';
    if (name.length < 2) return 'First name too short';
    return null;
  }

  String? _validateLastName() {
    final name = _registerUser.lastName ?? '';
    if (name.isEmpty) return 'Last name is required';
    if (name.length < 2) return 'Last name too short';
    return null;
  }

  String? _validateRegisterPassword() {
    if (_registerPassword.isEmpty) return 'Password is required';
    if (_registerPassword.length < 8)
      return 'Password must be at least 8 characters';
    return null;
  }

  String? _validateConfirmPassword() {
    if (_confirmPassword.isEmpty) return 'Confirm password is required';
    if (_confirmPassword != _registerPassword) return 'Passwords do not match';
    return null;
  }

  String? _validateNewPassword() {
    if (_newPassword.isEmpty) return 'New password is required';
    if (_newPassword.length < 8)
      return 'Password must be at least 8 characters';
    if (_newPassword == _currentPassword)
      return 'New password must be different';
    return null;
  }

  String? _validateConfirmNewPassword() {
    if (_confirmNewPassword.isEmpty) return 'Confirm password is required';
    if (_confirmNewPassword != _newPassword) return 'Passwords do not match';
    return null;
  }

  String? _validateForgotPasswordEmail() {
    final email = forgotPasswordEmail;
    if (email.isEmpty) return 'Email is required';
    return Validators.email(email);
  }

  // ============================================
  // PRIVATE HELPERS
  // ============================================

  void _setLoading(bool value) {
    _isLoading = value;
  }

  void _setError(String? value) {
    _error = value;
  }

  void _resetForms() {
    _loginUser = const User();
    _password = '';
    _registerUser = const User();
    _registerPassword = '';
    _confirmPassword = '';
    _clearChangePasswordForm();
  }

  void _clearChangePasswordForm() {
    _currentPassword = '';
    _newPassword = '';
    _confirmNewPassword = '';
  }

  Future<void> _saveTokens(Token token) async {
    if (token.accessToken != null) {
      await HiveService.set('access_token', token.accessToken!);
    }
    if (token.refreshToken != null) {
      await HiveService.set('refresh_token', token.refreshToken!);
    }
    if (token.tokenType != null) {
      await HiveService.set('token_type', token.tokenType!);
    }
    final expiresAt = token.expiresAt;
    if (expiresAt != null) {
      await HiveService.set(
        'token_expires_at',
        expiresAt.millisecondsSinceEpoch.toString(),
      );
    }
  }

  Future<void> _saveUser(User user) async {
    await HiveService.set('user', user.toJson());
  }

  Future<void> _clearTokens() async {
    await HiveService.remove('access_token');
    await HiveService.remove('refresh_token');
    await HiveService.remove('token_type');
    await HiveService.remove('token_expires_at');
  }

  Future<void> _clearUser() async {
    await HiveService.remove('user');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
