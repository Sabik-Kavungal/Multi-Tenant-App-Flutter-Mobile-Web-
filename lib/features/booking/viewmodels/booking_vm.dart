import 'package:flutter/material.dart';
import 'package:saasf/features/booking/models/booking_model.dart';
import 'package:saasf/features/booking/services/booking_api_service.dart';
import 'package:saasf/features/catalog/models/service_model.dart';
import 'package:saasf/features/catalog/services/service_api_service.dart';

/// Booking ViewModel – Booking Service API + Catalog (services for create form)
class BookingViewModel extends ChangeNotifier {
  final BookingApiService _bookingApi;
  final ServiceApiService _serviceApi;

  BuildContext? _context;
  String? _accessToken;
  String? _tenantId;

  List<Booking> _items = [];
  int _total = 0;
  bool _loading = false;
  String? _error;

  Booking? _selectedBooking;
  bool _detailLoading = false;
  String? _detailError;

  bool _createLoading = false;
  String? _createError;
  String? _createSuccess;

  String? _actionLoadingId; // id for cancel/complete in progress

  List<Service> _services = [];
  bool _servicesLoading = false;
  String? _servicesError;

  BookingViewModel(this._bookingApi, this._serviceApi);

  List<Booking> get items => _items;
  int get total => _total;
  bool get loading => _loading;
  String? get error => _error;

  Booking? get selectedBooking => _selectedBooking;
  bool get detailLoading => _detailLoading;
  String? get detailError => _detailError;

  bool get createLoading => _createLoading;
  String? get createError => _createError;
  String? get createSuccess => _createSuccess;

  bool isActionLoading(String id) => _actionLoadingId == id;

  List<Service> get services => _services;
  bool get servicesLoading => _servicesLoading;
  String? get servicesError => _servicesError;

  void initialize({
    required BuildContext context,
    required String accessToken,
    String? tenantId,
  }) {
    _context = context;
    _accessToken = accessToken;
    _tenantId = tenantId;
  }

  /// Update tenant context (e.g. when CUSTOMER selects a business).
  void setTenantId(String? tenantId) {
    _tenantId = tenantId;
    notifyListeners();
  }

  Future<void> loadBookings({int limit = 20, int offset = 0}) async {
    if (_accessToken == null) return;
    _loading = true;
    _error = null;
    notifyListeners();

    final res = await _bookingApi.list(
      limit: limit,
      offset: offset,
      accessToken: _accessToken!,
      context: _context,
      xTenantId: _tenantId,
    );

    _loading = false;
    if (res.success && res.data != null) {
      _items = res.data!.items;
      _total = res.data!.total;
      _error = null;
    } else {
      _items = [];
      _total = 0;
      _error = res.error ?? 'Failed to load bookings';
    }
    notifyListeners();
  }

  Future<void> loadDetail(String id) async {
    if (_accessToken == null) return;
    _detailLoading = true;
    _detailError = null;
    _selectedBooking = null;
    notifyListeners();

    final res = await _bookingApi.getById(
      id: id,
      accessToken: _accessToken!,
      context: _context,
      xTenantId: _tenantId,
    );

    _detailLoading = false;
    if (res.success && res.data != null) {
      _selectedBooking = res.data;
      _detailError = null;
    } else {
      _selectedBooking = null;
      _detailError = res.error ?? 'Failed to load booking';
    }
    notifyListeners();
  }

  void clearDetail() {
    _selectedBooking = null;
    _detailError = null;
    notifyListeners();
  }

  Future<bool> submitCreate(CreateBookingRequest request) async {
    if (_accessToken == null) return false;
    _createLoading = true;
    _createError = null;
    _createSuccess = null;
    notifyListeners();

    final res = await _bookingApi.create(
      request: request,
      accessToken: _accessToken!,
      context: _context,
      xTenantId: _tenantId,
    );

    _createLoading = false;
    if (res.success && res.data != null) {
      _createError = null;
      _createSuccess = res.message ?? 'Booking created';
      _items = [res.data!, ..._items];
      _total = _total + 1;
      notifyListeners();
      return true;
    } else {
      _createError = res.error ?? 'Failed to create booking';
      _createSuccess = null;
      notifyListeners();
      return false;
    }
  }

  Future<bool> cancelBooking(String id) async {
    if (_accessToken == null) return false;
    _actionLoadingId = id;
    notifyListeners();

    final res = await _bookingApi.cancel(
      id: id,
      accessToken: _accessToken!,
      context: _context,
      xTenantId: _tenantId,
    );

    _actionLoadingId = null;
    if (res.success) {
      final idx = _items.indexWhere((e) => e.id == id);
      if (idx >= 0) {
        final b = _items[idx];
        _items = [..._items]..[idx] = b.copyWith(status: BookingStatus.cancelled);
      }
      if (_selectedBooking?.id == id) {
        _selectedBooking = _selectedBooking!.copyWith(status: BookingStatus.cancelled);
      }
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  Future<bool> completeBooking(String id) async {
    if (_accessToken == null) return false;
    _actionLoadingId = id;
    notifyListeners();

    final res = await _bookingApi.complete(
      id: id,
      accessToken: _accessToken!,
      context: _context,
      xTenantId: _tenantId,
    );

    _actionLoadingId = null;
    if (res.success) {
      final idx = _items.indexWhere((e) => e.id == id);
      if (idx >= 0) {
        final b = _items[idx];
        _items = [..._items]..[idx] = b.copyWith(status: BookingStatus.completed);
      }
      if (_selectedBooking?.id == id) {
        _selectedBooking = _selectedBooking!.copyWith(status: BookingStatus.completed);
      }
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  Future<void> loadServices() async {
    if (_accessToken == null || _tenantId == null || _tenantId!.isEmpty) {
      _services = [];
      _servicesError = 'Tenant context required to load services';
      notifyListeners();
      return;
    }
    _servicesLoading = true;
    _servicesError = null;
    notifyListeners();

    final res = await _serviceApi.listServices(
      tenantId: _tenantId!,
      isActive: true,
      accessToken: _accessToken!,
      context: _context,
    );

    _servicesLoading = false;
    if (res.success && res.data != null) {
      _services = res.data!;
      _servicesError = null;
    } else {
      _services = [];
      _servicesError = res.error ?? 'Failed to load services';
    }
    notifyListeners();
  }

  void clearError() {
    _error = null;
    _detailError = null;
    _createError = null;
    _servicesError = null;
    notifyListeners();
  }

  void clearCreateSuccess() {
    _createSuccess = null;
    notifyListeners();
  }
}
