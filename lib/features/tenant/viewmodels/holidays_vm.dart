import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saasf/features/tenant/models/holiday_model.dart';
import 'package:saasf/features/tenant/services/tenant_api_service.dart';

/// Holidays ViewModel
/// STRICT MVVM: All business logic, state management here
/// UI only renders state - zero logic in widgets
///
/// Handles:
/// - Holiday CRUD operations
/// - Holiday dialog state
class HolidaysViewModel extends ChangeNotifier {
  final TenantApiService _apiService;

  // Holiday data
  List<Holiday> _holidays = [];
  bool _isInitialized = false;

  // UI state
  bool _isLoading = false;
  bool _isSaving = false;
  String? _error;
  String? _successMessage;

  // Add Holiday Dialog State
  String _addHolidayReason = '';
  DateTime _addHolidayDate = DateTime.now().add(const Duration(days: 1));
  bool _addHolidayDialogOpen = false;

  // Context for API calls
  BuildContext? _context;

  // Access token (will be set from AuthViewModel)
  String? _accessToken;

  HolidaysViewModel(this._apiService);

  // ============================================
  // GETTERS
  // ============================================

  List<Holiday> get holidays => _holidays;
  bool get isInitialized => _isInitialized;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String? get error => _error;
  String? get successMessage => _successMessage;

  // Add Holiday Dialog Getters
  String get addHolidayReason => _addHolidayReason;
  DateTime get addHolidayDate => _addHolidayDate;
  bool get addHolidayDialogOpen => _addHolidayDialogOpen;

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

  /// Initialize holidays page (load data)
  /// This method combines setup and data loading for cleaner UI code
  Future<void> initializeHolidaysPage({
    required BuildContext context,
    required String? accessToken,
    required String? tenantId,
  }) async {
    _context = context;
    _accessToken = accessToken;

    if (tenantId != null && tenantId.isNotEmpty) {
      await loadHolidays(tenantId);
    }
  }

  /// Refresh holidays data
  /// Reloads holidays data if tenantId is available
  Future<void> refreshHolidays(String? tenantId) async {
    if (tenantId != null && tenantId.isNotEmpty) {
      _isInitialized = false;
      await loadHolidays(tenantId);
    }
  }

  // ============================================
  // HOLIDAY OPERATIONS
  // ============================================

  /// Load holidays
  Future<void> loadHolidays(String tenantId) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    final response = await _apiService.getHolidays(
      tenantId: tenantId,
      accessToken: _accessToken!,
      context: _context,
    );

    _isLoading = false;

    if (response.success && response.data != null) {
      _holidays = response.data!;
      // Sort by date
      _holidays.sort((a, b) {
        final dateA = a.holidayDate ?? '';
        final dateB = b.holidayDate ?? '';
        return dateA.compareTo(dateB);
      });
      _isInitialized = true;
    } else {
      _error = response.error ?? 'Failed to load holidays';
    }
    notifyListeners();
  }

  // ============================================
  // ADD HOLIDAY DIALOG METHODS
  // ============================================

  void initializeAddHolidayDialog() {
    _addHolidayReason = '';
    _addHolidayDate = DateTime.now().add(const Duration(days: 1));
    _addHolidayDialogOpen = true;
    notifyListeners();
  }

  void updateAddHolidayReason(String value) {
    _addHolidayReason = value.trim();
    notifyListeners();
  }

  void updateAddHolidayDate(DateTime value) {
    _addHolidayDate = value;
    notifyListeners();
  }

  void closeAddHolidayDialog() {
    _addHolidayDialogOpen = false;
    _addHolidayReason = '';
    _addHolidayDate = DateTime.now().add(const Duration(days: 1));
    notifyListeners();
  }

  /// Create holiday using dialog state
  Future<bool> createHolidayFromDialog(String tenantId) async {
    if (_addHolidayReason.isEmpty) {
      _error = 'Holiday reason is required';
      notifyListeners();
      return false;
    }
    final dateStr = DateFormat('yyyy-MM-dd').format(_addHolidayDate);
    final success = await createHoliday(
      tenantId: tenantId,
      holidayDate: dateStr,
      reason: _addHolidayReason,
    );
    if (success) {
      closeAddHolidayDialog();
    }
    return success;
  }

  /// Create a holiday
  Future<bool> createHoliday({
    required String tenantId,
    required String holidayDate,
    required String reason,
  }) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    final response = await _apiService.createHoliday(
      tenantId: tenantId,
      holidayDate: holidayDate,
      reason: reason,
      accessToken: _accessToken!,
      context: _context,
    );

    _isSaving = false;

    if (response.success && response.data != null) {
      _successMessage = 'Holiday added successfully';
      // Reload holidays
      await loadHolidays(tenantId);
      return true;
    } else {
      _error = response.error ?? 'Failed to create holiday';
      notifyListeners();
      return false;
    }
  }

  /// Delete a holiday
  Future<bool> deleteHoliday({
    required String tenantId,
    required String holidayId,
  }) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    final response = await _apiService.deleteHoliday(
      tenantId: tenantId,
      holidayId: holidayId,
      accessToken: _accessToken!,
      context: _context,
    );

    _isSaving = false;

    if (response.success) {
      _successMessage = 'Holiday deleted successfully';
      // Reload holidays
      await loadHolidays(tenantId);
      return true;
    } else {
      _error = response.error ?? 'Failed to delete holiday';
      notifyListeners();
      return false;
    }
  }
}
