import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/storage/hive_service.dart';
import 'package:saasf/features/auth/auth_module.dart';
import 'package:saasf/features/tenant/tenant_module.dart';
import 'package:saasf/features/catalog/catalog_module.dart';
import 'package:saasf/features/booking/booking_module.dart';
import 'package:saasf/features/dashboard/views/main_shell.dart';
import 'package:saasf/features/tenant/views/tenant_management_page.dart';
import 'package:saasf/features/ai/views/ai_features_page.dart';
// Customer screens
import 'package:saasf/features/customer/views/browse_businesses_page.dart';
import 'package:saasf/features/customer/views/business_detail_page.dart';
import 'package:saasf/features/booking/views/bookings_list_page.dart';
// Staff screens
import 'package:saasf/features/staff/views/my_schedule_page.dart';
import 'package:saasf/features/staff/views/queue_management_page.dart';
// Super Admin screens
import 'package:saasf/features/superadmin/views/all_tenants_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage
  await HiveService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...AuthModule.getProviders(),
        ...TenantModule.getProviders(),
        ...CatalogModule.getProviders(),
        ...BookingModule.getProviders(),
      ],
      child: MaterialApp(
        title: 'SaaS App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Classic & Elegant Color Scheme
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1a237e),
            primary: const Color(0xFF1a237e),
            secondary: const Color(0xFF616161),
            background: const Color(0xFFFAFAFA),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          primaryColor: const Color(0xFF1a237e),
          scaffoldBackgroundColor: const Color(0xFFFAFAFA),
          // Classic Typography
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w300,
              color: Color(0xFF212121),
            ),
            headlineMedium: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Color(0xFF212121),
            ),
            headlineSmall: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF212121),
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF212121),
            ),
            bodyMedium: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF212121),
            ),
            bodySmall: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF616161),
            ),
          ),
          // Classic Button Styles
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1a237e),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF1a237e),
              side: const BorderSide(color: Color(0xFF1a237e)),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          // Classic Input Style
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
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
              borderSide: const BorderSide(
                color: Color(0xFF1a237e),
                width: 1.5,
              ),
            ),
          ),
          // Classic AppBar
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1a237e),
            foregroundColor: Colors.white,
            elevation: 1,
            titleTextStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          // Classic Card Style
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: Colors.white,
          ),
          // Classic Divider
          dividerTheme: DividerThemeData(color: Colors.grey[300], thickness: 1),
        ),
        // Start with splash page to check auth state
        initialRoute: '/splash',
        routes: {
          ...AuthModule.getRoutes(),
          ...TenantModule.getRoutes(),
          '/home': (context) => const MainShell(),

          // ============================================
          // TENANT ADMIN ROUTES
          // ============================================
          '/tenant/management': (context) => const TenantManagementPage(),

          // ============================================
          // CUSTOMER ROUTES
          // ============================================
          '/browse-businesses': (context) => const BrowseBusinessesPage(),
          '/business-detail': (context) => const BusinessDetailPage(),
          '/my-bookings': (context) => const BookingsListPage(),

          // ============================================
          // STAFF ROUTES
          // ============================================
          '/my-schedule': (context) => const MySchedulePage(),
          '/queue-management': (context) => const QueueManagementPage(),

          // ============================================
          // SUPER ADMIN ROUTES
          // ============================================
          '/all-tenants': (context) => const AllTenantsPage(),

          // ============================================
          // CATALOG ROUTES (ADMIN, SUPER_ADMIN, STAFF, CUSTOMER)
          // ============================================
          ...CatalogModule.getRoutes(),

          // ============================================
          // BOOKING ROUTES
          // ============================================
          ...BookingModule.getRoutes(),

          // ============================================
          // AI FEATURES (Shared)
          // ============================================
          '/ai-features': (context) => const AiFeaturesPage(),
        },
      ),
    );
  }
}
