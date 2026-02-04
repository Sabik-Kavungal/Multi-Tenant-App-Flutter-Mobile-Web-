import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/constants/constants.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';
import 'package:saasf/features/booking/models/booking_model.dart';
import 'package:saasf/features/booking/viewmodels/booking_vm.dart';
import 'package:saasf/features/catalog/models/service_model.dart';

/// Booking detail – GET /bookings/:id. Cancel, Complete.
class BookingDetailPage extends StatefulWidget {
  const BookingDetailPage({super.key});

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  String? _id;
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    String? id;
    String? tenantIdFromArgs;
    if (args is String) {
      id = args;
    } else if (args is Map) {
      id = args['id'] as String?;
      tenantIdFromArgs = args['tenantId'] as String?;
    }
    if (id != null && _id != id) {
      _id = id;
      _loaded = false;
    }

    return Consumer2<AuthViewModel, BookingViewModel>(
      builder: (context, authVm, vm, _) {
        final accessToken = authVm.token?.accessToken;
        final tenantIdFromAuth = authVm.user?.tenantId;
        final tenantId = tenantIdFromArgs ?? tenantIdFromAuth;

        if (accessToken != null && _id != null && !_loaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            vm.initialize(
              context: context,
              accessToken: accessToken,
              tenantId: tenantId,
            );
            vm.loadDetail(_id!);
            if (tenantId != null && tenantId.isNotEmpty) vm.loadServices();
            _loaded = true;
          });
        }

        if (_id == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Booking'), backgroundColor: AppColors.primary),
            body: const Center(child: Text('Invalid booking id')),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: Text('Booking ${_id!.length > 8 ? '${_id!.substring(0, 8)}…' : _id}'),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: vm.detailLoading
              ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
              : vm.detailError != null
                  ? _error(context, vm)
                  : vm.selectedBooking != null
                      ? _content(context, vm.selectedBooking!, vm)
                      : const Center(child: Text('Not found')),
        );
      },
    );
  }

  Widget _error(BuildContext context, BookingViewModel vm) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 16),
            Text(
              vm.detailError!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to list'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _content(BuildContext context, Booking b, BookingViewModel vm) {
    final canAct = BookingStatus.canCancelOrComplete(b.status);
    final serviceName = _serviceName(b.serviceId, vm);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        serviceName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _statusColor(b.status).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        BookingStatus.getDisplayName(b.status ?? ''),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _statusColor(b.status),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                _row('Type', BookingType.getDisplayName(b.bookingType ?? '')),
                if (b.bookingDate != null) _row('Date', b.bookingDate!),
                if (b.startTime != null) _row('Start', b.startTime!),
                if (b.endTime != null) _row('End', b.endTime!),
                _row('Quantity', '${b.quantity ?? 1}'),
                if (b.createdAt != null) _row('Created', _formatDate(b.createdAt)),
                if (b.updatedAt != null) _row('Updated', _formatDate(b.updatedAt)),
              ],
            ),
          ),
          if (canAct) ...[
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: vm.isActionLoading(b.id ?? '')
                        ? null
                        : () => _cancel(context, b.id!, vm),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                    ),
                    child: const Text('Cancel booking'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: vm.isActionLoading(b.id ?? '')
                        ? null
                        : () => _complete(context, b.id!, vm),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Complete'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textHint,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
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
    return id;
  }

  String _formatDate(String? iso) {
    if (iso == null || iso.isEmpty) return '—';
    try {
      final d = DateTime.parse(iso);
      return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')} ${d.hour.toString().padLeft(2,'0')}:${d.minute.toString().padLeft(2,'0')}';
    } catch (_) {
      return iso;
    }
  }

  Future<void> _cancel(BuildContext context, String id, BookingViewModel vm) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Cancel booking'),
        content: const Text('Are you sure you want to cancel this booking?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('No')),
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
        if (done) Navigator.pop(context);
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
      if (done) Navigator.pop(context);
    }
  }
}
