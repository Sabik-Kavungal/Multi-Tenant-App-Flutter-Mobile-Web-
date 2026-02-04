import 'package:flutter/material.dart';
import 'package:saasf/features/tenant/models/working_hours_model.dart';
import 'package:saasf/features/tenant/services/tenant_api_service.dart';

/// Working Hours ViewModel
/// STRICT MVVM: All business logic, state management here
/// UI only renders state - zero logic in widgets
///
/// Handles:
/// - Working hours CRUD operations
/// - Working hours schedule state
class WorkingHoursViewModel extends ChangeNotifier {
  final TenantApiService _apiService;

  // Working hours data
  List<WorkingHours> _workingHours = [];
  bool _isInitialized = false;

  // UI state
  bool _isLoading = false;
  bool _isSaving = false;
  String? _error;
  String? _successMessage;

  // Working Hours Schedule State (editable UI state)
  List<_DaySchedule> _workingHoursSchedule = [];
  bool _workingHoursScheduleInitialized = false;
  bool _workingHoursHasChanges = false;

  // Prevent multiple simultaneous initializations
  bool _isInitializing = false;

  // Context for API calls
  BuildContext? _context;

  // Access token (will be set from AuthViewModel)
  String? _accessToken;

  WorkingHoursViewModel(this._apiService);

  // ============================================
  // GETTERS
  // ============================================

  List<WorkingHours> get workingHours => _workingHours;
  bool get isInitialized => _isInitialized;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String? get error => _error;
  String? get successMessage => _successMessage;

  // Working Hours Schedule Getters
  List<_DaySchedule> get workingHoursSchedule => _workingHoursSchedule;
  bool get workingHoursScheduleInitialized => _workingHoursScheduleInitialized;
  bool get workingHoursHasChanges => _workingHoursHasChanges;

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

  /// Initialize working hours page (load data and initialize schedule)
  /// This method combines setup and data loading for cleaner UI code
  Future<void> initializeWorkingHoursPage({
    required BuildContext context,
    required String? accessToken,
    required String? tenantId,
  }) async {
    // Prevent multiple simultaneous initializations
    if (_isInitializing || _workingHoursScheduleInitialized) {
      return;
    }

    _isInitializing = true;
    _context = context;
    _accessToken = accessToken;

    try {
      if (tenantId != null && tenantId.isNotEmpty) {
        await loadWorkingHours(tenantId);
      } else {
        // Initialize with defaults if no tenant
        _initializeWorkingHoursSchedule();
      }
    } finally {
      _isInitializing = false;
    }
  }

  /// Refresh working hours data
  /// Reloads working hours data if tenantId is available
  Future<void> refreshWorkingHours(String? tenantId) async {
    if (tenantId != null && tenantId.isNotEmpty) {
      _workingHoursScheduleInitialized = false;
      _isInitialized = false;
      await loadWorkingHours(tenantId);
    }
  }

  // ============================================
  // WORKING HOURS OPERATIONS
  // ============================================

  /// Load working hours
  Future<void> loadWorkingHours(String tenantId) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    final response = await _apiService.getWorkingHours(
      tenantId: tenantId,
      accessToken: _accessToken!,
      context: _context,
    );

    _isLoading = false;

    if (response.success && response.data != null) {
      _workingHours = response.data!;
      // Sort by day of week
      _workingHours.sort(
        (a, b) => (a.dayOfWeek ?? 0).compareTo(b.dayOfWeek ?? 0),
      );
      // Initialize schedule from API data
      _initializeWorkingHoursSchedule();
      _isInitialized = true;
    } else {
      // Check if error is rate limit (429)
      final errorMessage = response.error ?? 'Failed to load working hours';
      if (errorMessage.contains('rate limit') || errorMessage.contains('429')) {
        _error = 'API rate limit exceeded. Please wait a moment and try again.';
        // Initialize with defaults to prevent retry loop
        _initializeWorkingHoursSchedule();
      } else {
        _error = errorMessage;
      }
    }
    notifyListeners();
  }

  /// Initialize working hours schedule from API data or defaults
  void _initializeWorkingHoursSchedule() {
    if (_workingHoursScheduleInitialized && _workingHours.isEmpty) return;

    // Initialize with default schedule
    _workingHoursSchedule = [
      _DaySchedule(0, 'Sunday', false, null, null),
      _DaySchedule(1, 'Monday', true, '09:00', '17:00'),
      _DaySchedule(2, 'Tuesday', true, '09:00', '17:00'),
      _DaySchedule(3, 'Wednesday', true, '09:00', '17:00'),
      _DaySchedule(4, 'Thursday', true, '09:00', '17:00'),
      _DaySchedule(5, 'Friday', true, '09:00', '17:00'),
      _DaySchedule(6, 'Saturday', false, null, null),
    ];

    // Update from API data if available
    if (_workingHours.isNotEmpty) {
      for (var apiHour in _workingHours) {
        final dayIndex = apiHour.dayOfWeek;
        if (dayIndex != null && dayIndex >= 0 && dayIndex < 7) {
          _workingHoursSchedule[dayIndex] = _DaySchedule(
            dayIndex,
            DayOfWeek.getName(dayIndex),
            !(apiHour.isClosed ?? true),
            apiHour.openTime,
            apiHour.closeTime,
          );
        }
      }
    }

    _workingHoursScheduleInitialized = true;
    _workingHoursHasChanges = false;
    notifyListeners();
  }

  /// Toggle day open/closed state
  void toggleWorkingHoursDay(int dayIndex) {
    if (dayIndex < 0 || dayIndex >= _workingHoursSchedule.length) return;

    _workingHoursSchedule[dayIndex].isOpen =
        !_workingHoursSchedule[dayIndex].isOpen;

    // Set default times if opening
    if (_workingHoursSchedule[dayIndex].isOpen) {
      if (_workingHoursSchedule[dayIndex].openTime == null) {
        _workingHoursSchedule[dayIndex].openTime = '09:00';
      }
      if (_workingHoursSchedule[dayIndex].closeTime == null) {
        _workingHoursSchedule[dayIndex].closeTime = '17:00';
      }
    }

    _workingHoursHasChanges = true;
    notifyListeners();
  }

  /// Update working hours time for a day
  void updateWorkingHoursTime(int dayIndex, bool isOpenTime, String time) {
    if (dayIndex < 0 || dayIndex >= _workingHoursSchedule.length) return;

    if (isOpenTime) {
      _workingHoursSchedule[dayIndex].openTime = time;
    } else {
      _workingHoursSchedule[dayIndex].closeTime = time;
    }

    _workingHoursHasChanges = true;
    notifyListeners();
  }

  /// Save working hours from schedule
  Future<bool> saveWorkingHoursFromSchedule(String tenantId) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return false;
    }

    // Convert schedule to API format
    final hours = _workingHoursSchedule.map((day) {
      return WorkingHoursInput(
        dayOfWeek: day.dayOfWeek,
        openTime: day.isOpen ? day.openTime : null,
        closeTime: day.isOpen ? day.closeTime : null,
        isClosed: !day.isOpen,
      );
    }).toList();

    final success = await updateWorkingHours(tenantId: tenantId, hours: hours);

    if (success) {
      _workingHoursHasChanges = false;
    }

    return success;
  }

  /// Update working hours
  Future<bool> updateWorkingHours({
    required String tenantId,
    required List<WorkingHoursInput> hours,
  }) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    final response = await _apiService.updateWorkingHours(
      tenantId: tenantId,
      hours: hours,
      accessToken: _accessToken!,
      context: _context,
    );

    _isSaving = false;

    if (response.success) {
      _successMessage = 'Working hours updated successfully';
      // Reload working hours
      await loadWorkingHours(tenantId);
      return true;
    } else {
      _error = response.error ?? 'Failed to update working hours';
      notifyListeners();
      return false;
    }
  }
}

// ============================================
// WORKING HOURS SCHEDULE DATA CLASS
// ============================================
// Simple data class for UI state (not a Freezed model since it's not API data)
class _DaySchedule {
  final int dayOfWeek;
  final String name;
  bool isOpen;
  String? openTime;
  String? closeTime;

  _DaySchedule(
    this.dayOfWeek,
    this.name,
    this.isOpen,
    this.openTime,
    this.closeTime,
  );
}
