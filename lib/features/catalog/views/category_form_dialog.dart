import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/constants/app_colors.dart';
import 'package:saasf/features/catalog/viewmodels/category_vm.dart';

/// Category Form Dialog – name, is_active only (Catalog Service API)
class CategoryFormDialog extends StatelessWidget {
  const CategoryFormDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryViewModel>(
      builder: (context, vm, _) {
        if (!vm.isFormDialogOpen) return const SizedBox.shrink();

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        vm.isEditMode ? 'Edit Category' : 'Create Category',
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
                      ],
                    ),
                  ),

                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Category Name *',
                    hintText: 'e.g., Consultation',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.label_outline),
                  ),
                  controller: TextEditingController(text: vm.formName)
                    ..selection = TextSelection.collapsed(
                      offset: vm.formName.length,
                    ),
                  onChanged: (value) => vm.updateFormName(value),
                ),
                const SizedBox(height: 16),

                SwitchListTile(
                  title: const Text('Active'),
                  subtitle: const Text('Category will be visible if active'),
                  value: vm.formIsActive,
                  onChanged: (value) => vm.updateFormIsActive(value),
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: vm.isSaving
                          ? null
                          : () => vm.closeFormDialog(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: vm.isSaving
                          ? null
                          : () async {
                              final success = vm.isEditMode
                                  ? await vm.updateCategory()
                                  : await vm.createCategory();
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
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
                                  Colors.white,
                                ),
                              ),
                            )
                          : Text(vm.isEditMode ? 'Update' : 'Create'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
