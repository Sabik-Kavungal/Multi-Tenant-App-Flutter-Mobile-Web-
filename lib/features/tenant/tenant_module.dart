import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/features/tenant/services/tenant_api_service.dart';
import 'package:saasf/features/tenant/viewmodels/tenant_vm.dart';
import 'package:saasf/features/tenant/viewmodels/tenant_management_vm.dart';
import 'package:saasf/features/tenant/viewmodels/tenant_settings_vm.dart';
import 'package:saasf/features/tenant/viewmodels/working_hours_vm.dart';
import 'package:saasf/features/tenant/viewmodels/holidays_vm.dart';
import 'package:saasf/features/tenant/viewmodels/staff_vm.dart';
import 'package:saasf/features/tenant/views/tenant_management_page.dart';
import 'package:saasf/features/tenant/views/tenant_settings_page.dart';
import 'package:saasf/features/tenant/views/working_hours_page.dart';
import 'package:saasf/features/tenant/views/holidays_page.dart';
import 'package:saasf/features/tenant/views/staff_page.dart';

/// Tenant Module
/// Provides all Tenant-related ViewModels and routes
///
/// Each page has its own ViewModel for better separation of concerns:
/// - TenantViewModel: Super Admin operations (all tenants list)
/// - TenantManagementViewModel: Tenant management page
/// - TenantSettingsViewModel: Settings page
/// - WorkingHoursViewModel: Working hours page
/// - HolidaysViewModel: Holidays page
/// - StaffViewModel: Staff page
///
/// API Endpoints (Tenant Service):
///
/// Tenant CRUD:
/// - POST /api/v1/tenants - Create tenant
/// - GET /api/v1/tenants/:id - Get tenant
/// - PUT /api/v1/tenants/:id - Update tenant (Admin only)
/// - DELETE /api/v1/tenants/:id - Delete tenant (Admin only)
///
/// Settings:
/// - GET /api/v1/tenants/:id/settings - Get settings
/// - PUT /api/v1/tenants/:id/settings - Update settings (Admin only)
///
/// Working Hours:
/// - GET /api/v1/tenants/:id/hours - Get working hours
/// - PUT /api/v1/tenants/:id/hours - Update working hours
///
/// Holidays:
/// - GET /api/v1/tenants/:id/holidays - Get holidays
/// - POST /api/v1/tenants/:id/holidays - Create holiday
/// - DELETE /api/v1/tenants/:id/holidays/:holiday_id - Delete holiday
///
/// Staff:
/// - GET /api/v1/tenants/:id/staff - Get staff
/// - POST /api/v1/tenants/:id/staff - Create staff
/// - PUT /api/v1/tenants/:id/staff/:staff_id - Update staff (Admin only)
/// - DELETE /api/v1/tenants/:id/staff/:staff_id - Delete staff (Admin only)
class TenantModule {
  /// Get Tenant providers
  /// Each page has its own ViewModel for better separation of concerns
  static List<ChangeNotifierProvider> getProviders() {
    final tenantApiService = TenantApiService();

    return [
      // TenantViewModel: For Super Admin operations (all tenants list)
      ChangeNotifierProvider<TenantViewModel>.value(
        value: TenantViewModel(tenantApiService),
      ),
      // TenantManagementViewModel: For tenant management page
      ChangeNotifierProvider<TenantManagementViewModel>.value(
        value: TenantManagementViewModel(tenantApiService),
      ),
      // TenantSettingsViewModel: For settings page
      ChangeNotifierProvider<TenantSettingsViewModel>.value(
        value: TenantSettingsViewModel(tenantApiService),
      ),
      // WorkingHoursViewModel: For working hours page
      ChangeNotifierProvider<WorkingHoursViewModel>.value(
        value: WorkingHoursViewModel(tenantApiService),
      ),
      // HolidaysViewModel: For holidays page
      ChangeNotifierProvider<HolidaysViewModel>.value(
        value: HolidaysViewModel(tenantApiService),
      ),
      // StaffViewModel: For staff page
      ChangeNotifierProvider<StaffViewModel>.value(
        value: StaffViewModel(tenantApiService),
      ),
    ];
  }

  /// Get Tenant routes
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/tenant/management': (context) => const TenantManagementPage(),
      '/tenant/settings': (context) => const TenantSettingsPage(),
      '/tenant/hours': (context) => const WorkingHoursPage(),
      '/tenant/holidays': (context) => const HolidaysPage(),
      '/tenant/staff': (context) => const StaffPage(),
    };
  }
}
