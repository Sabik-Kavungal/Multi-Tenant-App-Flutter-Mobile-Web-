import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/constants/constants.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';
import 'package:saasf/features/tenant/viewmodels/tenant_vm.dart';
import 'package:saasf/features/tenant/models/tenant_model.dart';
import 'package:intl/intl.dart';

/// All Tenants Page - Super Admin view of all tenants in the platform
/// STRICT MVVM: Pure UI, zero business logic
/// Super Admin can view, create, edit, and manage all tenants
class AllTenantsPage extends StatelessWidget {
  const AllTenantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthViewModel, TenantViewModel>(
      builder: (context, authVm, tenantVm, _) {
        // Initialize on first build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (tenantVm.isInitialLoad) {
            tenantVm.setContext(context);
            tenantVm.setAccessToken(authVm.token?.accessToken);
            final status = tenantVm.filterStatus == 'all'
                ? null
                : tenantVm.filterStatus;
            tenantVm.loadAllTenants(refresh: true, status: status).then((_) {
              tenantVm.markInitialLoadComplete();
            });
          }
        });

        final filteredTenants = tenantVm.filteredTenants;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: const Text('All Tenants'),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => _handleRefresh(context, authVm, tenantVm),
                tooltip: 'Refresh',
              ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () => _showFilterSheet(context, tenantVm),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _createTenant(context, authVm, tenantVm),
              ),
            ],
          ),
          body: (tenantVm.isLoading && tenantVm.isInitialLoad)
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : _TenantsListBody(
                  tenantVm: tenantVm,
                  filteredTenants: filteredTenants,
                  authVm: authVm,
                ),
        );
      },
    );
  }

  // Helper methods - Pure UI coordination, no business logic
  Future<void> _handleRefresh(
    BuildContext context,
    AuthViewModel authVm,
    TenantViewModel tenantVm,
  ) async {
    tenantVm.setContext(context);
    tenantVm.setAccessToken(authVm.token?.accessToken);
    final status = tenantVm.filterStatus == 'all'
        ? null
        : tenantVm.filterStatus;
    await tenantVm.loadAllTenants(refresh: true, status: status);
  }

  Future<void> _onFilterChange(
    BuildContext context,
    String status,
    TenantViewModel tenantVm,
  ) async {
    tenantVm.updateFilterStatus(status);
    final filterValue = status == 'all' ? null : status;
    await tenantVm.filterByStatus(filterValue);
  }

  void _showFilterSheet(BuildContext context, TenantViewModel tenantVm) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Tenants',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('All'),
                  selected: tenantVm.filterStatus == 'all',
                  onSelected: (_) {
                    Navigator.pop(sheetContext);
                    _onFilterChange(context, 'all', tenantVm);
                  },
                ),
                ChoiceChip(
                  label: const Text('Active'),
                  selected: tenantVm.filterStatus == TenantStatus.active,
                  onSelected: (_) {
                    Navigator.pop(sheetContext);
                    _onFilterChange(context, TenantStatus.active, tenantVm);
                  },
                ),
                ChoiceChip(
                  label: const Text('Suspended'),
                  selected: tenantVm.filterStatus == TenantStatus.suspended,
                  onSelected: (_) {
                    Navigator.pop(sheetContext);
                    _onFilterChange(context, TenantStatus.suspended, tenantVm);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _createTenant(
    BuildContext context,
    AuthViewModel authVm,
    TenantViewModel tenantVm,
  ) {
    // STRICT MVVM: Directly open create business owner dialog
    // Creating a business owner automatically creates a tenant for them
    _showCreateUserAndTenantDialog(context, authVm, tenantVm);
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppColors.primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
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

  // Dialog methods - These are UI coordination only, actual logic in ViewModel

  // Static helper methods - UI coordination only
  static String _truncateId(String? id) {
    if (id == null || id.length < 8) return id ?? 'Unknown';
    return '${id.substring(0, 8)}...';
  }

  static DateTime? _parseDate(String? dateString) {
    if (dateString == null) return null;
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  static Color _getStatusColor(String status) {
    switch (status) {
      case 'ACTIVE':
        return AppColors.success;
      case 'SUSPENDED':
        return AppColors.error;
      case 'DELETED':
        return AppColors.textHint;
      default:
        return AppColors.textSecondary;
    }
  }

  static void _viewTenantDetails(
    BuildContext context,
    Tenant tenant,
    AuthViewModel authVm,
    TenantViewModel tenantVm,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  (tenant.name ?? 'T')[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                tenant.name ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('ID', tenant.id ?? 'Unknown'),
              const Divider(),
              _buildDetailRow(
                'Type',
                TenantTypes.getDisplayName(tenant.type ?? ''),
              ),
              const Divider(),
              _buildDetailRow(
                'Status',
                TenantStatus.getDisplayName(tenant.status ?? ''),
              ),
              const Divider(),
              _buildDetailRow('Timezone', tenant.timezone ?? 'Not set'),
              const Divider(),
              _buildDetailRow('Owner ID', _truncateId(tenant.ownerUserId)),
              const Divider(),
              _buildDetailRow(
                'Created',
                tenant.createdAt != null
                    ? DateFormat(
                        'MMM d, yyyy HH:mm',
                      ).format(DateTime.parse(tenant.createdAt!))
                    : 'Unknown',
              ),
              const Divider(),
              _buildDetailRow(
                'Updated',
                tenant.updatedAt != null
                    ? DateFormat(
                        'MMM d, yyyy HH:mm',
                      ).format(DateTime.parse(tenant.updatedAt!))
                    : 'Unknown',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _editTenant(context, tenant, authVm, tenantVm);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }

  static Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void _editTenant(
    BuildContext context,
    Tenant tenant,
    AuthViewModel authVm,
    TenantViewModel tenantVm,
  ) {
    // Initialize dialog form state in ViewModel
    tenantVm.initializeEditTenantDialog(tenant);

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
      builder: (dialogContext) => Consumer<TenantViewModel>(
        builder: (context, vm, _) => AlertDialog(
          title: const Text(
            'Edit Tenant',
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
                _buildDialogLabel('Tenant Name'),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: vm.editTenantName,
                  onChanged: vm.updateEditTenantName,
                  decoration: _dialogInputDecoration(hint: 'Enter tenant name'),
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
              onPressed: () {
                vm.closeEditTenantDialog();
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
                      if (vm.editTenantName.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Tenant name is required'),
                            backgroundColor: AppColors.error,
                          ),
                        );
                        return;
                      }

                      final success = await vm.updateTenant(
                        tenantId: tenant.id!,
                        name: vm.editTenantName,
                        type: vm.editTenantType,
                        status: vm.editTenantStatus,
                        timezone: vm.editTenantTimezone,
                      );

                      if (success && dialogContext.mounted) {
                        vm.closeEditTenantDialog();
                        Navigator.pop(dialogContext);
                        AllTenantsPage()._handleRefresh(
                          context,
                          authVm,
                          tenantVm,
                        );
                        _showSuccessSnackbar(
                          context,
                          'Tenant updated successfully',
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

  static void _handleTenantAction(
    BuildContext context,
    Tenant tenant,
    String action,
    AuthViewModel authVm,
    TenantViewModel tenantVm,
  ) {
    switch (action) {
      case 'suspend':
        _confirmAction(
          context,
          'Suspend Tenant',
          'Are you sure you want to suspend "${tenant.name}"?\n\nThis will prevent the tenant from accessing the platform.',
          () async {
            final success = await tenantVm.updateTenant(
              tenantId: tenant.id!,
              status: TenantStatus.suspended,
            );
            if (success) {
              AllTenantsPage()._handleRefresh(context, authVm, tenantVm);
              _showSuccessSnackbar(context, 'Tenant suspended');
            }
          },
        );
        break;
      case 'activate':
        _confirmAction(
          context,
          'Activate Tenant',
          'Are you sure you want to activate "${tenant.name}"?\n\nThe tenant will regain access to the platform.',
          () async {
            final success = await tenantVm.updateTenant(
              tenantId: tenant.id!,
              status: TenantStatus.active,
            );
            if (success) {
              AllTenantsPage()._handleRefresh(context, authVm, tenantVm);
              _showSuccessSnackbar(context, 'Tenant activated');
            }
          },
        );
        break;
      case 'delete':
        _confirmAction(
          context,
          'Delete Tenant',
          'Are you sure you want to delete "${tenant.name}"?\n\nThis action cannot be undone and will remove all associated data.',
          () async {
            final success = await tenantVm.deleteTenant(tenant.id!);
            if (success) {
              AllTenantsPage()._handleRefresh(context, authVm, tenantVm);
              _showSuccessSnackbar(context, 'Tenant deleted');
            }
          },
          isDestructive: true,
        );
        break;
    }
  }

  static void _confirmAction(
    BuildContext context,
    String title,
    String message,
    VoidCallback onConfirm, {
    bool isDestructive = false,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          Consumer<TenantViewModel>(
            builder: (context, vm, _) => ElevatedButton(
              onPressed: vm.isSaving
                  ? null
                  : () {
                      Navigator.pop(dialogContext);
                      onConfirm();
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDestructive
                    ? AppColors.error
                    : AppColors.primary,
                foregroundColor: Colors.white,
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
                  : const Text('Confirm'),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildDialogLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
    );
  }

  static InputDecoration _dialogInputDecoration({String? hint}) {
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

  static void _showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }

  /// Dialog to create a new user and tenant together
  void _showCreateUserAndTenantDialog(
    BuildContext context,
    AuthViewModel authVm,
    TenantViewModel tenantVm,
  ) {
    // Initialize dialog form state in ViewModel
    tenantVm.initializeCreateUserAndTenantDialog();

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
      builder: (dialogContext) => Consumer<TenantViewModel>(
        builder: (context, vm, _) => AlertDialog(
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.person_add,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Create Business Owner & Tenant',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Info Section
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.info.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: AppColors.info,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'This will create a new user account and assign them as owner of the new tenant.',
                          style: TextStyle(fontSize: 12, color: AppColors.info),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Owner Details Section
                const Text(
                  'OWNER DETAILS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDialogLabel('First Name *'),
                          const SizedBox(height: 6),
                          TextFormField(
                            initialValue: vm.createUserFirstName,
                            onChanged: vm.updateCreateUserFirstName,
                            decoration: _dialogInputDecoration(hint: 'John'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDialogLabel('Last Name *'),
                          const SizedBox(height: 6),
                          TextFormField(
                            initialValue: vm.createUserLastName,
                            onChanged: vm.updateCreateUserLastName,
                            decoration: _dialogInputDecoration(hint: 'Doe'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                _buildDialogLabel('Email *'),
                const SizedBox(height: 6),
                TextFormField(
                  initialValue: vm.createUserEmail,
                  onChanged: vm.updateCreateUserEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _dialogInputDecoration(
                    hint: 'owner@business.com',
                  ),
                ),
                const SizedBox(height: 12),

                _buildDialogLabel('Password *'),
                const SizedBox(height: 6),
                TextFormField(
                  initialValue: vm.createUserPassword,
                  onChanged: vm.updateCreateUserPassword,
                  obscureText: vm.createUserPasswordObscure,
                  decoration: _dialogInputDecoration(hint: 'Min 8 characters')
                      .copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            vm.createUserPasswordObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.textHint,
                            size: 20,
                          ),
                          onPressed: vm.toggleCreateUserPasswordVisibility,
                        ),
                      ),
                ),

                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),

                // Tenant Details Section
                const Text(
                  'BUSINESS DETAILS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 12),

                _buildDialogLabel('Business Name *'),
                const SizedBox(height: 6),
                TextFormField(
                  initialValue: vm.createTenantName,
                  onChanged: vm.updateCreateTenantName,
                  decoration: _dialogInputDecoration(hint: "John's Clinic"),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDialogLabel('Type'),
                          const SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: vm.createTenantType,
                            decoration: _dialogInputDecoration(),
                            isExpanded: true,
                            items: TenantTypes.all.map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(
                                  TenantTypes.getDisplayName(type),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null)
                                vm.updateCreateTenantType(value);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDialogLabel('Timezone'),
                          const SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: vm.createTenantTimezone,
                            decoration: _dialogInputDecoration(),
                            isExpanded: true,
                            items: timezones.map((tz) {
                              return DropdownMenuItem(
                                value: tz,
                                child: Text(
                                  tz,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null)
                                vm.updateCreateTenantTimezone(value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                vm.closeCreateUserAndTenantDialog();
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
                      // Validate all fields
                      if (vm.createUserFirstName.isEmpty ||
                          vm.createUserLastName.isEmpty ||
                          vm.createUserEmail.isEmpty ||
                          vm.createUserPassword.isEmpty ||
                          vm.createTenantName.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all required fields'),
                            backgroundColor: AppColors.error,
                          ),
                        );
                        return;
                      }

                      if (vm.createUserPassword.length < 8) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Password must be at least 8 characters',
                            ),
                            backgroundColor: AppColors.error,
                          ),
                        );
                        return;
                      }

                      final success = await vm.createUserAndTenant(
                        email: vm.createUserEmail,
                        password: vm.createUserPassword,
                        firstName: vm.createUserFirstName,
                        lastName: vm.createUserLastName,
                        tenantName: vm.createTenantName,
                        tenantType: vm.createTenantType,
                        timezone: vm.createTenantTimezone,
                      );

                      if (success && dialogContext.mounted) {
                        vm.closeCreateUserAndTenantDialog();
                        Navigator.pop(dialogContext);
                        _handleRefresh(context, authVm, tenantVm);
                        _showSuccessSnackbar(
                          context,
                          'Business owner and tenant created successfully',
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

  /// Dialog to create tenant for an existing user
  void _showCreateTenantForExistingUserDialog(
    BuildContext context,
    AuthViewModel authVm,
    TenantViewModel tenantVm,
  ) {
    // Initialize dialog form state in ViewModel
    tenantVm.initializeCreateTenantForUserDialog();

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

    // Load available users when dialog opens
    tenantVm.loadAvailableUsers();

    showDialog(
      context: context,
      builder: (dialogContext) => Consumer<TenantViewModel>(
        builder: (context, vm, _) => AlertDialog(
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.people,
                  color: AppColors.secondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Create Tenant for Existing User',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDialogLabel('Select Owner *'),
                const SizedBox(height: 6),
                if (vm.isLoadingUsers)
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: const Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  )
                else if (vm.availableUsers.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.warning_amber,
                          color: AppColors.warning,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'No available users. Create a new user first.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.warning,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  DropdownButtonFormField<String>(
                    value: vm.createTenantForUserSelectedUserId,
                    decoration: _dialogInputDecoration(hint: 'Select a user'),
                    isExpanded: true,
                    items: vm.availableUsers.map((user) {
                      return DropdownMenuItem(
                        value: user.id,
                        child: Text(
                          '${user.firstName} ${user.lastName} (${user.email})',
                          style: const TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      vm.updateCreateTenantForUserSelectedUserId(value);
                    },
                  ),
                const SizedBox(height: 16),

                _buildDialogLabel('Tenant Name *'),
                const SizedBox(height: 6),
                TextFormField(
                  initialValue: vm.createTenantForUserTenantName,
                  onChanged: vm.updateCreateTenantForUserTenantName,
                  decoration: _dialogInputDecoration(
                    hint: 'Enter business name',
                  ),
                ),
                const SizedBox(height: 16),

                _buildDialogLabel('Type'),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: vm.createTenantForUserType,
                  decoration: _dialogInputDecoration(),
                  items: TenantTypes.all.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(TenantTypes.getDisplayName(type)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) vm.updateCreateTenantForUserType(value);
                  },
                ),
                const SizedBox(height: 16),

                _buildDialogLabel('Timezone'),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: vm.createTenantForUserTimezone,
                  decoration: _dialogInputDecoration(),
                  items: timezones.map((tz) {
                    return DropdownMenuItem(value: tz, child: Text(tz));
                  }).toList(),
                  onChanged: (value) {
                    if (value != null)
                      vm.updateCreateTenantForUserTimezone(value);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                vm.clearAvailableUsers();
                vm.closeCreateTenantForUserDialog();
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            ElevatedButton(
              onPressed:
                  (vm.isSaving ||
                      vm.createTenantForUserSelectedUserId == null ||
                      vm.availableUsers.isEmpty)
                  ? null
                  : () async {
                      if (vm.createTenantForUserTenantName.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a business name'),
                            backgroundColor: AppColors.error,
                          ),
                        );
                        return;
                      }

                      // STRICT MVVM: UI only calls ViewModel method
                      // ViewModel handles tenant creation and assignment
                      final success = await vm.createTenantForUserFromDialog();

                      if (success && dialogContext.mounted) {
                        vm.clearAvailableUsers();
                        Navigator.pop(dialogContext);
                        _handleRefresh(context, authVm, tenantVm);
                        _showSuccessSnackbar(
                          context,
                          vm.successMessage ??
                              'Tenant created and assigned successfully',
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
}

/// Body widget for tenants list - handles scroll and infinite loading
/// STRICT MVVM: Pure UI, uses ViewModel state only
class _TenantsListBody extends StatelessWidget {
  final TenantViewModel tenantVm;
  final List<Tenant> filteredTenants;
  final AuthViewModel authVm;

  const _TenantsListBody({
    required this.tenantVm,
    required this.filteredTenants,
    required this.authVm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Stats & Search Header
        Container(
          padding: const EdgeInsets.all(16),
          color: AppColors.primary,
          child: Column(
            children: [
              // Stats Row
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Total Tenants',
                      '${tenantVm.totalTenantsCount}',
                      Icons.business,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Active',
                      '${tenantVm.activeTenantsCount}',
                      Icons.check_circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Suspended',
                      '${tenantVm.suspendedTenantsCount}',
                      Icons.pause_circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Search Bar - Uses ViewModel state (value + onChanged pattern)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  initialValue: tenantVm.searchQuery,
                  onChanged: tenantVm.updateSearchQuery,
                  decoration: InputDecoration(
                    hintText: 'Search by name, ID, or type...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.textHint,
                    ),
                    suffixIcon: tenantVm.searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: AppColors.textHint,
                            ),
                            onPressed: tenantVm.clearSearch,
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Error message
        if (tenantVm.error != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(16),
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
                    tenantVm.error!,
                    style: const TextStyle(
                      color: AppColors.error,
                      fontSize: 14,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: () => tenantVm.clearError(),
                  color: AppColors.error,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

        // Filter Chips + Pagination Info
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip(context, 'All', 'all', tenantVm),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        context,
                        'Active',
                        TenantStatus.active,
                        tenantVm,
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        context,
                        'Suspended',
                        TenantStatus.suspended,
                        tenantVm,
                      ),
                    ],
                  ),
                ),
              ),
              // Pagination info
              if (tenantVm.totalPages > 1)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Page ${tenantVm.currentPage}/${tenantVm.totalPages}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Tenants List with infinite scroll
        Expanded(
          child: filteredTenants.isEmpty && !tenantVm.isLoading
              ? _buildEmptyState(context, authVm, tenantVm)
              : RefreshIndicator(
                  onRefresh: () => AllTenantsPage()._handleRefresh(
                    context,
                    authVm,
                    tenantVm,
                  ),
                  color: AppColors.primary,
                  child: _TenantsListView(
                    tenantVm: tenantVm,
                    filteredTenants: filteredTenants,
                    authVm: authVm,
                    onLoadMore: () {
                      if (!tenantVm.isLoadingMore && tenantVm.hasMorePages) {
                        tenantVm.loadMoreTenants();
                      }
                    },
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label,
    String value,
    TenantViewModel tenantVm,
  ) {
    final isSelected = tenantVm.filterStatus == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        AllTenantsPage()._onFilterChange(context, value, tenantVm);
      },
      selectedColor: AppColors.primary.withOpacity(0.2),
      checkmarkColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    AuthViewModel authVm,
    TenantViewModel tenantVm,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.business_outlined, size: 64, color: AppColors.textHint),
          const SizedBox(height: 16),
          Text(
            'No tenants found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            tenantVm.searchQuery.isNotEmpty
                ? 'Try adjusting your search or filters'
                : 'Create your first tenant to get started',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () =>
                AllTenantsPage()._createTenant(context, authVm, tenantVm),
            icon: const Icon(Icons.add),
            label: const Text('Create Tenant'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

/// Scrollable list view for tenants with infinite scroll
/// STRICT MVVM: Pure UI, uses ViewModel state only
class _TenantsListView extends StatelessWidget {
  final TenantViewModel tenantVm;
  final List<Tenant> filteredTenants;
  final AuthViewModel authVm;
  final VoidCallback onLoadMore;

  const _TenantsListView({
    required this.tenantVm,
    required this.filteredTenants,
    required this.authVm,
    required this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          final metrics = notification.metrics;
          if (metrics.pixels >= metrics.maxScrollExtent - 200) {
            onLoadMore();
          }
        }
        return false;
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filteredTenants.length + (tenantVm.hasMorePages ? 1 : 0),
        itemBuilder: (context, index) {
          // Show loading indicator at the end
          if (index == filteredTenants.length) {
            return _buildLoadMoreIndicator(tenantVm.isLoadingMore);
          }
          return _buildTenantCard(
            context,
            filteredTenants[index],
            authVm,
            tenantVm,
          );
        },
      ),
    );
  }

  Widget _buildLoadMoreIndicator(bool isLoading) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildTenantCard(
    BuildContext context,
    Tenant tenant,
    AuthViewModel authVm,
    TenantViewModel tenantVm,
  ) {
    final status = tenant.status ?? '';
    final statusColor = AllTenantsPage._getStatusColor(status);
    final createdDate = AllTenantsPage._parseDate(tenant.createdAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => AllTenantsPage._viewTenantDetails(
            context,
            tenant,
            authVm,
            tenantVm,
          ),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  children: [
                    // Business Icon
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          (tenant.name ?? 'T')[0].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tenant.name ?? 'Unknown',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'ID: ${AllTenantsPage._truncateId(tenant.id)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textHint,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        TenantStatus.getDisplayName(status),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 12),
                // Details Row
                Row(
                  children: [
                    // Type
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.category_outlined,
                            size: 14,
                            color: AppColors.textHint,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              TenantTypes.getDisplayName(tenant.type ?? ''),
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Timezone
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: AppColors.textHint,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          tenant.timezone ?? 'Not set',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Created Date Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Type Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.info.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        tenant.type ?? 'OTHER',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.info,
                        ),
                      ),
                    ),
                    // Created Date
                    if (createdDate != null)
                      Text(
                        'Created: ${DateFormat('MMM d, yyyy').format(createdDate)}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textHint,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => AllTenantsPage._viewTenantDetails(
                          context,
                          tenant,
                          authVm,
                          tenantVm,
                        ),
                        icon: const Icon(Icons.visibility, size: 16),
                        label: const Text('View'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => AllTenantsPage._editTenant(
                          context,
                          tenant,
                          authVm,
                          tenantVm,
                        ),
                        icon: const Icon(Icons.edit, size: 16),
                        label: const Text('Edit'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.secondary,
                          side: const BorderSide(color: AppColors.secondary),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    PopupMenuButton<String>(
                      onSelected: (value) => AllTenantsPage._handleTenantAction(
                        context,
                        tenant,
                        value,
                        authVm,
                        tenantVm,
                      ),
                      itemBuilder: (context) => [
                        if (status == TenantStatus.active)
                          const PopupMenuItem(
                            value: 'suspend',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.pause_circle,
                                  color: AppColors.warning,
                                ),
                                SizedBox(width: 8),
                                Text('Suspend'),
                              ],
                            ),
                          ),
                        if (status == TenantStatus.suspended)
                          const PopupMenuItem(
                            value: 'activate',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.play_circle,
                                  color: AppColors.success,
                                ),
                                SizedBox(width: 8),
                                Text('Activate'),
                              ],
                            ),
                          ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: AppColors.error),
                              SizedBox(width: 8),
                              Text('Delete'),
                            ],
                          ),
                        ),
                      ],
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.border),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.more_vert,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
