import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/features/catalog/services/category_api_service.dart';
import 'package:saasf/features/catalog/services/service_api_service.dart';
import 'package:saasf/features/catalog/viewmodels/category_vm.dart';
import 'package:saasf/features/catalog/viewmodels/service_vm.dart';
import 'package:saasf/features/catalog/views/categories_page.dart';
import 'package:saasf/features/catalog/views/services_page.dart';

/// Catalog Module – Catalog Service API
/// Base: /api/v1; X-Tenant-ID header. Response: { success, data, error }
///
/// - Categories: GET/POST/PUT/DELETE /categories (name, is_active)
/// - Services: GET/POST/PUT/DELETE /services (category_id, name, description,
///   booking_type TIME|TOKEN|SEAT, duration_minutes, capacity, price, is_active)
class CatalogModule {
  static List<ChangeNotifierProvider> getProviders() {
    final categoryApiService = CategoryApiService();
    final serviceApiService = ServiceApiService();

    return [
      ChangeNotifierProvider<CategoryViewModel>.value(
        value: CategoryViewModel(categoryApiService),
      ),
      ChangeNotifierProvider<ServiceViewModel>.value(
        value: ServiceViewModel(serviceApiService, categoryApiService),
      ),
    ];
  }

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/catalog/categories': (context) => const CategoriesPage(),
      '/catalog/services': (context) => const ServicesPage(),
    };
  }
}
