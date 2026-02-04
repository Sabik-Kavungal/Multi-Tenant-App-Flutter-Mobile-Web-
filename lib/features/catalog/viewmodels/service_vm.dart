import 'package:flutter/material.dart';
import 'package:saasf/features/catalog/models/category_model.dart';
import 'package:saasf/features/catalog/models/service_model.dart';
import 'package:saasf/features/catalog/services/category_api_service.dart';
import 'package:saasf/features/catalog/services/service_api_service.dart';
import 'package:saasf/features/tenant/models/tenant_api_response_model.dart';

/// Service ViewModel – Catalog Service API
/// List, CRUD; form: category_id, name, description, booking_type,
/// duration_minutes (TIME), capacity (TOKEN/SEAT), price, is_active
class ServiceViewModel extends ChangeNotifier {
  final ServiceApiService _serviceApi;
  final CategoryApiService _categoryApi;

  List<Service> _services = [];
  String? _categoryIdFilter;
  bool? _isActiveFilter;

  bool _isLoading = false;
  bool _isSaving = false;
  bool _isLoadingCategories = false;

  List<Category> _categoriesForForm = [];

  String? _error;
  String? _successMessage;

  String _formCategoryId = '';
  String _formName = '';
  String _formDescription = '';
  String _formBookingType = BookingType.time;
  int? _formDurationMinutes;
  int? _formCapacity;
  double _formPrice = 0;
  bool _formIsActive = true;
  bool _isFormDialogOpen = false;
  String? _editingServiceId;

  BuildContext? _context;
  String? _accessToken;
  String? _tenantId;

  ServiceViewModel(this._serviceApi, this._categoryApi);

  List<Service> get services => _services;
  int get total => _services.length;
  String? get categoryIdFilter => _categoryIdFilter;
  bool? get isActiveFilter => _isActiveFilter;

  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  bool get isLoadingCategories => _isLoadingCategories;

  List<Category> get categoriesForForm => _categoriesForForm;

  String? get error => _error;
  String? get successMessage => _successMessage;

  String get formCategoryId => _formCategoryId;
  String get formName => _formName;
  String get formDescription => _formDescription;
  String get formBookingType => _formBookingType;
  int? get formDurationMinutes => _formDurationMinutes;
  int? get formCapacity => _formCapacity;
  double get formPrice => _formPrice;
  bool get formIsActive => _formIsActive;
  bool get isFormDialogOpen => _isFormDialogOpen;
  bool get isEditMode => _editingServiceId != null;

  String? getCategoryName(String? categoryId) {
    if (categoryId == null) return null;
    for (final c in _categoriesForForm) {
      if (c.id == categoryId) return c.name;
    }
    return null;
  }

  void initialize({
    required BuildContext context,
    required String accessToken,
    required String tenantId,
  }) {
    _context = context;
    _accessToken = accessToken;
    _tenantId = tenantId;
  }

  Future<void> loadCategoriesForForm() async {
    if (_accessToken == null || _tenantId == null) return;
    _isLoadingCategories = true;
    notifyListeners();

    final res = await _categoryApi.listCategories(
      tenantId: _tenantId!,
      isActive: true,
      accessToken: _accessToken!,
      context: _context,
    );

    _isLoadingCategories = false;
    if (res.success && res.data != null) {
      _categoriesForForm = res.data!;
    } else {
      _categoriesForForm = [];
    }
    notifyListeners();
  }

  Future<void> loadServices({String? categoryId, bool? isActive}) async {
    if (_accessToken == null || _tenantId == null) {
      _error = 'Not initialized.';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    _categoryIdFilter = categoryId;
    _isActiveFilter = isActive;
    notifyListeners();

    if (_categoriesForForm.isEmpty) await loadCategoriesForForm();

    final res = await _serviceApi.listServices(
      tenantId: _tenantId!,
      categoryId: categoryId,
      isActive: isActive,
      accessToken: _accessToken!,
      context: _context,
    );

    _isLoading = false;
    if (res.success && res.data != null) {
      _services = res.data!;
      _error = null;
    } else {
      _error = res.error ?? 'Failed to load services';
      _services = [];
    }
    notifyListeners();
  }

  Future<void> refreshServices() async {
    await loadServices(
      categoryId: _categoryIdFilter,
      isActive: _isActiveFilter,
    );
  }

  void openCreateDialog() {
    _editingServiceId = null;
    _formCategoryId =
        _categoriesForForm.isNotEmpty ? (_categoriesForForm.first.id ?? '') : '';
    _formName = '';
    _formDescription = '';
    _formBookingType = BookingType.time;
    _formDurationMinutes = 30;
    _formCapacity = 1;
    _formPrice = 0;
    _formIsActive = true;
    _isFormDialogOpen = true;
    _error = null;
    _successMessage = null;
    loadCategoriesForForm();
    notifyListeners();
  }

  void openEditDialog(Service s) {
    _editingServiceId = s.id;
    _formCategoryId = s.categoryId ?? '';
    _formName = s.name ?? '';
    _formDescription = s.description ?? '';
    _formBookingType = s.bookingType ?? BookingType.time;
    _formDurationMinutes = s.durationMinutes;
    _formCapacity = s.capacity;
    _formPrice = s.price ?? 0;
    _formIsActive = s.isActive ?? true;
    _isFormDialogOpen = true;
    _error = null;
    _successMessage = null;
    loadCategoriesForForm();
    notifyListeners();
  }

  void closeFormDialog() {
    _isFormDialogOpen = false;
    _editingServiceId = null;
    _error = null;
    _successMessage = null;
    notifyListeners();
  }

  void updateFormCategoryId(String v) {
    _formCategoryId = v;
    notifyListeners();
  }

  void updateFormName(String v) {
    _formName = v;
    notifyListeners();
  }

  void updateFormDescription(String v) {
    _formDescription = v;
    notifyListeners();
  }

  void updateFormBookingType(String v) {
    _formBookingType = v;
    notifyListeners();
  }

  void updateFormDurationMinutes(int? v) {
    _formDurationMinutes = v;
    notifyListeners();
  }

  void updateFormCapacity(int? v) {
    _formCapacity = v;
    notifyListeners();
  }

  void updateFormPrice(double v) {
    _formPrice = v;
    notifyListeners();
  }

  void updateFormIsActive(bool v) {
    _formIsActive = v;
    notifyListeners();
  }

  bool _validateForm() {
    if (_formCategoryId.isEmpty) {
      _error = 'Category is required';
      return false;
    }
    if (_formName.trim().isEmpty) {
      _error = 'Name is required';
      return false;
    }
    if (_formPrice < 0) {
      _error = 'Price must be ≥ 0';
      return false;
    }
    if (_formBookingType == BookingType.time) {
      if (_formDurationMinutes == null || _formDurationMinutes! <= 0) {
        _error = 'Duration (minutes) is required and must be > 0 for TIME';
        return false;
      }
    }
    if (_formBookingType == BookingType.token ||
        _formBookingType == BookingType.seat) {
      if (_formCapacity == null || _formCapacity! <= 0) {
        _error = 'Capacity is required and must be > 0 for TOKEN/SEAT';
        return false;
      }
    }
    return true;
  }

  Future<bool> createService() async {
    if (_accessToken == null || _tenantId == null) {
      _error = 'Not initialized.';
      notifyListeners();
      return false;
    }
    if (!_validateForm()) {
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    final req = CreateServiceRequest(
      categoryId: _formCategoryId,
      name: _formName.trim(),
      description:
          _formDescription.trim().isEmpty ? null : _formDescription.trim(),
      bookingType: _formBookingType,
      durationMinutes: _formBookingType == BookingType.time
          ? _formDurationMinutes
          : null,
      capacity: (_formBookingType == BookingType.token ||
              _formBookingType == BookingType.seat)
          ? _formCapacity
          : null,
      price: _formPrice,
      isActive: _formIsActive,
    );

    final res = await _serviceApi.createService(
      tenantId: _tenantId!,
      request: req,
      accessToken: _accessToken!,
      context: _context,
    );

    _isSaving = false;
    if (res.success && res.data != null) {
      _successMessage = res.message ?? 'Service created successfully';
      closeFormDialog();
      await refreshServices();
      return true;
    }
    _error = res.error ?? 'Failed to create service';
    notifyListeners();
    return false;
  }

  Future<bool> updateService() async {
    if (_accessToken == null || _tenantId == null || _editingServiceId == null) {
      _error = 'Not initialized or not in edit mode.';
      notifyListeners();
      return false;
    }
    if (!_validateForm()) {
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    final req = UpdateServiceRequest(
      categoryId: _formCategoryId,
      name: _formName.trim(),
      description:
          _formDescription.trim().isEmpty ? null : _formDescription.trim(),
      bookingType: _formBookingType,
      durationMinutes: _formBookingType == BookingType.time
          ? _formDurationMinutes
          : null,
      capacity: (_formBookingType == BookingType.token ||
              _formBookingType == BookingType.seat)
          ? _formCapacity
          : null,
      price: _formPrice,
      isActive: _formIsActive,
    );

    final res = await _serviceApi.updateService(
      tenantId: _tenantId!,
      serviceId: _editingServiceId!,
      request: req,
      accessToken: _accessToken!,
      context: _context,
    );

    _isSaving = false;
    if (res.success && res.data != null) {
      _successMessage = res.message ?? 'Service updated successfully';
      closeFormDialog();
      await refreshServices();
      return true;
    }
    _error = res.error ?? 'Failed to update service';
    notifyListeners();
    return false;
  }

  Future<bool> deleteService(String serviceId) async {
    if (_accessToken == null || _tenantId == null) {
      _error = 'Not initialized.';
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    final res = await _serviceApi.deleteService(
      tenantId: _tenantId!,
      serviceId: serviceId,
      accessToken: _accessToken!,
      context: _context,
    );

    _isSaving = false;
    if (res.success) {
      _successMessage = res.message ?? 'Service deleted successfully';
      await refreshServices();
      return true;
    }
    _error = res.error ?? 'Failed to delete service';
    notifyListeners();
    return false;
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearSuccessMessage() {
    _successMessage = null;
    notifyListeners();
  }
}
