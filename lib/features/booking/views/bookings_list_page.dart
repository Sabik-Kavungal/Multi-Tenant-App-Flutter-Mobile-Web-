import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/constants/constants.dart';
import 'package:saasf/core/constants/roles.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';
import 'package:saasf/features/booking/models/booking_model.dart';
import 'package:saasf/features/booking/viewmodels/booking_vm.dart';
import 'package:saasf/features/catalog/models/service_model.dart';
import 'package:saasf/features/customer/services/customer_api_service.dart';
import 'package:saasf/features/tenant/models/tenant_model.dart';

/// Bookings list – GET /bookings with X-Tenant-ID. View, Cancel, Complete. Navigate to detail and create.
/// For CUSTOMER: business selector, filter by user_id; X-Tenant-ID from selected business.
class BookingsListPage extends StatefulWidget {
  const BookingsListPage({super.key});

  @override
  State<BookingsListPage> createState() => _BookingsListPageState();
}

class _BookingsListPageState extends State<BookingsListPage> {
  bool _init = false;
  final CustomerApiService _customerApi = CustomerApiService();
  List<Tenant> _tenants = [];
  String? _selectedTenantId;
  bool _loadingTenants = false;

  Future<void> _loadTenants() async {
    final authVm = context.read<AuthViewModel>();
    final t = authVm.token?.accessToken;
    if (t == null) return;
    setState(() => _loadingTenants = true);
    final r = await _customerApi.browseTenants(
      accessToken: t,
      context: context,
      page: 1,
      pageSize: 200,
      status: 'ACTIVE',
    );
    if (mounted) {
      setState(() {
        _loadingTenants = false;
        _tenants = (r.success && r.data != null) ? r.data!.tenants : [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthViewModel, BookingViewModel>(
      builder: (context, authVm, vm, _) {
        final accessToken = authVm.token?.accessToken;
        final tenantId = authVm.user?.tenantId;
        final isCustomer = Roles.isCustomer(authVm.user?.role);
        final effectiveTenantId = isCustomer ? _selectedTenantId : tenantId;

        if (accessToken != null && !_init) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            vm.initialize(
              context: context,
              accessToken: accessToken,
              tenantId: isCustomer ? null : tenantId,
            );
            if (isCustomer) {
              _loadTenants();
            } else {
              vm.loadBookings();
              if (tenantId != null && tenantId.isNotEmpty) vm.loadServices();
            }
            _init = true;
          });
        }

        final items = isCustomer
            ? vm.items.where((b) => b.userId == authVm.user?.id).toList()
            : vm.items;
        final count = items.length;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: const Text('Bookings'),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  if (isCustomer && _selectedTenantId != null) {
                    vm.setTenantId(_selectedTenantId);
                    vm.loadBookings();
                    vm.loadServices();
                  } else if (!isCustomer) {
                    vm.loadBookings();
                    if (tenantId != null) vm.loadServices();
                  }
                },
                tooltip: 'Refresh',
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: (isCustomer && _selectedTenantId == null)
                ? null
                : () {
                    if (isCustomer) {
                      Navigator.pushNamed(context, '/bookings/create', arguments: <String, String?>{'tenantId': _selectedTenantId});
                    } else {
                      Navigator.pushNamed(context, '/bookings/create');
                    }
                  },
            backgroundColor: AppColors.primary,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'New booking',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          body: _body(isCustomer, effectiveTenantId, vm, authVm, items, count),
        );
      },
    );
  }

  Widget _body(bool isCustomer, String? effectiveTenantId, BookingViewModel vm, AuthViewModel authVm, List<Booking> items, int count) {
    if (isCustomer && _selectedTenantId == null) {
      return _customerSelectBusiness(vm);
    }
    if (vm.loading && items.isEmpty) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (vm.error != null) _errorBanner(vm),
        if (isCustomer && _selectedTenantId != null) _customerBusinessChip(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Text(
            '$count ${count == 1 ? 'booking' : 'bookings'}',
            style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
        ),
        Expanded(
          child: items.isEmpty
              ? _empty(context, isCustomer)
              : RefreshIndicator(
                  onRefresh: () => vm.loadBookings(),
                  color: AppColors.primary,
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                    itemCount: items.length,
                    itemBuilder: (_, i) => _card(context, items[i], vm, isCustomer: isCustomer),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _customerSelectBusiness(BookingViewModel vm) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Select a business to view your bookings',
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          if (_loadingTenants)
            const Center(child: CircularProgressIndicator(color: AppColors.primary))
          else if (_tenants.isEmpty)
            const Text('No businesses available', style: TextStyle(fontSize: 14, color: AppColors.textHint))
          else
            ..._tenants.map((t) => ListTile(
                  title: Text(t.name ?? '—'),
                  subtitle: Text(TenantTypes.getDisplayName(t.type ?? 'OTHER')),
                  onTap: t.id != null && t.id!.isNotEmpty
                      ? () {
                          setState(() => _selectedTenantId = t.id);
                          vm.setTenantId(t.id);
                          vm.loadBookings();
                          vm.loadServices();
                        }
                      : null,
                )),
        ],
      ),
    );
  }

  Widget _customerBusinessChip() {
    String name = _selectedTenantId ?? '—';
    for (final t in _tenants) {
      if (t.id == _selectedTenantId) { name = t.name ?? name; break; }
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          Icon(Icons.store, size: 18, color: AppColors.textHint),
          const SizedBox(width: 8),
          Expanded(child: Text(name, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary))),
          TextButton(
            onPressed: () => setState(() => _selectedTenantId = null),
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }

  Widget _errorBanner(BookingViewModel vm) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: AppColors.errorLight,
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppColors.error, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              vm.error!,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.error,
              ),
            ),
          ),
          TextButton(
            onPressed: vm.clearError,
            child: const Text('Dismiss'),
          ),
        ],
      ),
    );
  }

  Widget _empty(BuildContext context, bool isCustomer) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today_outlined, size: 64, color: AppColors.textHint),
          const SizedBox(height: 16),
          const Text(
            'No bookings yet',
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () {
              if (isCustomer) {
                Navigator.pushNamed(context, '/bookings/create', arguments: <String, String?>{'tenantId': _selectedTenantId});
              } else {
                Navigator.pushNamed(context, '/bookings/create');
              }
            },
            icon: const Icon(Icons.add),
            label: const Text('Create booking'),
          ),
        ],
      ),
    );
  }

  Widget _card(
    BuildContext context,
    Booking b,
    BookingViewModel vm, {
    bool isCustomer = false,
  }) {
    final statusColor = _statusColor(b.status);
    final canAct = BookingStatus.canCancelOrComplete(b.status);
    final serviceName = _serviceName(b.serviceId, vm);
    final showComplete = !isCustomer; // CUSTOMER: only Cancel; staff may complete

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: b.id != null
            ? () => Navigator.pushNamed(
                  context,
                  '/booking-detail',
                  arguments: <String, String?>{'id': b.id, 'tenantId': b.tenantId},
                )
            : null,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      serviceName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      BookingStatus.getDisplayName(b.status ?? ''),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 4,
                children: [
                  _chip(Icons.category_outlined, BookingType.getDisplayName(b.bookingType ?? '')),
                  if (b.bookingDate != null) _chip(Icons.calendar_today, b.bookingDate!),
                  if (b.startTime != null) _chip(Icons.access_time, '${b.startTime}${b.endTime != null ? '–${b.endTime}' : ''}'),
                  _chip(Icons.confirmation_number, 'Qty ${b.quantity ?? 1}'),
                ],
              ),
              if (canAct && b.id != null) ...[
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: vm.isActionLoading(b.id!)
                          ? null
                          : () => _cancel(context, b.id!, vm),
                      child: const Text('Cancel'),
                    ),
                    if (showComplete) ...[
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: vm.isActionLoading(b.id!)
                            ? null
                            : () => _complete(context, b.id!, vm),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Complete'),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textHint),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Color _statusColor(String? s) {
    switch (s) {
      case BookingStatus.completed:
        return AppColors.success;
      case BookingStatus.cancelled:
        return AppColors.textSecondary;
      case BookingStatus.created:
      case BookingStatus.confirmed:
        return AppColors.info;
      default:
        return AppColors.textSecondary;
    }
  }

  String _serviceName(String? id, BookingViewModel vm) {
    if (id == null || id.isEmpty) return '—';
    for (final s in vm.services) {
      if (s.id == id) return s.name ?? id;
    }
    return id.length > 12 ? '${id.substring(0, 8)}…' : id;
  }

  Future<void> _cancel(BuildContext context, String id, BookingViewModel vm) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Cancel booking'),
        content: const Text(
          'Are you sure you want to cancel this booking?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Yes, cancel'),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      final done = await vm.cancelBooking(id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(done ? 'Booking cancelled' : 'Could not cancel'),
            backgroundColor: done ? AppColors.success : AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _complete(BuildContext context, String id, BookingViewModel vm) async {
    final done = await vm.completeBooking(id);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(done ? 'Booking completed' : 'Could not complete'),
          backgroundColor: done ? AppColors.success : AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
