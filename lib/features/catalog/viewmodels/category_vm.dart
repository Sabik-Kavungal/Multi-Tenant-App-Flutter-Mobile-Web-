import 'package:flutter/material.dart';
import 'package:saasf/features/catalog/models/category_model.dart';
import 'package:saasf/features/catalog/services/category_api_service.dart';
import 'package:saasf/features/tenant/models/tenant_api_response_model.dart';

/// Category ViewModel – Catalog Service API
/// List (no pagination), CRUD, form: name, is_active
class CategoryViewModel extends ChangeNotifier {
  final CategoryApiService _apiService;

  List<Category> _categories = [];
  bool? _isActiveFilter;

  bool _isLoading = false;
  bool _isSaving = false;

  String? _error;
  String? _successMessage;

  String _formName = '';
  bool _formIsActive = true;
  bool _isFormDialogOpen = false;
  String? _editingCategoryId;

  BuildContext? _context;
  String? _accessToken;
  String? _tenantId;

  CategoryViewModel(this._apiService);

  List<Category> get categories => _categories;
  int get totalCategories => _categories.length;
  bool? get isActiveFilter => _isActiveFilter;

  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;

  String? get error => _error;
  String? get successMessage => _successMessage;

  String get formName => _formName;
  bool get formIsActive => _formIsActive;
  bool get isFormDialogOpen => _isFormDialogOpen;
  bool get isEditMode => _editingCategoryId != null;

  void initialize({
    required BuildContext context,
    required String accessToken,
    required String tenantId,
  }) {
    _context = context;
    _accessToken = accessToken;
    _tenantId = tenantId;
  }

  Future<void> loadCategories({bool? isActive}) async {
    if (_accessToken == null || _tenantId == null) {
      _error = 'Not initialized. Call initialize() first.';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    _isActiveFilter = isActive;
    notifyListeners();

    final response = await _apiService.listCategories(
      tenantId: _tenantId!,
      isActive: isActive,
      accessToken: _accessToken!,
      context: _context,
    );

    _isLoading = false;
    if (response.success && response.data != null) {
      _categories = response.data!;
      _error = null;
    } else {
      _error = response.error ?? 'Failed to load categories';
      _categories = [];
    }
    notifyListeners();
  }

  Future<void> refreshCategories() async {
    await loadCategories(isActive: _isActiveFilter);
  }

  Future<Category?> getCategory(String categoryId) async {
    if (_accessToken == null || _tenantId == null) return null;
    final response = await _apiService.getCategory(
      tenantId: _tenantId!,
      categoryId: categoryId,
      accessToken: _accessToken!,
      context: _context,
    );
    if (response.success) return response.data;
    _error = response.error;
    notifyListeners();
    return null;
  }

  void openCreateDialog() {
    _editingCategoryId = null;
    _formName = '';
    _formIsActive = true;
    _isFormDialogOpen = true;
    _error = null;
    _successMessage = null;
    notifyListeners();
  }

  void openEditDialog(Category category) {
    _editingCategoryId = category.id;
    _formName = category.name ?? '';
    _formIsActive = category.isActive ?? true;
    _isFormDialogOpen = true;
    _error = null;
    _successMessage = null;
    notifyListeners();
  }

  void closeFormDialog() {
    _isFormDialogOpen = false;
    _editingCategoryId = null;
    _error = null;
    _successMessage = null;
    notifyListeners();
  }

  void updateFormName(String value) {
    _formName = value;
    notifyListeners();
  }

  void updateFormIsActive(bool value) {
    _formIsActive = value;
    notifyListeners();
  }

  Future<bool> createCategory() async {
    if (_accessToken == null || _tenantId == null) {
      _error = 'Not initialized. Call initialize() first.';
      notifyListeners();
      return false;
    }
    if (_formName.trim().isEmpty) {
      _error = 'Category name is required';
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    final request = CreateCategoryRequest(
      name: _formName.trim(),
      isActive: _formIsActive,
    );

    final response = await _apiService.createCategory(
      tenantId: _tenantId!,
      request: request,
      accessToken: _accessToken!,
      context: _context,
    );

    _isSaving = false;
    if (response.success && response.data != null) {
      _successMessage = response.message ?? 'Category created successfully';
      closeFormDialog();
      await refreshCategories();
      return true;
    }
    _error = response.error ?? 'Failed to create category';
    notifyListeners();
    return false;
  }

  Future<bool> updateCategory() async {
    if (_accessToken == null || _tenantId == null || _editingCategoryId == null) {
      _error = 'Not initialized or not in edit mode.';
      notifyListeners();
      return false;
    }
    if (_formName.trim().isEmpty) {
      _error = 'Category name is required';
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    final request = UpdateCategoryRequest(
      name: _formName.trim(),
      isActive: _formIsActive,
    );

    final response = await _apiService.updateCategory(
      tenantId: _tenantId!,
      categoryId: _editingCategoryId!,
      request: request,
      accessToken: _accessToken!,
      context: _context,
    );

    _isSaving = false;
    if (response.success && response.data != null) {
      _successMessage = response.message ?? 'Category updated successfully';
      closeFormDialog();
      await refreshCategories();
      return true;
    }
    _error = response.error ?? 'Failed to update category';
    notifyListeners();
    return false;
  }

  Future<bool> deleteCategory(String categoryId) async {
    if (_accessToken == null || _tenantId == null) {
      _error = 'Not initialized. Call initialize() first.';
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    final response = await _apiService.deleteCategory(
      tenantId: _tenantId!,
      categoryId: categoryId,
      accessToken: _accessToken!,
      context: _context,
    );

    _isSaving = false;
    if (response.success) {
      _successMessage = response.message ?? 'Category deleted successfully';
      await refreshCategories();
      return true;
    }
    _error = response.error ?? 'Failed to delete category';
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
