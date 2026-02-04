import 'package:flutter/material.dart';
import 'package:saasf/features/tenant/models/staff_model.dart';
import 'package:saasf/features/tenant/services/tenant_api_service.dart';

/// Staff ViewModel
/// STRICT MVVM: All business logic, state management here
/// UI only renders state - zero logic in widgets
///
/// Handles:
/// - Staff CRUD operations
/// - Staff dialog state
class StaffViewModel extends ChangeNotifier {
  final TenantApiService _apiService;

  // Staff data
  List<Staff> _staffList = [];
  bool _isInitialized = false;

  // UI state
  bool _isLoading = false;
  bool _isSaving = false;
  String? _error;
  String? _successMessage;

  // Add Staff Dialog State
  // Mode selection: true = existing user, false = create new user
  bool _addStaffModeExisting = true;

  // Mode 1: Add existing user
  String _addStaffUserId = '';

  // Mode 2: Create new user
  String _addStaffEmail = '';
  String _addStaffPassword = '';
  String _addStaffFirstName = '';
  String _addStaffLastName = '';
  bool _addStaffPasswordObscure = true;

  // Common
  String _addStaffDesignation = StaffDesignation.staff;
  bool _addStaffDialogOpen = false;

  // Edit Staff Dialog State
  String? _editStaffId;
  String _editStaffDesignation = StaffDesignation.staff;
  bool _editStaffDialogOpen = false;

  // Context for API calls
  BuildContext? _context;

  // Access token (will be set from AuthViewModel)
  String? _accessToken;

  StaffViewModel(this._apiService);

  // ============================================
  // GETTERS
  // ============================================

  List<Staff> get staffList => _staffList;
  bool get isInitialized => _isInitialized;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String? get error => _error;
  String? get successMessage => _successMessage;

  // Computed getters
  List<Staff> get activeStaff =>
      _staffList.where((s) => s.isActive == true).toList();
  List<Staff> get adminStaff =>
      _staffList.where((s) => s.designation == StaffDesignation.admin).toList();

  // Add Staff Dialog Getters
  bool get addStaffModeExisting => _addStaffModeExisting;
  String get addStaffUserId => _addStaffUserId;
  String get addStaffEmail => _addStaffEmail;
  String get addStaffPassword => _addStaffPassword;
  String get addStaffFirstName => _addStaffFirstName;
  String get addStaffLastName => _addStaffLastName;
  bool get addStaffPasswordObscure => _addStaffPasswordObscure;
  String get addStaffDesignation => _addStaffDesignation;
  bool get addStaffDialogOpen => _addStaffDialogOpen;

  // Edit Staff Dialog Getters
  String? get editStaffId => _editStaffId;
  String get editStaffDesignation => _editStaffDesignation;
  bool get editStaffDialogOpen => _editStaffDialogOpen;

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

  /// Initialize staff page (load data)
  /// This method combines setup and data loading for cleaner UI code
  Future<void> initializeStaffPage({
    required BuildContext context,
    required String? accessToken,
    required String? tenantId,
  }) async {
    _context = context;
    _accessToken = accessToken;

    if (tenantId != null && tenantId.isNotEmpty) {
      await loadStaff(tenantId);
    }
  }

  /// Refresh staff data
  /// Reloads staff data if tenantId is available
  Future<void> refreshStaff(String? tenantId) async {
    if (tenantId != null && tenantId.isNotEmpty) {
      _isInitialized = false;
      await loadStaff(tenantId);
    }
  }

  // ============================================
  // STAFF OPERATIONS
  // ============================================

  /// Load staff
  Future<void> loadStaff(String tenantId) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    final response = await _apiService.getStaff(
      tenantId: tenantId,
      accessToken: _accessToken!,
      context: _context,
    );

    _isLoading = false;

    if (response.success && response.data != null) {
      _staffList = response.data!;
      _isInitialized = true;
    } else {
      _error = response.error ?? 'Failed to load staff';
    }
    notifyListeners();
  }

  // ============================================
  // ADD STAFF DIALOG METHODS
  // ============================================

  void initializeAddStaffDialog() {
    _addStaffModeExisting = true; // Default to Mode 1
    _addStaffUserId = '';
    _addStaffEmail = '';
    _addStaffPassword = '';
    _addStaffFirstName = '';
    _addStaffLastName = '';
    _addStaffPasswordObscure = true;
    _addStaffDesignation = StaffDesignation.staff;
    _addStaffDialogOpen = true;
    notifyListeners();
  }

  void updateAddStaffMode(bool isExisting) {
    _addStaffModeExisting = isExisting;
    notifyListeners();
  }

  // Mode 1: Existing user
  void updateAddStaffUserId(String value) {
    _addStaffUserId = value.trim();
    notifyListeners();
  }

  // Mode 2: Create new user
  void updateAddStaffEmail(String value) {
    _addStaffEmail = value.trim();
    notifyListeners();
  }

  void updateAddStaffPassword(String value) {
    _addStaffPassword = value;
    notifyListeners();
  }

  void updateAddStaffFirstName(String value) {
    _addStaffFirstName = value.trim();
    notifyListeners();
  }

  void updateAddStaffLastName(String value) {
    _addStaffLastName = value.trim();
    notifyListeners();
  }

  void toggleAddStaffPasswordVisibility() {
    _addStaffPasswordObscure = !_addStaffPasswordObscure;
    notifyListeners();
  }

  // Common
  void updateAddStaffDesignation(String value) {
    _addStaffDesignation = value;
    notifyListeners();
  }

  void closeAddStaffDialog() {
    _addStaffDialogOpen = false;
    _addStaffModeExisting = true;
    _addStaffUserId = '';
    _addStaffEmail = '';
    _addStaffPassword = '';
    _addStaffFirstName = '';
    _addStaffLastName = '';
    _addStaffPasswordObscure = true;
    _addStaffDesignation = StaffDesignation.staff;
    notifyListeners();
  }

  /// Create staff using dialog state
  /// Supports both modes: existing user or create new user
  Future<bool> createStaffFromDialog(String tenantId) async {
    // Validate based on mode
    if (_addStaffModeExisting) {
      // Mode 1: Existing user
      if (_addStaffUserId.isEmpty) {
        _error = 'User ID is required';
        notifyListeners();
        return false;
      }
    } else {
      // Mode 2: Create new user
      if (_addStaffEmail.isEmpty ||
          _addStaffPassword.isEmpty ||
          _addStaffFirstName.isEmpty ||
          _addStaffLastName.isEmpty) {
        _error = 'Please fill all required fields';
        notifyListeners();
        return false;
      }
      if (_addStaffPassword.length < 8) {
        _error = 'Password must be at least 8 characters';
        notifyListeners();
        return false;
      }
    }

    final success = await createStaff(
      tenantId: tenantId,
      designation: _addStaffDesignation,
      // Mode 1: Existing user
      userId: _addStaffModeExisting ? _addStaffUserId : null,
      // Mode 2: Create new user
      email: _addStaffModeExisting ? null : _addStaffEmail,
      password: _addStaffModeExisting ? null : _addStaffPassword,
      firstName: _addStaffModeExisting ? null : _addStaffFirstName,
      lastName: _addStaffModeExisting ? null : _addStaffLastName,
    );

    if (success) {
      closeAddStaffDialog();
    }
    return success;
  }

  /// Create staff - supports two modes
  ///
  /// **Mode 1: Add Existing User as Staff**
  /// - Provide: `userId` + `designation`
  ///
  /// **Mode 2: Create New User and Add as Staff**
  /// - Provide: `email`, `password`, `firstName`, `lastName` + `designation`
  /// - Creates new user account (role = designation) and adds as staff
  /// - User can login immediately with provided credentials
  Future<bool> createStaff({
    required String tenantId,
    required String designation,
    // Mode 1: Add existing user
    String? userId,
    // Mode 2: Create new user
    String? email,
    String? password,
    String? firstName,
    String? lastName,
  }) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    final response = await _apiService.createStaff(
      tenantId: tenantId,
      designation: designation,
      accessToken: _accessToken!,
      context: _context,
      // Mode 1: Existing user
      userId: userId,
      // Mode 2: Create new user
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );

    _isSaving = false;

    if (response.success && response.data != null) {
      _successMessage = userId != null
          ? 'Staff added successfully'
          : 'New user created and added as staff successfully';
      // Reload staff
      await loadStaff(tenantId);
      return true;
    } else {
      _error = response.error ?? 'Failed to add staff';
      notifyListeners();
      return false;
    }
  }

  // ============================================
  // EDIT STAFF DIALOG METHODS
  // ============================================

  void initializeEditStaffDialog(Staff staff) {
    _editStaffId = staff.id;
    _editStaffDesignation = staff.designation ?? StaffDesignation.staff;
    _editStaffDialogOpen = true;
    notifyListeners();
  }

  void updateEditStaffDesignation(String value) {
    _editStaffDesignation = value;
    notifyListeners();
  }

  void closeEditStaffDialog() {
    _editStaffDialogOpen = false;
    _editStaffId = null;
    _editStaffDesignation = StaffDesignation.staff;
    notifyListeners();
  }

  /// Update staff using dialog state
  Future<bool> updateStaffFromDialog(String tenantId) async {
    if (_editStaffId == null) {
      _error = 'Staff ID is required';
      notifyListeners();
      return false;
    }
    final success = await updateStaff(
      tenantId: tenantId,
      staffId: _editStaffId!,
      designation: _editStaffDesignation,
    );
    if (success) {
      closeEditStaffDialog();
    }
    return success;
  }

  /// Update staff
  Future<bool> updateStaff({
    required String tenantId,
    required String staffId,
    String? designation,
    bool? isActive,
  }) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    final response = await _apiService.updateStaff(
      tenantId: tenantId,
      staffId: staffId,
      designation: designation,
      isActive: isActive,
      accessToken: _accessToken!,
      context: _context,
    );

    _isSaving = false;

    if (response.success) {
      _successMessage = 'Staff updated successfully';
      // Reload staff
      await loadStaff(tenantId);
      return true;
    } else {
      _error = response.error ?? 'Failed to update staff';
      notifyListeners();
      return false;
    }
  }

  /// Delete staff
  Future<bool> deleteStaff({
    required String tenantId,
    required String staffId,
  }) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    final response = await _apiService.deleteStaff(
      tenantId: tenantId,
      staffId: staffId,
      accessToken: _accessToken!,
      context: _context,
    );

    _isSaving = false;

    if (response.success) {
      _successMessage = 'Staff removed successfully';
      // Reload staff
      await loadStaff(tenantId);
      return true;
    } else {
      _error = response.error ?? 'Failed to remove staff';
      notifyListeners();
      return false;
    }
  }
}
