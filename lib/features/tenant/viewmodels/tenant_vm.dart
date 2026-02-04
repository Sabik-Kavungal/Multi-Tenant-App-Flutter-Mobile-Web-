import 'package:flutter/material.dart';
import 'package:saasf/features/tenant/models/tenant_model.dart';
import 'package:saasf/features/tenant/models/tenant_api_user_model.dart';
import 'package:saasf/features/tenant/services/tenant_api_service.dart';

/// Tenant ViewModel
/// STRICT MVVM: All business logic, state management here
/// UI only renders state - zero logic in widgets
///
/// Handles:
/// - Super Admin operations (all tenants list, pagination, filtering)
/// - User creation and management
/// - Tenant-user assignment
/// - Super Admin dialogs state
class TenantViewModel extends ChangeNotifier {
  final TenantApiService _apiService;

  // Super Admin - All tenants list with pagination
  List<Tenant> _allTenants = [];
  int _totalTenants = 0;
  int _currentPage = 1;
  int _pageSize = 20;
  int _totalPages = 1;
  String? _statusFilter;

  // Super Admin - Users list (for dropdown)
  List<CreatedUser> _availableUsers = [];
  bool _isLoadingUsers = false;

  // Search state for AllTenantsPage
  String _searchQuery = '';
  String _filterStatus = 'all';
  bool _isInitialLoad = true;

  // UI state
  bool _isLoading = false;
  bool _isSaving = false;
  bool _isLoadingMore = false;
  String? _error;
  String? _successMessage;

  // Dialog form state (for AllTenantsPage dialogs)
  // Edit Tenant Dialog
  String _editTenantName = '';
  String _editTenantType = TenantTypes.clinic;
  String _editTenantStatus = TenantStatus.active;
  String _editTenantTimezone = 'Asia/Kolkata';
  bool _editTenantDialogOpen = false;

  // Create User and Tenant Dialog
  String _createUserEmail = '';
  String _createUserPassword = '';
  String _createUserFirstName = '';
  String _createUserLastName = '';
  String _createTenantName = '';
  String _createTenantType = TenantTypes.clinic;
  String _createTenantTimezone = 'Asia/Kolkata';
  bool _createUserPasswordObscure = true;
  bool _createUserAndTenantDialogOpen = false;

  // Create Tenant for Existing User Dialog
  String _createTenantForUserTenantName = '';
  String _createTenantForUserType = TenantTypes.clinic;
  String _createTenantForUserTimezone = 'Asia/Kolkata';
  String? _createTenantForUserSelectedUserId;
  bool _createTenantForUserDialogOpen = false;

  // Context for API calls
  BuildContext? _context;

  // Access token (will be set from AuthViewModel)
  String? _accessToken;

  TenantViewModel(this._apiService);

  // ============================================
  // GETTERS
  // ============================================

  List<Tenant> get allTenants => _allTenants;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  bool get isLoadingMore => _isLoadingMore;
  String? get error => _error;
  String? get successMessage => _successMessage;

  // Pagination getters
  int get totalTenants => _totalTenants;
  int get currentPage => _currentPage;
  int get pageSize => _pageSize;
  int get totalPages => _totalPages;
  String? get statusFilter => _statusFilter;
  bool get hasMorePages => _currentPage < _totalPages;

  // Super Admin computed getters (from API response)
  int get totalTenantsCount => _totalTenants;
  int get activeTenantsCount =>
      _allTenants.where((t) => t.status == TenantStatus.active).length;
  int get suspendedTenantsCount =>
      _allTenants.where((t) => t.status == TenantStatus.suspended).length;

  // Super Admin - Users list getters
  List<CreatedUser> get availableUsers => _availableUsers;
  bool get isLoadingUsers => _isLoadingUsers;

  // Search getters
  String get searchQuery => _searchQuery;
  String get filterStatus => _filterStatus;
  bool get isInitialLoad => _isInitialLoad;

  // Dialog Form Getters
  // Edit Tenant Dialog
  String get editTenantName => _editTenantName;
  String get editTenantType => _editTenantType;
  String get editTenantStatus => _editTenantStatus;
  String get editTenantTimezone => _editTenantTimezone;
  bool get editTenantDialogOpen => _editTenantDialogOpen;

  // Create User and Tenant Dialog
  String get createUserEmail => _createUserEmail;
  String get createUserPassword => _createUserPassword;
  String get createUserFirstName => _createUserFirstName;
  String get createUserLastName => _createUserLastName;
  String get createTenantName => _createTenantName;
  String get createTenantType => _createTenantType;
  String get createTenantTimezone => _createTenantTimezone;
  bool get createUserPasswordObscure => _createUserPasswordObscure;
  bool get createUserAndTenantDialogOpen => _createUserAndTenantDialogOpen;

  // Create Tenant for Existing User Dialog
  String get createTenantForUserTenantName => _createTenantForUserTenantName;
  String get createTenantForUserType => _createTenantForUserType;
  String get createTenantForUserTimezone => _createTenantForUserTimezone;
  String? get createTenantForUserSelectedUserId =>
      _createTenantForUserSelectedUserId;
  bool get createTenantForUserDialogOpen => _createTenantForUserDialogOpen;

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
  // DIALOG FORM UPDATE METHODS
  // ============================================

  // Edit Tenant Dialog
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

  // Create User and Tenant Dialog
  void initializeCreateUserAndTenantDialog() {
    _createUserEmail = '';
    _createUserPassword = '';
    _createUserFirstName = '';
    _createUserLastName = '';
    _createTenantName = '';
    _createTenantType = TenantTypes.clinic;
    _createTenantTimezone = 'Asia/Kolkata';
    _createUserPasswordObscure = true;
    _createUserAndTenantDialogOpen = true;
    notifyListeners();
  }

  void updateCreateUserEmail(String value) {
    _createUserEmail = value.trim();
    notifyListeners();
  }

  void updateCreateUserPassword(String value) {
    _createUserPassword = value;
    notifyListeners();
  }

  void updateCreateUserFirstName(String value) {
    _createUserFirstName = value.trim();
    notifyListeners();
  }

  void updateCreateUserLastName(String value) {
    _createUserLastName = value.trim();
    notifyListeners();
  }

  void updateCreateTenantName(String value) {
    _createTenantName = value.trim();
    notifyListeners();
  }

  void updateCreateTenantType(String value) {
    _createTenantType = value;
    notifyListeners();
  }

  void updateCreateTenantTimezone(String value) {
    _createTenantTimezone = value;
    notifyListeners();
  }

  void toggleCreateUserPasswordVisibility() {
    _createUserPasswordObscure = !_createUserPasswordObscure;
    notifyListeners();
  }

  void closeCreateUserAndTenantDialog() {
    _createUserAndTenantDialogOpen = false;
    _createUserEmail = '';
    _createUserPassword = '';
    _createUserFirstName = '';
    _createUserLastName = '';
    _createTenantName = '';
    _createTenantType = TenantTypes.clinic;
    _createTenantTimezone = 'Asia/Kolkata';
    _createUserPasswordObscure = true;
    notifyListeners();
  }

  // Create Tenant for Existing User Dialog
  void initializeCreateTenantForUserDialog() {
    _createTenantForUserTenantName = '';
    _createTenantForUserType = TenantTypes.clinic;
    _createTenantForUserTimezone = 'Asia/Kolkata';
    _createTenantForUserSelectedUserId = null;
    _createTenantForUserDialogOpen = true;
    notifyListeners();
  }

  void updateCreateTenantForUserTenantName(String value) {
    _createTenantForUserTenantName = value.trim();
    notifyListeners();
  }

  void updateCreateTenantForUserType(String value) {
    _createTenantForUserType = value;
    notifyListeners();
  }

  void updateCreateTenantForUserTimezone(String value) {
    _createTenantForUserTimezone = value;
    notifyListeners();
  }

  void updateCreateTenantForUserSelectedUserId(String? value) {
    _createTenantForUserSelectedUserId = value;
    notifyListeners();
  }

  void closeCreateTenantForUserDialog() {
    _createTenantForUserDialogOpen = false;
    _createTenantForUserTenantName = '';
    _createTenantForUserType = TenantTypes.clinic;
    _createTenantForUserTimezone = 'Asia/Kolkata';
    _createTenantForUserSelectedUserId = null;
    notifyListeners();
  }

  // ============================================
  // SUPER ADMIN - ALL TENANTS OPERATIONS (PAGINATED)
  // ============================================

  /// Load all tenants with pagination (Super Admin only)
  /// Set refresh=true to reload from page 1
  Future<void> loadAllTenants({
    int page = 1,
    int pageSize = 20,
    String? status,
    bool refresh = false,
  }) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return;
    }

    // Prevent duplicate loading
    if (_isLoading || _isLoadingMore) return;

    // If refresh, reset to page 1
    if (refresh) {
      _currentPage = 1;
      _allTenants = [];
    }

    final isFirstPage = page == 1;
    if (isFirstPage) {
      _isLoading = true;
    } else {
      _isLoadingMore = true;
    }
    _error = null;
    _statusFilter = status;
    notifyListeners();

    try {
      final response = await _apiService.getAllTenants(
        accessToken: _accessToken!,
        page: page,
        pageSize: pageSize,
        status: status,
        context: _context,
      );

      if (response.success && response.data != null) {
        final data = response.data!;

        if (isFirstPage) {
          _allTenants = data.tenants;
        } else {
          // Append for infinite scroll
          _allTenants = [..._allTenants, ...data.tenants];
        }

        _totalTenants = data.total;
        _currentPage = data.page;
        _pageSize = data.pageSize;
        _totalPages = data.totalPages;
      } else {
        _error = response.error ?? 'Failed to load tenants';
      }
    } catch (e) {
      _error = 'Failed to load tenants: $e';
    } finally {
      _isLoading = false;
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  /// Load next page of tenants
  Future<void> loadMoreTenants() async {
    if (!hasMorePages || _isLoadingMore) return;
    await loadAllTenants(
      page: _currentPage + 1,
      pageSize: _pageSize,
      status: _statusFilter,
    );
  }

  /// Refresh tenants list (reload from page 1)
  Future<void> refreshTenants({String? status}) async {
    await loadAllTenants(
      page: 1,
      pageSize: _pageSize,
      status: status,
      refresh: true,
    );
  }

  /// Filter tenants by status (server-side filtering)
  Future<void> filterByStatus(String? status) async {
    _statusFilter = status == 'all' ? null : status;
    _filterStatus = status ?? 'all';
    await loadAllTenants(
      page: 1,
      pageSize: _pageSize,
      status: _statusFilter,
      refresh: true,
    );
  }

  /// Update filter status (UI state only)
  void updateFilterStatus(String status) {
    _filterStatus = status;
    notifyListeners();
  }

  /// Mark initial load as complete
  void markInitialLoadComplete() {
    _isInitialLoad = false;
    notifyListeners();
  }

  /// Update search query
  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  /// Clear search query
  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  /// Search tenants by name or ID (client-side filtering)
  List<Tenant> searchTenants(String query) {
    if (query.isEmpty) {
      return _allTenants;
    }
    final lowerQuery = query.toLowerCase();
    return _allTenants.where((t) {
      final name = (t.name ?? '').toLowerCase();
      final id = (t.id ?? '').toLowerCase();
      final type = (t.type ?? '').toLowerCase();
      return name.contains(lowerQuery) ||
          id.contains(lowerQuery) ||
          type.contains(lowerQuery);
    }).toList();
  }

  /// Get filtered tenants based on current search query
  List<Tenant> get filteredTenants => searchTenants(_searchQuery);

  // ============================================
  // SUPER ADMIN - LIST USERS (For Dropdown)
  // ============================================

  /// Load available users for dropdown (Super Admin only)
  /// Users who are ADMINs and don't have a tenant yet
  Future<void> loadAvailableUsers({
    String? role,
    bool withoutTenant = true,
  }) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return;
    }

    _isLoadingUsers = true;
    notifyListeners();

    try {
      final response = await _apiService.listUsers(
        role: role ?? 'ADMIN',
        withoutTenant: withoutTenant,
        accessToken: _accessToken!,
        context: _context,
      );

      if (response.success && response.data != null) {
        _availableUsers = response.data!.users;
      } else {
        _availableUsers = [];
        // Don't show error for empty list
      }
    } catch (e) {
      _availableUsers = [];
    } finally {
      _isLoadingUsers = false;
      notifyListeners();
    }
  }

  /// Clear available users list
  void clearAvailableUsers() {
    _availableUsers = [];
    notifyListeners();
  }

  // ============================================
  // SUPER ADMIN - CREATE USER (Protected Endpoint)
  // ============================================

  /// Create a new user (Super Admin only)
  /// This must be called before creating a tenant for a new business owner
  Future<String?> createUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String role = 'ADMIN',
  }) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return null;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.createUser(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        role: role,
        accessToken: _accessToken!,
        context: _context,
      );

      if (response.success && response.data != null) {
        _successMessage = 'User created successfully';
        notifyListeners();
        return response.data!.id; // Return the new user's ID
      } else {
        _error = response.error ?? 'Failed to create user';
        notifyListeners();
        return null;
      }
    } catch (e) {
      _error = 'Failed to create user: $e';
      notifyListeners();
      return null;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  /// Create user and tenant together (Super Admin flow)
  /// Step 1: Create user
  /// Step 2: Create tenant with the new user's ID
  /// Step 3: Assign tenant to user
  Future<bool> createUserAndTenant({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String tenantName,
    required String tenantType,
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

    try {
      // Step 1: Create the user
      final userResponse = await _apiService.createUser(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        role: 'ADMIN',
        accessToken: _accessToken!,
        context: _context,
      );

      if (!userResponse.success || userResponse.data == null) {
        _error = userResponse.error ?? 'Failed to create user';
        _isSaving = false;
        notifyListeners();
        return false;
      }

      final newUserId = userResponse.data!.id;

      // Step 2: Create tenant for this user
      final tenantResponse = await _apiService.createTenant(
        name: tenantName,
        type: tenantType,
        ownerUserId: newUserId,
        timezone: timezone,
        accessToken: _accessToken!,
        context: _context,
      );

      if (!tenantResponse.success || tenantResponse.data == null) {
        _error =
            tenantResponse.error ?? 'User created but failed to create tenant';
        _isSaving = false;
        notifyListeners();
        return false;
      }

      final newTenantId = tenantResponse.data!.id ?? '';

      // Step 3: Assign tenant to user
      final assignResponse = await _apiService.assignTenantToUser(
        userId: newUserId,
        tenantId: newTenantId,
        accessToken: _accessToken!,
        context: _context,
      );

      _isSaving = false;

      if (assignResponse.success) {
        _successMessage = 'User, tenant created and assigned successfully';
        notifyListeners();
        return true;
      } else {
        // Tenant was created but assignment failed - still partial success
        _successMessage = 'User and tenant created, but assignment failed';
        _error = assignResponse.error;
        notifyListeners();
        return true; // Return true since tenant was created
      }
    } catch (e) {
      _error = 'Failed to create user and tenant: $e';
      _isSaving = false;
      notifyListeners();
      return false;
    }
  }

  /// Assign tenant to user (Super Admin only)
  Future<bool> assignTenantToUser({
    required String userId,
    required String tenantId,
  }) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.assignTenantToUser(
        userId: userId,
        tenantId: tenantId,
        accessToken: _accessToken!,
        context: _context,
      );

      _isSaving = false;

      if (response.success) {
        _successMessage = response.message ?? 'Tenant assigned successfully';
        notifyListeners();
        return true;
      } else {
        _error = response.error ?? 'Failed to assign tenant to user';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Failed to assign tenant: $e';
      _isSaving = false;
      notifyListeners();
      return false;
    }
  }

  // ============================================
  // SUPER ADMIN - TENANT OPERATIONS
  // ============================================

  /// Create a new tenant (Super Admin only)
  /// Returns the created tenant ID if successful, null otherwise
  Future<String?> createTenant({
    required String name,
    required String type,
    required String ownerUserId,
    required String timezone,
  }) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return null;
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
      _successMessage = 'Tenant created successfully';
      // Refresh tenants list
      await refreshTenants();
      notifyListeners();
      return response.data!.id;
    } else {
      _error = response.error ?? 'Failed to create tenant';
      notifyListeners();
      return null;
    }
  }

  /// Update tenant (Super Admin only)
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
      // Refresh tenants list
      await refreshTenants();
      notifyListeners();
      return true;
    } else {
      _error = response.error ?? 'Failed to update tenant';
      notifyListeners();
      return false;
    }
  }

  /// Delete tenant (Super Admin only)
  Future<bool> deleteTenant(String tenantId) async {
    if (_accessToken == null) {
      _error = 'Not authenticated';
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    final response = await _apiService.deleteTenant(
      tenantId: tenantId,
      accessToken: _accessToken!,
      context: _context,
    );

    _isSaving = false;

    if (response.success) {
      _successMessage = 'Tenant deleted successfully';
      // Refresh tenants list
      await refreshTenants();
      notifyListeners();
      return true;
    } else {
      _error = response.error ?? 'Failed to delete tenant';
      notifyListeners();
      return false;
    }
  }

  /// Create tenant for existing user using dialog state
  Future<bool> createTenantForUserFromDialog() async {
    if (_createTenantForUserTenantName.isEmpty) {
      _error = 'Organization name is required';
      notifyListeners();
      return false;
    }
    if (_createTenantForUserSelectedUserId == null) {
      _error = 'Please select a user';
      notifyListeners();
      return false;
    }

    // Create tenant and get the tenant ID
    final tenantId = await createTenant(
      name: _createTenantForUserTenantName,
      type: _createTenantForUserType,
      ownerUserId: _createTenantForUserSelectedUserId!,
      timezone: _createTenantForUserTimezone,
    );

    if (tenantId != null && tenantId.isNotEmpty) {
      // Assign tenant to user
      final assignSuccess = await assignTenantToUser(
        userId: _createTenantForUserSelectedUserId!,
        tenantId: tenantId,
      );
      closeCreateTenantForUserDialog();
      return assignSuccess;
    }

    return false;
  }

  /// Create user and tenant using dialog state
  Future<bool> createUserAndTenantFromDialog() async {
    if (_createUserEmail.isEmpty ||
        _createUserPassword.isEmpty ||
        _createUserFirstName.isEmpty ||
        _createUserLastName.isEmpty ||
        _createTenantName.isEmpty) {
      _error = 'Please fill all required fields';
      notifyListeners();
      return false;
    }

    final success = await createUserAndTenant(
      email: _createUserEmail,
      password: _createUserPassword,
      firstName: _createUserFirstName,
      lastName: _createUserLastName,
      tenantName: _createTenantName,
      tenantType: _createTenantType,
      timezone: _createTenantTimezone,
    );

    if (success) {
      closeCreateUserAndTenantDialog();
    }

    return success;
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
}
