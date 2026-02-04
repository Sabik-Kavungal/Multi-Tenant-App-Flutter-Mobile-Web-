import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/constants/constants.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';
import 'package:saasf/features/booking/models/booking_model.dart';
import 'package:saasf/features/booking/viewmodels/booking_vm.dart';
import 'package:saasf/features/catalog/models/service_model.dart';

/// Create booking – Catalog GET /services for dropdown, POST /bookings.
/// Service (required), Type (from service), Date/Start/End (when TIME), Quantity.
class CreateBookingPage extends StatefulWidget {
  const CreateBookingPage({super.key});

  @override
  State<CreateBookingPage> createState() => _CreateBookingPageState();
}

class _CreateBookingPageState extends State<CreateBookingPage> {
  bool _init = false;
  Service? _selectedService;
  String _bookingDate = '';
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  int _quantity = 1;

  bool get _isTime => _selectedService?.bookingType == BookingType.time;

  /// Route args: { 'tenantId': String?, 'serviceId': String? } for CUSTOMER flow from BusinessDetail.
  Map<String, String?>? get _args {
    final a = ModalRoute.of(context)?.settings.arguments;
    if (a is Map) return Map<String, String?>.from(a);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthViewModel, BookingViewModel>(
      builder: (context, authVm, vm, _) {
        final accessToken = authVm.token?.accessToken;
        final tenantIdFromAuth = authVm.user?.tenantId;
        final tenantIdFromArgs = _args?['tenantId'];
        final tenantId = tenantIdFromArgs ?? tenantIdFromAuth;
        final preServiceId = _args?['serviceId'];

        if (accessToken != null && !_init) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            vm.initialize(
              context: context,
              accessToken: accessToken,
              tenantId: tenantId,
            );
            vm.loadServices();
            _init = true;
          });
        }

        // Preselect service when from BusinessDetail (serviceId in args) and services loaded
        if (preServiceId != null && preServiceId.isNotEmpty && _selectedService?.id != preServiceId && vm.services.isNotEmpty) {
          for (final s in vm.services) {
            if (s.id == preServiceId) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) setState(() => _selectedService = s);
              });
              break;
            }
          }
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: const Text('New booking'),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (vm.createSuccess != null) _successBanner(vm),
                if (vm.createError != null) _errorBanner(vm),
                if (vm.servicesError != null && tenantId == null) _tenantRequired(),
                _serviceDropdown(vm),
                if (_selectedService != null) ...[
                  const SizedBox(height: 8),
                  _readOnly('Booking type', BookingType.getDisplayName(_selectedService!.bookingType ?? '')),
                ],
                if (_isTime) ...[
                  const SizedBox(height: 16),
                  _dateField(),
                  const SizedBox(height: 16),
                  _timeField('Start time', true, (v) => setState(() => _startTime = v)),
                  const SizedBox(height: 16),
                  _timeField('End time (optional)', false, (v) => setState(() => _endTime = v)),
                ],
                const SizedBox(height: 16),
                _quantityField(),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _canSubmit(vm) && !vm.createLoading
                      ? () => _submit(vm)
                      : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: vm.createLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Create booking'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _successBanner(BookingViewModel vm) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.successLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.success.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppColors.success, size: 24),
          const SizedBox(width: 12),
          Expanded(child: Text(vm.createSuccess!, style: const TextStyle(color: AppColors.success))),
          TextButton(
            onPressed: () {
              vm.clearCreateSuccess();
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Widget _errorBanner(BookingViewModel vm) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.errorLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppColors.error),
          const SizedBox(width: 12),
          Expanded(child: Text(vm.createError!, style: const TextStyle(color: AppColors.error))),
          TextButton(onPressed: vm.clearError, child: const Text('Dismiss')),
        ],
      ),
    );
  }

  Widget _tenantRequired() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.warningLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Tenant context is required to load services. Please ensure you are linked to a business.',
        style: TextStyle(color: AppColors.textPrimary),
      ),
    );
  }

  Widget _serviceDropdown(BookingViewModel vm) {
    final items = vm.services;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Service', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        DropdownButtonFormField<Service>(
          value: _selectedService,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
          hint: Text(vm.servicesLoading ? 'Loading…' : 'Select service'),
          items: items
              .map((s) => DropdownMenuItem(
                    value: s,
                    child: Text(s.name ?? s.id ?? '—'),
                  ))
              .toList(),
          onChanged: vm.servicesLoading
              ? null
              : (s) {
                  setState(() {
                    _selectedService = s;
                    if (s?.bookingType != BookingType.time) {
                      _bookingDate = '';
                      _startTime = null;
                      _endTime = null;
                    }
                  });
                },
        ),
      ],
    );
  }

  Widget _readOnly(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(label, style: const TextStyle(color: AppColors.textHint, fontSize: 14)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(value, style: const TextStyle(fontSize: 14, color: AppColors.textPrimary)),
        ),
      ],
    );
  }

  Widget _dateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Date', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        InkWell(
          onTap: () async {
            final d = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (d != null) {
              setState(() => _bookingDate = '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}');
            }
          },
          child: InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            child: Text(_bookingDate.isEmpty ? 'Pick date' : _bookingDate),
          ),
        ),
      ],
    );
  }

  Widget _timeField(String label, bool required, void Function(TimeOfDay?) onPick) {
    final v = label.startsWith('Start') ? _startTime : _endTime;
    final str = v == null ? '' : '${v.hour.toString().padLeft(2, '0')}:${v.minute.toString().padLeft(2, '0')}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        InkWell(
          onTap: () async {
            final t = await showTimePicker(
              context: context,
              initialTime: v ?? const TimeOfDay(hour: 9, minute: 0),
            );
            if (t != null) onPick(t);
          },
          child: InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            child: Text(str.isEmpty ? (required ? 'Pick time' : 'Optional') : str),
          ),
        ),
      ],
    );
  }

  Widget _quantityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quantity', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        Row(
          children: [
            IconButton.filled(
              onPressed: _quantity <= 1 ? null : () => setState(() => _quantity = (_quantity - 1).clamp(1, 999)),
              icon: const Icon(Icons.remove, size: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('$_quantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ),
            IconButton.filled(
              onPressed: () => setState(() => _quantity = (_quantity + 1).clamp(1, 999)),
              icon: const Icon(Icons.add, size: 20),
            ),
          ],
        ),
      ],
    );
  }

  bool _canSubmit(BookingViewModel vm) {
    if (_selectedService == null || _selectedService!.id == null) return false;
    if (_isTime) {
      if (_bookingDate.isEmpty) return false;
      if (_startTime == null) return false;
    }
    return true;
  }

  void _submit(BookingViewModel vm) {
    final s = _selectedService!;
    String? startStr;
    String? endStr;
    if (_startTime != null) {
      startStr = '${_startTime!.hour.toString().padLeft(2, '0')}:${_startTime!.minute.toString().padLeft(2, '0')}';
    }
    if (_endTime != null) {
      endStr = '${_endTime!.hour.toString().padLeft(2, '0')}:${_endTime!.minute.toString().padLeft(2, '0')}';
    }
    final req = CreateBookingRequest(
      serviceId: s.id!,
      bookingType: s.bookingType ?? BookingType.time,
      bookingDate: _bookingDate.isEmpty ? null : _bookingDate,
      startTime: startStr,
      endTime: endStr,
      quantity: _quantity,
    );
    vm.submitCreate(req).then((ok) {
      if (ok && mounted) {
        // Success banner is shown; user can tap Done or form stays to create another
      }
    });
  }
}
