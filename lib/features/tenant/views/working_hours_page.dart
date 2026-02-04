import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/constants/constants.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';
import 'package:saasf/features/tenant/viewmodels/working_hours_vm.dart';

/// Working Hours Page
/// STRICT MVVM: Pure UI - zero business logic
/// All state and logic in WorkingHoursViewModel
class WorkingHoursPage extends StatelessWidget {
  const WorkingHoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();
    final vm = context.watch<WorkingHoursViewModel>();
    final user = authVm.user;

    // Initialize and load data on first build
    // STRICT MVVM: UI only triggers ViewModel method, ViewModel handles all logic
    // Use a one-time initialization pattern to prevent multiple calls
    if (!vm.workingHoursScheduleInitialized &&
        !vm.isLoading &&
        user?.tenantId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Double-check condition after post-frame callback to prevent race conditions
        if (!vm.workingHoursScheduleInitialized && !vm.isLoading) {
          vm.initializeWorkingHoursPage(
            context: context,
            accessToken: authVm.token?.accessToken,
            tenantId: user?.tenantId,
          );
        }
      });
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Working Hours'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => vm.refreshWorkingHours(user?.tenantId),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: vm.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : Column(
              children: [
                // Error message
                if (vm.error != null) _buildErrorBanner(context, vm.error!, vm),

                // Info banner
                _buildInfoBanner(vm.workingHoursHasChanges),

                // Schedule list
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: vm.workingHoursSchedule.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final day = vm.workingHoursSchedule[index];
                      return _buildDayCard(context, day, index, vm);
                    },
                  ),
                ),

                // Save Button
                _buildSaveButton(context, vm, user?.tenantId),
              ],
            ),
    );
  }

  Widget _buildErrorBanner(
    BuildContext context,
    String error,
    WorkingHoursViewModel vm,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.errorLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.errorBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppColors.error, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              error,
              style: const TextStyle(color: AppColors.error, fontSize: 14),
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
    );
  }

  Widget _buildInfoBanner(bool hasChanges) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: AppColors.infoLight,
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: AppColors.info, size: 18),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Set your business operating hours. Toggle days on/off and adjust times.',
              style: TextStyle(fontSize: 13, color: AppColors.info),
            ),
          ),
          if (hasChanges)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.warning,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Unsaved',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDayCard(
    BuildContext context,
    dynamic day,
    int index,
    WorkingHoursViewModel vm,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: day.isOpen
              ? AppColors.primary.withOpacity(0.3)
              : AppColors.border,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Day indicator
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: day.isOpen
                      ? AppColors.primary.withOpacity(0.1)
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    day.name.substring(0, 2).toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: day.isOpen
                          ? AppColors.primary
                          : AppColors.textHint,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: day.isOpen
                            ? AppColors.textPrimary
                            : AppColors.textHint,
                      ),
                    ),
                    Text(
                      day.isOpen
                          ? '${day.openTime ?? '--:--'} - ${day.closeTime ?? '--:--'}'
                          : 'Closed',
                      style: TextStyle(
                        fontSize: 13,
                        color: day.isOpen
                            ? AppColors.textSecondary
                            : AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: day.isOpen,
                onChanged: (value) => vm.toggleWorkingHoursDay(index),
                activeColor: AppColors.primary,
              ),
            ],
          ),
          if (day.isOpen) ...[
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTimeSelector(
                    label: 'Opens at',
                    time: day.openTime ?? '09:00',
                    onTap: () => _selectTime(context, index, true, vm),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.arrow_forward,
                    color: AppColors.textHint.withOpacity(0.5),
                    size: 20,
                  ),
                ),
                Expanded(
                  child: _buildTimeSelector(
                    label: 'Closes at',
                    time: day.closeTime ?? '17:00',
                    onTap: () => _selectTime(context, index, false, vm),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimeSelector({
    required String label,
    required String time,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textHint,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 18,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  _formatTime(time),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(String time) {
    try {
      final parts = time.split(':');
      final hour = int.parse(parts[0]);
      final minute = parts[1];
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$displayHour:$minute $period';
    } catch (e) {
      return time;
    }
  }

  Future<void> _selectTime(
    BuildContext context,
    int dayIndex,
    bool isOpenTime,
    WorkingHoursViewModel vm,
  ) async {
    final schedule = vm.workingHoursSchedule;
    if (dayIndex < 0 || dayIndex >= schedule.length) return;

    final currentTime = isOpenTime
        ? schedule[dayIndex].openTime ?? '09:00'
        : schedule[dayIndex].closeTime ?? '17:00';

    final parts = currentTime.split(':');
    final initialTime = TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedTime =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      // STRICT MVVM: UI only calls ViewModel method
      vm.updateWorkingHoursTime(dayIndex, isOpenTime, formattedTime);
    }
  }

  Widget _buildSaveButton(
    BuildContext context,
    WorkingHoursViewModel vm,
    String? tenantId,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: vm.isSaving || tenantId == null
                ? null
                : () => _saveHours(context, vm, tenantId),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
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
                : Text(
                    vm.workingHoursHasChanges ? 'Save Changes' : 'Save',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveHours(
    BuildContext context,
    WorkingHoursViewModel vm,
    String tenantId,
  ) async {
    // STRICT MVVM: UI only calls ViewModel method
    // ViewModel handles all validation, API calls, and state updates
    final success = await vm.saveWorkingHoursFromSchedule(tenantId);

    if (success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            vm.successMessage ?? 'Working hours saved successfully',
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      );
    }
  }
}
