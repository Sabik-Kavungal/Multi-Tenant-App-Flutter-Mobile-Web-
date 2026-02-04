import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/constants/constants.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';
import 'package:saasf/features/tenant/viewmodels/staff_vm.dart';
import 'package:saasf/features/tenant/models/staff_model.dart';
import 'package:intl/intl.dart';

/// Staff Management Page
/// STRICT MVVM: UI is purely presentational - zero business logic
class StaffPage extends StatelessWidget {
  const StaffPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthViewModel, StaffViewModel>(
      builder: (context, authVm, vm, _) {
        // Initialize on first build
        // STRICT MVVM: UI only triggers ViewModel method, ViewModel handles all logic
        final tenantId = authVm.user?.tenantId;
        if (tenantId != null && tenantId.isNotEmpty && !vm.isInitialized) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            vm.initializeStaffPage(
              context: context,
              accessToken: authVm.token?.accessToken,
              tenantId: tenantId,
            );
          });
        }

        final staffList = vm.staffList;
        final isAdmin = authVm.isAdmin;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: const Text('Staff'),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: tenantId != null && tenantId.isNotEmpty
                    ? () => vm.refreshStaff(tenantId)
                    : null,
                tooltip: 'Refresh',
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addStaff(context, vm, authVm),
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

                    // Admin notice
                    if (!isAdmin)
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
                                'Only Admins can modify staff members',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.info,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Stats banner
                    if (staffList.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem(
                              'Total',
                              staffList.length.toString(),
                              Icons.people_outline,
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: AppColors.divider,
                            ),
                            _buildStatItem(
                              'Active',
                              vm.activeStaff.length.toString(),
                              Icons.check_circle_outline,
                              color: AppColors.success,
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: AppColors.divider,
                            ),
                            _buildStatItem(
                              'Admins',
                              vm.adminStaff.length.toString(),
                              Icons.admin_panel_settings_outlined,
                              color: AppColors.accent,
                            ),
                          ],
                        ),
                      ),

                    // Staff list or empty state
                    Expanded(
                      child: staffList.isEmpty
                          ? _buildEmptyState(context, vm, authVm)
                          : RefreshIndicator(
                              onRefresh: () async => vm.refreshStaff(tenantId),
                              color: AppColors.primary,
                              child: ListView.separated(
                                padding: const EdgeInsets.fromLTRB(
                                  20,
                                  0,
                                  20,
                                  20,
                                ),
                                itemCount: staffList.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  return _buildStaffCard(
                                    context,
                                    staffList[index],
                                    isAdmin,
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

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon, {
    Color? color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color ?? AppColors.textHint, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color ?? AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    StaffViewModel vm,
    AuthViewModel authVm,
  ) {
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
              Icons.people_outline,
              size: 64,
              color: AppColors.textHint.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No staff members',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap + to add a staff member to your team',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _addStaff(context, vm, authVm),
            icon: const Icon(Icons.add),
            label: const Text('Add Staff'),
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

  Widget _buildStaffCard(
    BuildContext context,
    Staff staff,
    bool isAdmin,
    StaffViewModel vm,
    AuthViewModel authVm,
  ) {
    final isActive = staff.isActive ?? false;
    final isStaffAdmin = staff.designation == StaffDesignation.admin;
    final joinedDate = _parseDate(staff.joinedAt);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive
              ? AppColors.border
              : AppColors.textHint.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: isStaffAdmin
                  ? AppColors.accent.withOpacity(0.1)
                  : AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Center(
              child: Icon(
                isStaffAdmin ? Icons.admin_panel_settings : Icons.person,
                color: isStaffAdmin ? AppColors.accent : AppColors.primary,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'User ID: ${_truncateId(staff.userId)}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: isActive
                              ? AppColors.textPrimary
                              : AppColors.textHint,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isStaffAdmin
                            ? AppColors.accent.withOpacity(0.1)
                            : AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        StaffDesignation.getDisplayName(
                          staff.designation ?? '',
                        ),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isStaffAdmin
                              ? AppColors.accent
                              : AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    // Status indicator
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.success : AppColors.error,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isActive ? 'Active' : 'Inactive',
                      style: TextStyle(
                        fontSize: 12,
                        color: isActive ? AppColors.success : AppColors.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Joined date
                    if (joinedDate != null) ...[
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 12,
                        color: AppColors.textHint,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Joined ${DateFormat('MMM d, yyyy').format(joinedDate)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Actions (only for admins)
          if (isAdmin)
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: AppColors.textHint),
              onSelected: (value) {
                if (value == 'edit') {
                  _editStaff(context, staff, vm);
                } else if (value == 'toggle_active') {
                  _toggleStaffActive(context, staff, vm, authVm);
                } else if (value == 'delete') {
                  _deleteStaff(context, staff, vm, authVm);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: const [
                      Icon(Icons.edit_outlined, size: 18),
                      SizedBox(width: 8),
                      Text('Edit Role'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'toggle_active',
                  child: Row(
                    children: [
                      Icon(
                        isActive ? Icons.block : Icons.check_circle_outline,
                        size: 18,
                        color: isActive ? AppColors.warning : AppColors.success,
                      ),
                      const SizedBox(width: 8),
                      Text(isActive ? 'Deactivate' : 'Activate'),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: AppColors.error,
                      ),
                      SizedBox(width: 8),
                      Text('Remove', style: TextStyle(color: AppColors.error)),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  String _truncateId(String? id) {
    if (id == null || id.length < 8) return id ?? 'Unknown';
    return '${id.substring(0, 8)}...';
  }

  DateTime? _parseDate(String? dateString) {
    if (dateString == null) return null;
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  void _addStaff(
    BuildContext context,
    StaffViewModel vm,
    AuthViewModel authVm,
  ) {
    vm.initializeAddStaffDialog();

    showDialog(
      context: context,
      builder: (dialogContext) => Consumer<StaffViewModel>(
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
                  'Add Staff Member',
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
                // Mode Selection
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      RadioListTile<bool>(
                        title: const Text(
                          'Add Existing User',
                          style: TextStyle(fontSize: 14),
                        ),
                        subtitle: const Text(
                          'User already has an account',
                          style: TextStyle(fontSize: 12),
                        ),
                        value: true,
                        groupValue: vm.addStaffModeExisting,
                        onChanged: (value) => vm.updateAddStaffMode(value!),
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                      RadioListTile<bool>(
                        title: const Text(
                          'Create New User',
                          style: TextStyle(fontSize: 14),
                        ),
                        subtitle: const Text(
                          'Create account and add as staff',
                          style: TextStyle(fontSize: 12),
                        ),
                        value: false,
                        groupValue: vm.addStaffModeExisting,
                        onChanged: (value) => vm.updateAddStaffMode(value!),
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Mode 1: Existing User
                if (vm.addStaffModeExisting) ...[
                  const Text(
                    'User ID',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: vm.addStaffUserId,
                    decoration: _dialogInputDecoration(hint: 'Enter user UUID'),
                    onChanged: vm.updateAddStaffUserId,
                  ),
                ],

                // Mode 2: Create New User
                if (!vm.addStaffModeExisting) ...[
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'First Name',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              initialValue: vm.addStaffFirstName,
                              decoration: _dialogInputDecoration(hint: 'John'),
                              onChanged: vm.updateAddStaffFirstName,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Last Name',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              initialValue: vm.addStaffLastName,
                              decoration: _dialogInputDecoration(hint: 'Doe'),
                              onChanged: vm.updateAddStaffLastName,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: vm.addStaffEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _dialogInputDecoration(
                      hint: 'user@example.com',
                    ),
                    onChanged: vm.updateAddStaffEmail,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: vm.addStaffPassword,
                    obscureText: vm.addStaffPasswordObscure,
                    decoration: _dialogInputDecoration(hint: 'Min 8 characters')
                        .copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              vm.addStaffPasswordObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.textHint,
                              size: 20,
                            ),
                            onPressed: vm.toggleAddStaffPasswordVisibility,
                          ),
                        ),
                    onChanged: vm.updateAddStaffPassword,
                  ),
                ],

                const SizedBox(height: 20),
                const Text(
                  'Role',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: vm.addStaffDesignation,
                  decoration: _dialogInputDecoration(),
                  items: StaffDesignation.all.map((d) {
                    return DropdownMenuItem(
                      value: d,
                      child: Row(
                        children: [
                          Icon(
                            d == StaffDesignation.admin
                                ? Icons.admin_panel_settings
                                : Icons.person,
                            size: 18,
                            color: d == StaffDesignation.admin
                                ? AppColors.accent
                                : AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(StaffDesignation.getDisplayName(d)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) vm.updateAddStaffDesignation(value);
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.infoLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Role Permissions:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.info,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        vm.addStaffDesignation == StaffDesignation.admin
                            ? '• Full access to manage tenant settings\n• Can manage staff and all operations\n• Can update tenant information'
                            : '• Can manage bookings\n• Can view tenant data\n• Limited access to settings',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.info,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                vm.closeAddStaffDialog();
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

                      // Validate based on mode
                      if (vm.addStaffModeExisting) {
                        if (vm.addStaffUserId.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('User ID is required'),
                              backgroundColor: AppColors.error,
                            ),
                          );
                          return;
                        }
                      } else {
                        if (vm.addStaffEmail.isEmpty ||
                            vm.addStaffPassword.isEmpty ||
                            vm.addStaffFirstName.isEmpty ||
                            vm.addStaffLastName.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill all required fields'),
                              backgroundColor: AppColors.error,
                            ),
                          );
                          return;
                        }
                        if (vm.addStaffPassword.length < 8) {
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
                      }

                      final success = await vm.createStaffFromDialog(tenantId);

                      if (success && dialogContext.mounted) {
                        Navigator.pop(dialogContext);
                        _showSuccessSnackbar(
                          context,
                          vm.successMessage ?? 'Staff added successfully',
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
                  : const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }

  void _editStaff(BuildContext context, Staff staff, StaffViewModel vm) {
    vm.initializeEditStaffDialog(staff);

    showDialog(
      context: context,
      builder: (dialogContext) => Consumer<StaffViewModel>(
        builder: (context, vm, _) => AlertDialog(
          title: const Text(
            'Edit Staff Role',
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
                Text(
                  'User ID: ${staff.userId ?? 'Unknown'}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Role',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: vm.editStaffDesignation,
                  decoration: _dialogInputDecoration(),
                  items: StaffDesignation.all.map((d) {
                    return DropdownMenuItem(
                      value: d,
                      child: Row(
                        children: [
                          Icon(
                            d == StaffDesignation.admin
                                ? Icons.admin_panel_settings
                                : Icons.person,
                            size: 18,
                            color: d == StaffDesignation.admin
                                ? AppColors.accent
                                : AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(StaffDesignation.getDisplayName(d)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) vm.updateEditStaffDesignation(value);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                vm.closeEditStaffDialog();
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

                      final success = await vm.updateStaffFromDialog(tenantId);

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
                  : const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleStaffActive(
    BuildContext context,
    Staff staff,
    StaffViewModel vm,
    AuthViewModel authVm,
  ) {
    final tenantId = authVm.user?.tenantId;
    if (tenantId == null || staff.id == null) return;

    final isCurrentlyActive = staff.isActive ?? false;
    vm.updateStaff(
      tenantId: tenantId,
      staffId: staff.id!,
      isActive: !isCurrentlyActive,
    );
  }

  void _deleteStaff(
    BuildContext context,
    Staff staff,
    StaffViewModel vm,
    AuthViewModel authVm,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(
          'Remove Staff Member',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          'Are you sure you want to remove this staff member?\n\nUser ID: ${staff.userId ?? 'Unknown'}\n\nThey will lose access to this organization.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          Consumer<StaffViewModel>(
            builder: (context, vm, _) => ElevatedButton(
              onPressed: vm.isSaving
                  ? null
                  : () {
                      final tenantId = authVm.user?.tenantId;
                      if (tenantId == null || staff.id == null) {
                        Navigator.pop(dialogContext);
                        return;
                      }
                      vm.deleteStaff(tenantId: tenantId, staffId: staff.id!);
                      Navigator.pop(dialogContext);
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
                  : const Text('Remove'),
            ),
          ),
        ],
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
}
