import 'package:flutter/material.dart';
import 'package:saasf/features/tenant/models/tenant_model.dart';
import 'package:saasf/features/tenant/services/tenant_api_service.dart';

/// Tenant Management ViewModel
/// STRICT MVVM: All business logic, state management here
/// UI only renders state - zero logic in widgets
///
/// Handles:
/// - Tenant CRUD operations
/// - Tenant dialog state
class TenantManagementViewModel extends ChangeNotifier {
  final TenantApiService _apiService;

  // Tenant data
  Tenant? _tenant;
  bool _isInitialized = false;

  // UI state
  bool _isLoading = false;
  bool _isSaving = false;
  String? _error;
  String? _successMessage;

  // Create Tenant Dialog State
  String _createTenantDialogName = '';
  String _createTenantDialogType = TenantTypes.clinic;
  String _createTenantDialogTimezone = 'Asia/Kolkata';
  bool _createTenantDialogOpen = false;

  // Edit Tenant Dialog State
  String _editTenantName = '';
  String _editTenantType = TenantTypes.clinic;
  String _editTenantStatus = TenantStatus.active;
  String _editTenantTimezone = 'Asia/Kolkata';
  bool _editTenantDialogOpen = false;

  // Context for API calls
  BuildContext? _context;

  // Access token (will be set from AuthViewModel)
  String? _accessToken;

  TenantManagementViewModel(this._apiService);

  // ============================================
  // GETTERS
  // ============================================

  Tenant? get tenant => _tenant;
  bool get isInitialized => _isInitialized;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String? get error => _error;
  String? get successMessage => _successMessage;

  // Create Tenant Dialog Getters
  String get createTenantDialogName => _createTenantDialogName;
  String get createTenantDialogType => _createTenantDialogType;
  String get createTenantDialogTimezone => _createTenantDialogTimezone;
  bool get createTenantDialogOpen => _createTenantDialogOpen;

  // Edit Tenant Dialog Getters
  String get editTenantName => _editTenantName;
  String get editTenantType => _editTenantType;
  String get editTenantStatus => _editTenantStatus;
  String get editTenantTimezone => _editTenantTimezone;
  bool get editTenantDialogOpen => _editTenantDialogOpen;

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

  /// Initialize ViewModel with context, token, and load tenant data
  /// This method combines setup and data loading for cleaner UI code
  Future<void> initializeAndLoadTenant({
    required BuildContext context,
    required String? accessToken,
    required String? tenantId,
  }) async {
    _context = context;
    _accessToken = accessToken;

    if (tenantId != null && tenantId.isNotEmpty) {
      await loadTenant(tenantId);
    }
  }

  /// Refresh tenant data
  /// Reloads tenant data if tenantId is available
  Future<void> refreshTenantData(String? tenantId) async {
    if (tenantId != null && tenantId.isNotEmpty) {
      _isInitialized = false;
      await loadTenant(tenantId);
    }
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

    _isLoading = true;
    _error = null;
    notifyListeners();

    final response = await _apiService.getTenant(
      tenantId: tenantId,
      accessToken: _accessToken!,
      context: _context,
    );

    _isLoading = false;

    if (response.success && response.data != null) {
      _tenant = response.data;
      _isInitialized = true;
    } else {
      _error = response.error ?? 'Failed to load tenant';
    }
    notifyListeners();
  }

  /// Create a new tenant
  Future<bool> createTenant({
    required String name,
    required String type,
    required String ownerUserId,
    required String timezone,
  }) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    final response = await _apiService.createTenant(
      name: name,
      type: type,
      ownerUserId: ownerUserId,
      timezone: timezone,
      accessToken: _accessToken!,
      context: _context,
    );

    _isSaving = false;

    if (response.success && response.data != null) {
      _tenant = response.data;
      _successMessage = 'Tenant created successfully';
      notifyListeners();
      return true;
    } else {
      _error = response.error ?? 'Failed to create tenant';
      notifyListeners();
      return false;
    }
  }

  /// Update tenant
  Future<bool> updateTenant({
    required String tenantId,
    String? name,
    String? type,
    String? status,
    String? timezone,
  }) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    final response = await _apiService.updateTenant(
      tenantId: tenantId,
      name: name,
      type: type,
      status: status,
      timezone: timezone,
      accessToken: _accessToken!,
      context: _context,
    );

    _isSaving = false;

    if (response.success) {
      _successMessage = 'Tenant updated successfully';
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
  // CREATE TENANT DIALOG METHODS
  // ============================================

  void initializeCreateTenantDialog() {
    _createTenantDialogName = '';
    _createTenantDialogType = TenantTypes.clinic;
    _createTenantDialogTimezone = 'Asia/Kolkata';
    _createTenantDialogOpen = true;
    notifyListeners();
  }

  void updateCreateTenantDialogName(String value) {
    _createTenantDialogName = value.trim();
    notifyListeners();
  }

  void updateCreateTenantDialogType(String value) {
    _createTenantDialogType = value;
    notifyListeners();
  }

  void updateCreateTenantDialogTimezone(String value) {
    _createTenantDialogTimezone = value;
    notifyListeners();
  }

  void closeCreateTenantDialog() {
    _createTenantDialogOpen = false;
    _createTenantDialogName = '';
    _createTenantDialogType = TenantTypes.clinic;
    _createTenantDialogTimezone = 'Asia/Kolkata';
    notifyListeners();
  }

  /// Create tenant using dialog state
  Future<bool> createTenantFromDialog(String ownerUserId) async {
    if (_createTenantDialogName.isEmpty) {
      _error = 'Organization name is required';
      notifyListeners();
      return false;
    }
    final success = await createTenant(
      name: _createTenantDialogName,
      type: _createTenantDialogType,
      ownerUserId: ownerUserId,
      timezone: _createTenantDialogTimezone,
    );
    if (success) {
      closeCreateTenantDialog();
    }
    return success;
  }

  // ============================================
  // EDIT TENANT DIALOG METHODS
  // ============================================

  void initializeEditTenantDialog(Tenant tenant) {
    _editTenantName = tenant.name ?? '';
    _editTenantType = tenant.type ?? TenantTypes.clinic;
    _editTenantStatus = tenant.status ?? TenantStatus.active;
    _editTenantTimezone = tenant.timezone ?? 'Asia/Kolkata';
    _editTenantDialogOpen = true;
    notifyListeners();
  }

  void updateEditTenantName(String value) {
    _editTenantName = value;
    notifyListeners();
  }

  void updateEditTenantType(String value) {
    _editTenantType = value;
    notifyListeners();
  }

  void updateEditTenantStatus(String value) {
    _editTenantStatus = value;
    notifyListeners();
  }

  void updateEditTenantTimezone(String value) {
    _editTenantTimezone = value;
    notifyListeners();
  }

  void closeEditTenantDialog() {
    _editTenantDialogOpen = false;
    _editTenantName = '';
    _editTenantType = TenantTypes.clinic;
    _editTenantStatus = TenantStatus.active;
    _editTenantTimezone = 'Asia/Kolkata';
    notifyListeners();
  }

  /// Update tenant using dialog state
  Future<bool> updateTenantFromDialog(String tenantId) async {
    final success = await updateTenant(
      tenantId: tenantId,
      name: _editTenantName,
      type: _editTenantType,
      status: _editTenantStatus,
      timezone: _editTenantTimezone,
    );
    if (success) {
      closeEditTenantDialog();
    }
    return success;
  }

  // ============================================
  // NAVIGATION
  // ============================================

  /// Get navigation route for Settings page
  String getSettingsRoute() => '/tenant/settings';

  /// Get navigation route for Working Hours page
  String getWorkingHoursRoute() => '/tenant/hours';

  /// Get navigation route for Holidays page
  String getHolidaysRoute() => '/tenant/holidays';

  /// Get navigation route for Staff page
  String getStaffRoute() => '/tenant/staff';
}
