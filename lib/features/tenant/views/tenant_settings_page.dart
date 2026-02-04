import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/constants/constants.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';
import 'package:saasf/features/tenant/viewmodels/tenant_settings_vm.dart';
import 'package:saasf/features/tenant/models/tenant_model.dart';

/// Tenant Settings Page
/// STRICT MVVM: UI is purely presentational - zero business logic
class TenantSettingsPage extends StatelessWidget {
  const TenantSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthViewModel, TenantSettingsViewModel>(
      builder: (context, authVm, vm, _) {
        // Initialize on first build
        // STRICT MVVM: UI only triggers ViewModel method, ViewModel handles all logic
        final tenantId = authVm.user?.tenantId;
        if (tenantId != null && tenantId.isNotEmpty && !vm.isInitialized) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            vm.initializeSettingsPage(
              context: context,
              accessToken: authVm.token?.accessToken,
              tenantId: tenantId,
            );
          });
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: const Text('Settings'),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: tenantId != null && tenantId.isNotEmpty
                    ? () => vm.refreshSettings(tenantId)
                    : null,
                tooltip: 'Refresh',
              ),
            ],
          ),
          body: vm.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (vm.error != null) ...[
                        _ErrorBanner(error: vm.error!),
                        const SizedBox(height: 16),
                      ],
                      if (vm.successMessage != null) ...[
                        _SuccessBanner(message: vm.successMessage!),
                        const SizedBox(height: 16),
                      ],
                      if (!authVm.isAdmin) ...[
                        _InfoBanner(
                          message: 'Only Admins can modify tenant settings',
                        ),
                        const SizedBox(height: 16),
                      ],
                      const _SectionTitle(title: 'General'),
                      const SizedBox(height: 16),
                      _GeneralCard(
                        businessName: vm.settingsBusinessName,
                        businessType: vm.settingsBusinessType,
                        timezone: vm.settingsTimezone,
                        isAdmin: authVm.isAdmin,
                        onBusinessNameChanged: vm.updateSettingsBusinessName,
                        onBusinessTypeChanged: vm.updateSettingsBusinessType,
                        onTimezoneChanged: vm.updateSettingsTimezone,
                      ),
                      const SizedBox(height: 24),
                      const _SectionTitle(title: 'Booking Rules'),
                      const SizedBox(height: 16),
                      _BookingRulesCard(
                        maxDailyBookings: vm.settingsMaxDailyBookings,
                        unlimitedBookings: vm.settingsUnlimitedBookings,
                        cancellationWindow: vm.settingsCancellationWindow,
                        isAdmin: authVm.isAdmin,
                        onMaxDailyBookingsChanged:
                            vm.updateSettingsMaxDailyBookings,
                        onUnlimitedBookingsChanged:
                            vm.updateSettingsUnlimitedBookings,
                        onCancellationWindowChanged:
                            vm.updateSettingsCancellationWindow,
                      ),
                      const SizedBox(height: 24),
                      const _SectionTitle(title: 'Features'),
                      const SizedBox(height: 16),
                      _FeaturesCard(
                        allowWalkins: vm.settingsAllowWalkins,
                        queueEnabled: vm.settingsQueueEnabled,
                        autoAssignStaff: vm.settingsAutoAssignStaff,
                        isAdmin: authVm.isAdmin,
                        onAllowWalkinsChanged: vm.updateSettingsAllowWalkins,
                        onQueueEnabledChanged: vm.updateSettingsQueueEnabled,
                        onAutoAssignStaffChanged:
                            vm.updateSettingsAutoAssignStaff,
                      ),
                      const SizedBox(height: 32),
                      if (authVm.isAdmin &&
                          tenantId != null &&
                          tenantId.isNotEmpty)
                        _SaveButton(
                          isSaving: vm.isSaving,
                          onPressed: () => vm.saveAllSettings(tenantId),
                        ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

// ============================================
// PURE UI WIDGETS - NO LOGIC
// ============================================

class _ErrorBanner extends StatelessWidget {
  final String error;

  const _ErrorBanner({required this.error});

  @override
  Widget build(BuildContext context) {
    return Consumer<TenantSettingsViewModel>(
      builder: (context, settingsVm, _) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
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
              onPressed: settingsVm.clearError,
              color: AppColors.error,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessBanner extends StatelessWidget {
  final String message;

  const _SuccessBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Consumer<TenantSettingsViewModel>(
      builder: (context, settingsVm, _) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.successLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.success.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: AppColors.success,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: AppColors.success, fontSize: 14),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 18),
              onPressed: settingsVm.clearSuccess,
              color: AppColors.success,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  final String message;

  const _InfoBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.infoLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.info.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: AppColors.info, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: AppColors.info, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _GeneralCard extends StatelessWidget {
  final String businessName;
  final String businessType;
  final String timezone;
  final bool isAdmin;
  final ValueChanged<String> onBusinessNameChanged;
  final ValueChanged<String> onBusinessTypeChanged;
  final ValueChanged<String> onTimezoneChanged;

  const _GeneralCard({
    required this.businessName,
    required this.businessType,
    required this.timezone,
    required this.isAdmin,
    required this.onBusinessNameChanged,
    required this.onBusinessTypeChanged,
    required this.onTimezoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Label(text: 'Business Name'),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: businessName,
            decoration: _inputDecoration('Enter business name'),
            enabled: isAdmin,
            onChanged: onBusinessNameChanged,
          ),
          const SizedBox(height: 20),
          const _Label(text: 'Business Type'),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: businessType,
            decoration: _inputDecoration('Select type'),
            items: TenantTypes.all.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(TenantTypes.getDisplayName(type)),
              );
            }).toList(),
            onChanged: isAdmin
                ? (value) {
                    if (value != null) onBusinessTypeChanged(value);
                  }
                : null,
          ),
          const SizedBox(height: 20),
          const _Label(text: 'Timezone'),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: timezone,
            decoration: _inputDecoration('Select timezone'),
            items:
                const [
                  'UTC',
                  'America/New_York',
                  'America/Los_Angeles',
                  'Europe/London',
                  'Europe/Paris',
                  'Asia/Tokyo',
                  'Asia/Kolkata',
                  'Australia/Sydney',
                ].map((tz) {
                  return DropdownMenuItem(value: tz, child: Text(tz));
                }).toList(),
            onChanged: isAdmin
                ? (value) {
                    if (value != null) onTimezoneChanged(value);
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

class _BookingRulesCard extends StatelessWidget {
  final String maxDailyBookings;
  final bool unlimitedBookings;
  final String cancellationWindow;
  final bool isAdmin;
  final ValueChanged<String> onMaxDailyBookingsChanged;
  final ValueChanged<bool> onUnlimitedBookingsChanged;
  final ValueChanged<String> onCancellationWindowChanged;

  const _BookingRulesCard({
    required this.maxDailyBookings,
    required this.unlimitedBookings,
    required this.cancellationWindow,
    required this.isAdmin,
    required this.onMaxDailyBookingsChanged,
    required this.onUnlimitedBookingsChanged,
    required this.onCancellationWindowChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CheckboxListTile(
            title: const Text(
              'Unlimited Daily Bookings',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            subtitle: const Text(
              'Remove daily booking limit',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
            value: unlimitedBookings,
            onChanged: isAdmin
                ? (value) {
                    if (value != null) onUnlimitedBookingsChanged(value);
                  }
                : null,
            activeColor: AppColors.primary,
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 8),
          if (!unlimitedBookings) ...[
            const _Label(text: 'Max Daily Bookings'),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: maxDailyBookings,
              decoration: _inputDecoration('Enter maximum bookings per day'),
              keyboardType: TextInputType.number,
              enabled: isAdmin && !unlimitedBookings,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: onMaxDailyBookingsChanged,
            ),
            const SizedBox(height: 20),
          ],
          const _Label(text: 'Cancellation Window (minutes)'),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: cancellationWindow,
            decoration: _inputDecoration('Minutes before appointment'),
            keyboardType: TextInputType.number,
            enabled: isAdmin,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: onCancellationWindowChanged,
          ),
        ],
      ),
    );
  }
}

class _FeaturesCard extends StatelessWidget {
  final bool allowWalkins;
  final bool queueEnabled;
  final bool autoAssignStaff;
  final bool isAdmin;
  final ValueChanged<bool> onAllowWalkinsChanged;
  final ValueChanged<bool> onQueueEnabledChanged;
  final ValueChanged<bool> onAutoAssignStaffChanged;

  const _FeaturesCard({
    required this.allowWalkins,
    required this.queueEnabled,
    required this.autoAssignStaff,
    required this.isAdmin,
    required this.onAllowWalkinsChanged,
    required this.onQueueEnabledChanged,
    required this.onAutoAssignStaffChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        children: [
          _SettingRow(
            title: 'Allow Walk-ins',
            subtitle: 'Accept walk-in customers without appointments',
            trailing: Switch(
              value: allowWalkins,
              onChanged: isAdmin ? onAllowWalkinsChanged : null,
              activeColor: AppColors.primary,
            ),
          ),
          const Divider(height: 24),
          _SettingRow(
            title: 'Enable Queue Management',
            subtitle: 'Use queue system for walk-in customers',
            trailing: Switch(
              value: queueEnabled,
              onChanged: isAdmin ? onQueueEnabledChanged : null,
              activeColor: AppColors.primary,
            ),
          ),
          const Divider(height: 24),
          _SettingRow(
            title: 'Auto-Assign Staff',
            subtitle: 'Automatically assign available staff to bookings',
            trailing: Switch(
              value: autoAssignStaff,
              onChanged: isAdmin ? onAutoAssignStaffChanged : null,
              activeColor: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final bool isSaving;
  final VoidCallback onPressed;

  const _SaveButton({required this.isSaving, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isSaving ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: isSaving
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text(
                'Save Changes',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}

class _Label extends StatelessWidget {
  final String text;

  const _Label({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget trailing;

  const _SettingRow({
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        trailing,
      ],
    );
  }
}

InputDecoration _inputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.grey[400]),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Colors.grey[200]!),
    ),
  );
}
