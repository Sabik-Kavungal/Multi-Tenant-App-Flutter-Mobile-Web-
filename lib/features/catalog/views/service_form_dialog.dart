import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/constants/app_colors.dart';
import 'package:saasf/features/catalog/models/service_model.dart';
import 'package:saasf/features/catalog/viewmodels/service_vm.dart';

/// Service create/edit form – Catalog Service API
/// category_id, name, description, booking_type, duration (TIME), capacity (TOKEN/SEAT), price, is_active
class ServiceFormDialog extends StatelessWidget {
  const ServiceFormDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceViewModel>(
      builder: (context, vm, _) {
        if (!vm.isFormDialogOpen) return const SizedBox.shrink();

        final isTime = vm.formBookingType == BookingType.time;
        final isTokenOrSeat = vm.formBookingType == BookingType.token ||
            vm.formBookingType == BookingType.seat;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          vm.isEditMode ? 'Edit Service' : 'Create Service',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => vm.closeFormDialog(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  if (vm.error != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: AppColors.errorLight,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.errorBorder),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline,
                              color: AppColors.error, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              vm.error!,
                              style: const TextStyle(
                                  color: AppColors.error, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (vm.categoriesForForm.isEmpty && !vm.isLoadingCategories)
                    const ListTile(
                      title: Text('No categories. Create a category first.'),
                      subtitle: Text('Categories',
                          style: TextStyle(fontSize: 12)),
                    )
                  else if (vm.isLoadingCategories)
                    const InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Category *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.category_outlined),
                      ),
                      child: SizedBox(
                          height: 20, child: LinearProgressIndicator()),
                    )
                  else
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Category *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.category_outlined),
                      ),
                      value: vm.formCategoryId.isEmpty ? null : vm.formCategoryId,
                      items: vm.categoriesForForm
                          .where((c) => c.id != null && c.id!.isNotEmpty)
                          .map((c) => DropdownMenuItem(
                                value: c.id,
                                child: Text(c.name ?? c.id!),
                              ))
                          .toList(),
                      onChanged: (v) => vm.updateFormCategoryId(v ?? ''),
                    ),
                  const SizedBox(height: 16),

                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Name *',
                      hintText: 'e.g., General Check-up',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.label_outline),
                    ),
                    controller: TextEditingController(text: vm.formName)
                      ..selection = TextSelection.collapsed(
                          offset: vm.formName.length),
                    onChanged: vm.updateFormName,
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Optional (e.g. 30 min appointment)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.description_outlined),
                    ),
                    maxLines: 2,
                    controller: TextEditingController(text: vm.formDescription)
                      ..selection = TextSelection.collapsed(
                          offset: vm.formDescription.length),
                    onChanged: vm.updateFormDescription,
                  ),
                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Booking Type *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.schedule),
                    ),
                    value: vm.formBookingType,
                    items: BookingType.all
                        .map((t) => DropdownMenuItem(
                              value: t,
                              child: Text(BookingType.getDisplayName(t)),
                            ))
                        .toList(),
                    onChanged: (v) =>
                        vm.updateFormBookingType(v ?? BookingType.time),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'TIME=slots, TOKEN=queue, SEAT=reservation',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 16),

                  if (isTime)
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Duration (minutes) *',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      controller: TextEditingController(
                          text: vm.formDurationMinutes?.toString() ?? ''),
                      onChanged: (v) =>
                          vm.updateFormDurationMinutes(int.tryParse(v)),
                    ),
                  if (isTime) const SizedBox(height: 16),

                  if (isTokenOrSeat)
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Capacity *',
                        hintText: vm.formBookingType == BookingType.seat
                            ? 'e.g. 1'
                            : 'e.g. 100',
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      controller: TextEditingController(
                          text: vm.formCapacity?.toString() ?? ''),
                      onChanged: (v) =>
                          vm.updateFormCapacity(int.tryParse(v)),
                    ),
                  if (isTokenOrSeat) const SizedBox(height: 16),

                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Price *',
                      hintText: '0.00',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    controller: TextEditingController(
                        text: vm.formPrice > 0 ? vm.formPrice.toString() : ''),
                    onChanged: (v) =>
                        vm.updateFormPrice(double.tryParse(v) ?? 0),
                  ),
                  const SizedBox(height: 16),

                  SwitchListTile(
                    title: const Text('Active'),
                    subtitle: const Text('Service visible if active'),
                    value: vm.formIsActive,
                    onChanged: vm.updateFormIsActive,
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed:
                            vm.isSaving ? null : () => vm.closeFormDialog(),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: vm.isSaving
                            ? null
                            : () async {
                                await (vm.isEditMode
                                    ? vm.updateService()
                                    : vm.createService());
                                if (context.mounted) Navigator.pop(context);
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: vm.isSaving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : Text(
                                vm.isEditMode ? 'Update' : 'Create Service',
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
