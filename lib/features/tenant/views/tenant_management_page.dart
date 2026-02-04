import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/constants/constants.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';
import 'package:saasf/features/tenant/viewmodels/tenant_management_vm.dart';
import 'package:saasf/features/tenant/models/tenant_model.dart';

/// Tenant Management Page
/// STRICT MVVM: Pure UI - zero business logic
/// All state and logic in TenantManagementViewModel
class TenantManagementPage extends StatelessWidget {
  const TenantManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();
    final vm = context.watch<TenantManagementViewModel>();
    final user = authVm.user;
    final tenant = vm.tenant;

    // Initialize and load data on first build
    // STRICT MVVM: UI only triggers ViewModel method, ViewModel handles all logic
    // Only initialize if tenant is not already loaded (prevents unnecessary reloads)
    if (tenant == null && !vm.isLoading && user?.tenantId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        vm.initializeAndLoadTenant(
          context: context,
          accessToken: authVm.token?.accessToken,
          tenantId: user?.tenantId,
        );
      });
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Tenant Management'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (authVm.isAdmin)
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => _showEditTenantDialog(context, vm),
              tooltip: 'Edit Tenant',
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => vm.refreshTenantData(user?.tenantId),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: vm.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : RefreshIndicator(
              onRefresh: () async => vm.refreshTenantData(user?.tenantId),
              color: AppColors.primary,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Error message
                    if (vm.error != null) ...[
                      _buildErrorBanner(context, vm.error!, vm),
                      const SizedBox(height: 16),
                    ],

                    // Organization Info Card
                    _buildOrganizationCard(user, tenant),
                    const SizedBox(height: 24),

                    // Tenant Details Card (if loaded)
                    if (tenant != null) ...[
                      _buildTenantDetailsCard(tenant),
                      const SizedBox(height: 24),
                    ],

                    // Management Options
                    _buildSectionTitle('Management'),
                    const SizedBox(height: 12),

                    _buildMenuCard(
                      context,
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      subtitle: 'Booking rules, walk-ins, queue settings',
                      onTap: () =>
                          Navigator.pushNamed(context, vm.getSettingsRoute()),
                    ),
                    const SizedBox(height: 12),

                    _buildMenuCard(
                      context,
                      icon: Icons.access_time_outlined,
                      title: 'Working Hours',
                      subtitle: 'Set business operating hours',
                      onTap: () => Navigator.pushNamed(
                        context,
                        vm.getWorkingHoursRoute(),
                      ),
                    ),
                    const SizedBox(height: 12),

                    _buildMenuCard(
                      context,
                      icon: Icons.event_busy_outlined,
                      title: 'Holidays',
                      subtitle: 'Manage holiday calendar',
                      onTap: () =>
                          Navigator.pushNamed(context, vm.getHolidaysRoute()),
                    ),
                    const SizedBox(height: 12),

                    _buildMenuCard(
                      context,
                      icon: Icons.people_outline,
                      title: 'Staff',
                      subtitle: 'Manage team members',
                      onTap: () =>
                          Navigator.pushNamed(context, vm.getStaffRoute()),
                    ),

                    // Admin only - Create Tenant (if no tenant exists)
                    if (user?.tenantId == null && authVm.isAdmin) ...[
                      const SizedBox(height: 32),
                      _buildSectionTitle('Create Organization'),
                      const SizedBox(height: 12),
                      _buildCreateTenantButton(context, vm),
                    ],
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildErrorBanner(
    BuildContext context,
    String error,
    TenantManagementViewModel vm,
  ) {
    return Container(
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
            onPressed: () => vm.clearError(),
            color: AppColors.error,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildOrganizationCard(dynamic user, Tenant? tenant) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
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
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.business,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tenant?.name ?? 'My Organization',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${user?.tenantId ?? 'N/A'}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (tenant?.status != null) _buildStatusBadge(tenant!.status!),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 1,
            color: AppColors.divider,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildInfoItem(Icons.person_outline, 'Role', user?.role ?? 'N/A'),
              const SizedBox(width: 24),
              _buildInfoItem(
                Icons.verified_user_outlined,
                'Status',
                (user?.isActive ?? false) ? 'Active' : 'Inactive',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTenantDetailsCard(Tenant tenant) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tenant Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            'Type',
            TenantTypes.getDisplayName(tenant.type ?? ''),
          ),
          const Divider(height: 24),
          _buildDetailRow('Timezone', tenant.timezone ?? 'Not set'),
          const Divider(height: 24),
          _buildDetailRow(
            'Created',
            tenant.createdAt != null
                ? _formatDate(tenant.createdAt!)
                : 'Unknown',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    final isActive = status == TenantStatus.active;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.success.withOpacity(0.1)
            : AppColors.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        TenantStatus.getDisplayName(status),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isActive ? AppColors.success : AppColors.warning,
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textHint),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: AppColors.textHint),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
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

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppColors.primary, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
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
              const Icon(Icons.chevron_right, color: AppColors.textHint),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateTenantButton(
    BuildContext context,
    TenantManagementViewModel vm,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _showCreateTenantDialog(context, vm),
        icon: const Icon(Icons.add),
        label: const Text('Create Organization'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  void _showCreateTenantDialog(
    BuildContext context,
    TenantManagementViewModel vm,
  ) {
    // STRICT MVVM: UI only triggers ViewModel initialization
    // ViewModel manages all dialog state
    vm.initializeCreateTenantDialog();

    final timezones = [
      'UTC',
      'America/New_York',
      'America/Los_Angeles',
      'Europe/London',
      'Europe/Paris',
      'Asia/Tokyo',
      'Asia/Kolkata',
      'Australia/Sydney',
    ];

    showDialog(
      context: context,
      builder: (dialogContext) => Consumer<TenantManagementViewModel>(
        builder: (context, vm, _) => AlertDialog(
          title: const Text(
            'Create Organization',
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
                _buildDialogLabel('Organization Name'),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: vm.createTenantDialogName,
                  decoration: _dialogInputDecoration(hint: 'Enter name'),
                  onChanged: vm.updateCreateTenantDialogName,
                ),
                const SizedBox(height: 16),
                _buildDialogLabel('Type'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: vm.createTenantDialogType,
                  decoration: _dialogInputDecoration(),
                  items: TenantTypes.all.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(TenantTypes.getDisplayName(type)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) vm.updateCreateTenantDialogType(value);
                  },
                ),
                const SizedBox(height: 16),
                _buildDialogLabel('Timezone'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: vm.createTenantDialogTimezone,
                  decoration: _dialogInputDecoration(),
                  items: timezones.map((tz) {
                    return DropdownMenuItem(value: tz, child: Text(tz));
                  }).toList(),
                  onChanged: (value) {
                    if (value != null)
                      vm.updateCreateTenantDialogTimezone(value);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                vm.closeCreateTenantDialog();
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
                      final userId = authVm.user?.id;
                      if (userId == null) return;

                      final success = await vm.createTenantFromDialog(userId);

                      if (success && dialogContext.mounted) {
                        Navigator.pop(dialogContext);
                        // STRICT MVVM: Show success message via ViewModel state
                        // UI reads successMessage from ViewModel
                        ScaffoldMessenger.of(dialogContext).showSnackBar(
                          SnackBar(
                            content: Text(
                              vm.successMessage ??
                                  'Organization created successfully',
                            ),
                            backgroundColor: AppColors.success,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
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
                  : const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditTenantDialog(
    BuildContext context,
    TenantManagementViewModel vm,
  ) {
    final tenant = vm.tenant;
    if (tenant == null) return;

    // STRICT MVVM: UI only triggers ViewModel initialization
    // ViewModel manages all dialog state
    vm.initializeEditTenantDialog(tenant);

    final timezones = [
      'UTC',
      'America/New_York',
      'America/Los_Angeles',
      'Europe/London',
      'Europe/Paris',
      'Asia/Tokyo',
      'Asia/Kolkata',
      'Australia/Sydney',
    ];

    showDialog(
      context: context,
      builder: (dialogContext) => Consumer<TenantManagementViewModel>(
        builder: (context, vm, _) => AlertDialog(
          title: const Text(
            'Edit Organization',
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
                _buildDialogLabel('Organization Name'),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: vm.editTenantName,
                  decoration: _dialogInputDecoration(hint: 'Enter name'),
                  onChanged: vm.updateEditTenantName,
                ),
                const SizedBox(height: 16),
                _buildDialogLabel('Type'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: vm.editTenantType,
                  decoration: _dialogInputDecoration(),
                  items: TenantTypes.all.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(TenantTypes.getDisplayName(type)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) vm.updateEditTenantType(value);
                  },
                ),
                const SizedBox(height: 16),
                _buildDialogLabel('Status'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: vm.editTenantStatus,
                  decoration: _dialogInputDecoration(),
                  items: TenantStatus.all.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(TenantStatus.getDisplayName(status)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) vm.updateEditTenantStatus(value);
                  },
                ),
                const SizedBox(height: 16),
                _buildDialogLabel('Timezone'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: vm.editTenantTimezone,
                  decoration: _dialogInputDecoration(),
                  items: timezones.map((tz) {
                    return DropdownMenuItem(value: tz, child: Text(tz));
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) vm.updateEditTenantTimezone(value);
                  },
                ),
              ],
            ),
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
                      final success = await vm.updateTenantFromDialog(
                        tenant.id!,
                      );

                      if (success && dialogContext.mounted) {
                        vm.closeEditTenantDialog();
                        Navigator.pop(dialogContext);
                        // STRICT MVVM: Show success message via ViewModel state
                        // UI reads successMessage from ViewModel
                        ScaffoldMessenger.of(dialogContext).showSnackBar(
                          SnackBar(
                            content: Text(
                              vm.successMessage ??
                                  'Organization updated successfully',
                            ),
                            backgroundColor: AppColors.success,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
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
                  : const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
    );
  }

  InputDecoration _dialogInputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
