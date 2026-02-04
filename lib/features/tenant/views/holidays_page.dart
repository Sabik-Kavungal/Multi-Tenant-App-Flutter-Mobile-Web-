import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/constants/constants.dart';
import 'package:intl/intl.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';
import 'package:saasf/features/tenant/viewmodels/holidays_vm.dart';
import 'package:saasf/features/tenant/models/holiday_model.dart';

/// Holidays Page
/// STRICT MVVM: UI is purely presentational - zero business logic
class HolidaysPage extends StatelessWidget {
  const HolidaysPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthViewModel, HolidaysViewModel>(
      builder: (context, authVm, vm, _) {
        // Initialize on first build
        // STRICT MVVM: UI only triggers ViewModel method, ViewModel handles all logic
        final tenantId = authVm.user?.tenantId;
        if (tenantId != null && tenantId.isNotEmpty && !vm.isInitialized) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            vm.initializeHolidaysPage(
              context: context,
              accessToken: authVm.token?.accessToken,
              tenantId: tenantId,
            );
          });
        }

        final holidays = vm.holidays;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: const Text('Holidays'),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: tenantId != null && tenantId.isNotEmpty
                    ? () => vm.refreshHolidays(tenantId)
                    : null,
                tooltip: 'Refresh',
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addHoliday(context, vm),
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          body: vm.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : Column(
                  children: [
                    // Error message
                    if (vm.error != null)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        decoration: BoxDecoration(
                          color: AppColors.errorLight,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.errorBorder),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: AppColors.error,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                vm.error!,
                                style: const TextStyle(
                                  color: AppColors.error,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, size: 18),
                              onPressed: () => vm.clearError(),
                              color: AppColors.error,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),

                    // Info banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      color: AppColors.infoLight,
                      child: const Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppColors.info,
                            size: 18,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'On holidays, your business will be marked as closed and bookings will be blocked.',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.info,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Holidays list or empty state
                    Expanded(
                      child: holidays.isEmpty
                          ? _buildEmptyState(context, vm)
                          : RefreshIndicator(
                              onRefresh: () async =>
                                  vm.refreshHolidays(tenantId),
                              color: AppColors.primary,
                              child: ListView.separated(
                                padding: const EdgeInsets.all(20),
                                itemCount: holidays.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  return _buildHolidayCard(
                                    context,
                                    holidays[index],
                                    vm,
                                    authVm,
                                  );
                                },
                              ),
                            ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  static Widget _buildEmptyState(BuildContext context, HolidaysViewModel vm) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.textHint.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.event_busy_outlined,
              size: 64,
              color: AppColors.textHint.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No holidays added',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap + to add a holiday or closure day',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _addHoliday(context, vm),
            icon: const Icon(Icons.add),
            label: const Text('Add Holiday'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildHolidayCard(
    BuildContext context,
    Holiday holiday,
    HolidaysViewModel vm,
    AuthViewModel authVm,
  ) {
    final date = _parseDate(holiday.holidayDate);
    final dateFormat = DateFormat('EEEE, MMM d, yyyy');
    final isPast = date != null && date.isBefore(DateTime.now());
    final isUpcoming =
        date != null &&
        date.isAfter(DateTime.now()) &&
        date.isBefore(DateTime.now().add(const Duration(days: 30)));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUpcoming
              ? AppColors.warning.withOpacity(0.5)
              : isPast
              ? AppColors.textHint.withOpacity(0.3)
              : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          // Date badge
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isUpcoming
                  ? AppColors.warning.withOpacity(0.1)
                  : isPast
                  ? AppColors.textHint.withOpacity(0.1)
                  : AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date != null
                      ? DateFormat('MMM').format(date).toUpperCase()
                      : '---',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isUpcoming
                        ? AppColors.warning
                        : isPast
                        ? AppColors.textHint
                        : AppColors.accent,
                  ),
                ),
                Text(
                  date != null ? date.day.toString() : '--',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isUpcoming
                        ? AppColors.warning
                        : isPast
                        ? AppColors.textHint
                        : AppColors.accent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Holiday info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        holiday.reason ?? 'Holiday',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isPast
                              ? AppColors.textHint
                              : AppColors.textPrimary,
                        ),
                      ),
                    ),
                    if (isUpcoming)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Upcoming',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.warning,
                          ),
                        ),
                      ),
                    if (isPast)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.textHint.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Past',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textHint,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  date != null ? dateFormat.format(date) : 'Invalid date',
                  style: TextStyle(
                    fontSize: 13,
                    color: isPast
                        ? AppColors.textHint
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Delete button
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.error),
            onPressed: () => _deleteHoliday(context, holiday, vm, authVm),
            tooltip: 'Delete holiday',
          ),
        ],
      ),
    );
  }

  static DateTime? _parseDate(String? dateString) {
    if (dateString == null) return null;
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  static void _addHoliday(BuildContext context, HolidaysViewModel vm) {
    vm.initializeAddHolidayDialog();

    showDialog(
      context: context,
      builder: (dialogContext) => Consumer<HolidaysViewModel>(
        builder: (context, vm, _) => AlertDialog(
          title: const Text(
            'Add Holiday',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Holiday Name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: vm.addHolidayReason,
                  decoration: InputDecoration(
                    hintText: 'e.g., Christmas Day, Office Renovation',
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(color: AppColors.primary),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  onChanged: vm.updateAddHolidayReason,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: vm.addHolidayDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: AppColors.primary,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      vm.updateAddHolidayDate(picked);
                    }
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          DateFormat(
                            'EEEE, MMM d, yyyy',
                          ).format(vm.addHolidayDate),
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.textHint,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                vm.closeAddHolidayDialog();
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            ElevatedButton(
              onPressed: vm.isSaving
                  ? null
                  : () async {
                      final authVm = context.read<AuthViewModel>();
                      final tenantId = authVm.user?.tenantId;
                      if (tenantId == null) return;

                      final success = await vm.createHolidayFromDialog(
                        tenantId,
                      );
                      if (success && dialogContext.mounted) {
                        Navigator.pop(dialogContext);
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: vm.isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  static void _deleteHoliday(
    BuildContext context,
    Holiday holiday,
    HolidaysViewModel vm,
    AuthViewModel authVm,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => Consumer<HolidaysViewModel>(
        builder: (context, vm, _) => AlertDialog(
          title: const Text(
            'Delete Holiday',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          content: Text(
            'Are you sure you want to delete "${holiday.reason}"?\n\nThis will allow bookings on this date again.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            ElevatedButton(
              onPressed: vm.isSaving
                  ? null
                  : () async {
                      final tenantId = authVm.user?.tenantId;
                      if (tenantId == null || holiday.id == null) {
                        Navigator.pop(dialogContext);
                        return;
                      }
                      final success = await vm.deleteHoliday(
                        tenantId: tenantId,
                        holidayId: holiday.id!,
                      );
                      if (success && dialogContext.mounted) {
                        Navigator.pop(dialogContext);
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: vm.isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
