import 'package:flutter/material.dart';
import 'package:saasf/features/tenant/models/tenant_model.dart';
import 'package:saasf/features/tenant/models/tenant_settings_model.dart';
import 'package:saasf/features/tenant/services/tenant_api_service.dart';

/// Tenant Settings ViewModel
/// STRICT MVVM: All business logic, state management here
/// UI only renders state - zero logic in widgets
///
/// Handles:
/// - Tenant and Settings CRUD operations
/// - Settings form state
class TenantSettingsViewModel extends ChangeNotifier {
  final TenantApiService _apiService;

  // Tenant and Settings data
  Tenant? _tenant;
  TenantSettings? _settings;
  bool _isInitialized = false;

  // UI state
  bool _isLoading = false;
  bool _isSaving = false;
  String? _error;
  String? _successMessage;

  // Settings Form State
  String _settingsBusinessName = '';
  String _settingsBusinessType = TenantTypes.clinic;
  String _settingsTimezone = 'Asia/Kolkata';
  String _settingsMaxDailyBookings = '';
  bool _settingsUnlimitedBookings = false;
  String _settingsCancellationWindow = '';
  bool _settingsAllowWalkins = false;
  bool _settingsQueueEnabled = false;
  bool _settingsAutoAssignStaff = false;

  // Context for API calls
  BuildContext? _context;

  // Access token (will be set from AuthViewModel)
  String? _accessToken;

  TenantSettingsViewModel(this._apiService);

  // ============================================
  // GETTERS
  // ============================================

  Tenant? get tenant => _tenant;
  TenantSettings? get settings => _settings;
  bool get isInitialized => _isInitialized;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String? get error => _error;
  String? get successMessage => _successMessage;

  // Settings Form Getters
  String get settingsBusinessName => _settingsBusinessName;
  String get settingsBusinessType => _settingsBusinessType;
  String get settingsTimezone => _settingsTimezone;
  String get settingsMaxDailyBookings => _settingsMaxDailyBookings;
  bool get settingsUnlimitedBookings => _settingsUnlimitedBookings;
  String get settingsCancellationWindow => _settingsCancellationWindow;
  bool get settingsAllowWalkins => _settingsAllowWalkins;
  bool get settingsQueueEnabled => _settingsQueueEnabled;
  bool get settingsAutoAssignStaff => _settingsAutoAssignStaff;

  // ============================================
  // SETTERS
  // ============================================

  void setContext(BuildContext context) {
    _context = context;
  }

  void setAccessToken(String? token) {
    _accessToken = token;
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearSuccess() {
    _successMessage = null;
    notifyListeners();
  }

  // ============================================
  // INITIALIZATION
  // ============================================

  /// Initialize settings page (load tenant and settings data)
  /// This method combines setup and data loading for cleaner UI code
  Future<void> initializeSettingsPage({
    required BuildContext context,
    required String? accessToken,
    required String? tenantId,
  }) async {
    _context = context;
    _accessToken = accessToken;

    if (tenantId != null && tenantId.isNotEmpty) {
      await Future.wait([loadTenant(tenantId), loadSettings(tenantId)]);
    }
  }

  /// Refresh settings (reload tenant and settings)
  Future<void> refreshSettings(String tenantId) async {
    _isInitialized = false;
    await Future.wait([loadTenant(tenantId), loadSettings(tenantId)]);
  }

  // ============================================
  // TENANT OPERATIONS
  // ============================================

  /// Load tenant data
  Future<void> loadTenant(String tenantId) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return;
    }

    final response = await _apiService.getTenant(
      tenantId: tenantId,
      accessToken: _accessToken!,
      context: _context,
    );

    if (response.success && response.data != null) {
      _tenant = response.data;
      _initializeSettingsForm();
    } else {
      _error = response.error ?? 'Failed to load tenant';
    }
    notifyListeners();
  }

  /// Update tenant
  Future<bool> updateTenant({
    required String tenantId,
    String? name,
    String? type,
    String? timezone,
  }) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return false;
    }

    final response = await _apiService.updateTenant(
      tenantId: tenantId,
      name: name,
      type: type,
      timezone: timezone,
      accessToken: _accessToken!,
      context: _context,
    );

    if (response.success) {
      // Reload tenant data
      await loadTenant(tenantId);
      return true;
    } else {
      _error = response.error ?? 'Failed to update tenant';
      notifyListeners();
      return false;
    }
  }

  // ============================================
  // SETTINGS OPERATIONS
  // ============================================

  /// Load tenant settings
  Future<void> loadSettings(String tenantId) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    final response = await _apiService.getSettings(
      tenantId: tenantId,
      accessToken: _accessToken!,
      context: _context,
    );

    _isLoading = false;

    if (response.success && response.data != null) {
      _settings = response.data;
      _initializeSettingsForm();
      _isInitialized = true;
    } else {
      _error = response.error ?? 'Failed to load settings';
    }
    notifyListeners();
  }

  /// Initialize settings form from loaded data
  /// Called after both tenant and settings are loaded
  void _initializeSettingsForm() {
    if (_isInitialized && _tenant != null && _settings != null) return;

    // Initialize from tenant
    if (_tenant != null) {
      _settingsBusinessName = _tenant!.name ?? '';
      _settingsBusinessType = _tenant!.type ?? TenantTypes.clinic;
      _settingsTimezone = _tenant!.timezone ?? 'Asia/Kolkata';
    }

    // Initialize from settings
    if (_settings != null) {
      if (_settings!.maxDailyBookings == null) {
        _settingsUnlimitedBookings = true;
        _settingsMaxDailyBookings = '';
      } else {
        _settingsUnlimitedBookings = false;
        _settingsMaxDailyBookings = _settings!.maxDailyBookings.toString();
      }
      _settingsCancellationWindow =
          _settings!.cancellationWindowMinutes?.toString() ?? '60';
      _settingsAllowWalkins = _settings!.allowWalkins ?? true;
      _settingsQueueEnabled = _settings!.queueEnabled ?? false;
      _settingsAutoAssignStaff = _settings!.autoAssignStaff ?? false;
    }
  }

  // ============================================
  // SETTINGS FORM UPDATE METHODS
  // ============================================

  void updateSettingsBusinessName(String value) {
    _settingsBusinessName = value;
    notifyListeners();
  }

  void updateSettingsBusinessType(String value) {
    _settingsBusinessType = value;
    notifyListeners();
  }

  void updateSettingsTimezone(String value) {
    _settingsTimezone = value;
    notifyListeners();
  }

  void updateSettingsMaxDailyBookings(String value) {
    _settingsMaxDailyBookings = value;
    notifyListeners();
  }

  void updateSettingsUnlimitedBookings(bool value) {
    _settingsUnlimitedBookings = value;
    if (value) {
      _settingsMaxDailyBookings = '';
    }
    notifyListeners();
  }

  void updateSettingsCancellationWindow(String value) {
    _settingsCancellationWindow = value;
    notifyListeners();
  }

  void updateSettingsAllowWalkins(bool value) {
    _settingsAllowWalkins = value;
    notifyListeners();
  }

  void updateSettingsQueueEnabled(bool value) {
    _settingsQueueEnabled = value;
    notifyListeners();
  }

  void updateSettingsAutoAssignStaff(bool value) {
    _settingsAutoAssignStaff = value;
    notifyListeners();
  }

  // ============================================
  // VALIDATION
  // ============================================

  String? validateSettingsBusinessName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Business name is required';
    }
    return null;
  }

  String? validateSettingsMaxDailyBookings(String? value) {
    if (!_settingsUnlimitedBookings) {
      if (value == null || value.isEmpty) {
        return 'Enter a number or enable unlimited';
      }
      final num = int.tryParse(value);
      if (num == null || num < 1) {
        return 'Must be at least 1';
      }
    }
    return null;
  }

  String? validateSettingsCancellationWindow(String? value) {
    if (value != null && value.isNotEmpty) {
      final num = int.tryParse(value);
      if (num == null || num < 0) {
        return 'Must be 0 or greater';
      }
    }
    return null;
  }

  // ============================================
  // SAVE OPERATIONS
  // ============================================

  /// Save all settings (tenant + settings)
  /// Handles validation, API calls, and state updates
  Future<void> saveAllSettings(String tenantId) async {
    // Validate
    final nameError = validateSettingsBusinessName(_settingsBusinessName);
    final bookingsError = validateSettingsMaxDailyBookings(
      _settingsMaxDailyBookings,
    );
    final cancellationError = validateSettingsCancellationWindow(
      _settingsCancellationWindow,
    );

    if (nameError != null ||
        bookingsError != null ||
        cancellationError != null) {
      _error = 'Please fix validation errors';
      notifyListeners();
      return;
    }

    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return;
    }

    _isSaving = true;
    _error = null;
    _successMessage = null;
    notifyListeners();

    try {
      // Update tenant
      final tenantSuccess = await updateTenant(
        tenantId: tenantId,
        name: _settingsBusinessName,
        type: _settingsBusinessType,
        timezone: _settingsTimezone,
      );

      if (!tenantSuccess) {
        _isSaving = false;
        notifyListeners();
        return;
      }

      // Update settings
      final maxDailyBookings = _settingsUnlimitedBookings
          ? null
          : (_settingsMaxDailyBookings.isNotEmpty
                ? int.tryParse(_settingsMaxDailyBookings)
                : null);

      final settingsSuccess = await updateSettings(
        tenantId: tenantId,
        maxDailyBookings: maxDailyBookings,
        unlimitedBookings: _settingsUnlimitedBookings,
        allowWalkins: _settingsAllowWalkins,
        cancellationWindowMinutes: _settingsCancellationWindow.isNotEmpty
            ? int.tryParse(_settingsCancellationWindow)
            : null,
        queueEnabled: _settingsQueueEnabled,
        autoAssignStaff: _settingsAutoAssignStaff,
      );

      _isSaving = false;

      if (settingsSuccess) {
        _successMessage = 'Settings saved successfully';
      }
      notifyListeners();
    } catch (e) {
      _isSaving = false;
      _error = 'Failed to save settings: $e';
      notifyListeners();
    }
  }

  /// Update tenant settings
  /// All parameters are optional - only include fields you want to update
  /// [unlimitedBookings] - If true, sets max_daily_bookings to null (unlimited)
  Future<bool> updateSettings({
    required String tenantId,
    int? maxDailyBookings,
    bool? unlimitedBookings,
    bool? allowWalkins,
    int? cancellationWindowMinutes,
    bool? queueEnabled,
    bool? autoAssignStaff,
  }) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    // Create UpdateSettingsRequest with provided values
    // If unlimitedBookings is true, set maxDailyBookings to null
    final request = UpdateSettingsRequest(
      maxDailyBookings: unlimitedBookings == true ? null : maxDailyBookings,
      allowWalkins: allowWalkins,
      cancellationWindowMinutes: cancellationWindowMinutes,
      queueEnabled: queueEnabled,
      autoAssignStaff: autoAssignStaff,
    );

    final response = await _apiService.updateSettings(
      tenantId: tenantId,
      request: request,
      accessToken: _accessToken!,
      context: _context,
    );

    _isSaving = false;

    if (response.success) {
      _successMessage = 'Settings updated successfully';
      // Reload settings
      await loadSettings(tenantId);
      return true;
    } else {
      _error = response.error ?? 'Failed to update settings';
      notifyListeners();
      return false;
    }
  }
}
