import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/constants/app_colors.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';
import 'package:saasf/features/catalog/models/service_model.dart';
import 'package:saasf/features/catalog/viewmodels/service_vm.dart';
import 'package:saasf/features/catalog/views/service_form_dialog.dart';

/// Services list and management – Catalog Service API
/// Replaces Offerings: category, name, booking_type, duration/capacity, price, is_active
class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  bool _isInitialized = false;

  void _showServiceDialog(BuildContext context, ServiceViewModel vm) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const ServiceFormDialog(),
    ).then((_) {
      if (vm.isFormDialogOpen) vm.closeFormDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthViewModel, ServiceViewModel>(
      builder: (context, authVm, vm, _) {
        final tenantId = authVm.user?.tenantId;
        final accessToken = authVm.token?.accessToken;

        if (tenantId != null &&
            tenantId.isNotEmpty &&
            accessToken != null &&
            !_isInitialized) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            vm.initialize(
              context: context,
              accessToken: accessToken,
              tenantId: tenantId,
            );
            vm.loadServices();
            _isInitialized = true;
          });
        }

        final canModify =
            authVm.user?.role == 'ADMIN' || authVm.user?.role == 'SUPER_ADMIN';

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.miscellaneous_services, size: 20),
                ),
                const SizedBox(width: 12),
                const Text('Services'),
              ],
            ),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 1,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: tenantId != null ? () => vm.refreshServices() : null,
                tooltip: 'Refresh',
              ),
            ],
          ),
          floatingActionButton: canModify
              ? FloatingActionButton.extended(
                  onPressed: () {
                    vm.openCreateDialog();
                    _showServiceDialog(context, vm);
                  },
                  backgroundColor: AppColors.primary,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'New Service',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                )
              : null,
          body: vm.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : Column(
                  children: [
                    _buildHeader(vm, canModify),
                    if (vm.error != null) _buildError(vm),
                    if (vm.successMessage != null) _buildSuccess(vm),
                    if (canModify) _buildFilters(context, vm),
                    Expanded(
                      child: vm.services.isEmpty
                          ? _buildEmptyState(context, vm, canModify)
                          : RefreshIndicator(
                              onRefresh: () => vm.refreshServices(),
                              color: AppColors.primary,
                              child: GridView.builder(
                                padding: const EdgeInsets.all(20),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 1.05,
                                ),
                                itemCount: vm.services.length,
                                itemBuilder: (context, index) =>
                                    _buildServiceCard(
                                  context,
                                  vm.services[index],
                                  vm,
                                  canModify,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildHeader(ServiceViewModel vm, bool canModify) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Catalog Services',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${vm.total} ${vm.total == 1 ? 'service' : 'services'}',
                  style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          if (canModify)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.admin_panel_settings,
                      size: 16, color: AppColors.primary),
                  const SizedBox(width: 6),
                  Text(
                    'Admin Mode',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildError(ServiceViewModel vm) {
    return Container(
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
          const Icon(Icons.error_outline, color: AppColors.error, size: 20),
          const SizedBox(width: 12),
          Expanded(
              child: Text(vm.error!,
                  style: const TextStyle(
                      color: AppColors.error, fontSize: 14))),
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

  Widget _buildSuccess(ServiceViewModel vm) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline,
              color: Colors.green.shade700, size: 20),
          const SizedBox(width: 12),
          Expanded(
              child: Text(vm.successMessage!,
                  style: TextStyle(
                      color: Colors.green.shade700, fontSize: 14))),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: () => vm.clearSuccessMessage(),
            color: Colors.green.shade700,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(BuildContext context, ServiceViewModel vm) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        children: [
          Text(
            'Filter:',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.border),
            ),
            child: DropdownButton<String?>(
              value: vm.categoryIdFilter,
              hint: const Text('All categories'),
              isDense: true,
              underline: const SizedBox(),
              items: [
                const DropdownMenuItem<String?>(
                    value: null, child: Text('All categories')),
                ...vm.categoriesForForm
                    .where((c) => c.id != null && c.id!.isNotEmpty)
                    .map((c) => DropdownMenuItem<String?>(
                          value: c.id,
                          child: Text(c.name ?? c.id!,
                              overflow: TextOverflow.ellipsis),
                        )),
              ],
              onChanged: (v) =>
                  vm.loadServices(categoryId: v, isActive: vm.isActiveFilter),
            ),
          ),
          const SizedBox(width: 12),
          _buildChip('All', vm.isActiveFilter == null,
              () => vm.loadServices(categoryId: vm.categoryIdFilter)),
          const SizedBox(width: 8),
          _buildChip(
              'Active',
              vm.isActiveFilter == true,
              () => vm.loadServices(
                  categoryId: vm.categoryIdFilter, isActive: true)),
          const SizedBox(width: 8),
          _buildChip(
              'Inactive',
              vm.isActiveFilter == false,
              () => vm.loadServices(
                  categoryId: vm.categoryIdFilter, isActive: false)),
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool selected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: 1),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(
      BuildContext context, ServiceViewModel vm, bool canModify) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.miscellaneous_services,
                  size: 64, color: AppColors.primary.withOpacity(0.6)),
            ),
            const SizedBox(height: 24),
            Text(
              'No Services Yet',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            Text(
              canModify
                  ? 'Add TIME, TOKEN, or SEAT services.\nClick "New Service" to get started.'
                  : 'Services will appear here once created.',
              style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5),
              textAlign: TextAlign.center,
            ),
            if (canModify) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  vm.openCreateDialog();
                  _showServiceDialog(context, vm);
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Create First Service'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    Service s,
    ServiceViewModel vm,
    bool canModify,
  ) {
    final bt = s.bookingType ?? BookingType.time;
    Color badgeColor = AppColors.primary;
    if (bt == BookingType.token) badgeColor = const Color(0xFFD97706);
    if (bt == BookingType.seat) badgeColor = const Color(0xFF059669);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.border),
      ),
      color: AppColors.surface,
      child: InkWell(
        onTap: canModify
            ? () {
                vm.openEditDialog(s);
                _showServiceDialog(context, vm);
              }
            : null,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: badgeColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: badgeColor.withOpacity(0.4)),
                    ),
                    child: Text(bt,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: badgeColor)),
                  ),
                  const Spacer(),
                  if (canModify)
                    PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert,
                          size: 20, color: AppColors.textSecondary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      onSelected: (v) {
                        if (v == 'edit') {
                          vm.openEditDialog(s);
                          _showServiceDialog(context, vm);
                        } else if (v == 'delete') {
                          _showDeleteDialog(context, s, vm);
                        }
                      },
                      itemBuilder: (ctx) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit_outlined,
                                  size: 18, color: AppColors.primary),
                              const SizedBox(width: 8),
                              const Text('Edit'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline,
                                  size: 18, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Delete',
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                s.name ?? '',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                vm.getCategoryName(s.categoryId) ?? s.categoryId ?? '-',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              const Spacer(),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  if (bt == BookingType.time &&
                      (s.durationMinutes ?? 0) > 0)
                    Text('${s.durationMinutes} min',
                        style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary)),
                  if ((bt == BookingType.seat || bt == BookingType.token) &&
                      (s.capacity ?? 0) > 0)
                    Text('Cap: ${s.capacity}',
                        style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary)),
                  Text(
                    '\$${s.price?.toStringAsFixed(2) ?? "0.00"}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (s.isActive ?? true)
                      ? AppColors.successLight
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: (s.isActive ?? true)
                        ? AppColors.success.withOpacity(0.3)
                        : Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: (s.isActive ?? true)
                            ? AppColors.success
                            : Colors.grey.shade600,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      (s.isActive ?? true) ? 'Active' : 'Inactive',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: (s.isActive ?? true)
                            ? AppColors.success
                            : Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context, Service s, ServiceViewModel vm) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Service'),
        content: Text(
            'Are you sure you want to delete "${s.name}"? This cannot be undone.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final ok = await vm.deleteService(s.id!);
              if (context.mounted && ok) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Service deleted'),
                      backgroundColor: Colors.green),
                );
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
