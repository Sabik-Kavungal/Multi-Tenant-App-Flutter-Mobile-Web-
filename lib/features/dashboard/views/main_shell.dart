import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/constants/constants.dart';
import 'package:saasf/core/constants/roles.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';
import 'package:saasf/features/dashboard/views/home_dashboard.dart';
import 'package:saasf/features/tenant/views/tenant_management_page.dart';
import 'package:saasf/features/profile/views/profile_page.dart';
// Customer imports
import 'package:saasf/features/customer/views/browse_businesses_page.dart';
import 'package:saasf/features/booking/views/bookings_list_page.dart';
// Staff imports
import 'package:saasf/features/staff/views/my_schedule_page.dart';
import 'package:saasf/features/staff/views/queue_management_page.dart';
// Super Admin imports
import 'package:saasf/features/superadmin/views/all_tenants_page.dart';

/// Main Shell - Role-Based Bottom Navigation Container
/// Shows different navigation items based on user role:
/// - CUSTOMER: Browse, My Bookings, Profile
/// - STAFF: Schedule, Queue, Profile
/// - ADMIN: Dashboard, Tenant, More
/// - SUPER_ADMIN: Tenants, Platform, Settings
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  /// Get pages based on user role
  List<Widget> _getPages(String? role) {
    if (Roles.isCustomer(role)) {
      return const [BrowseBusinessesPage(), BookingsListPage(), ProfilePage()];
    } else if (Roles.isStaff(role)) {
      return const [MySchedulePage(), QueueManagementPage(), ProfilePage()];
    } else if (Roles.isSuperAdmin(role)) {
      return const [
        AllTenantsPage(),
        HomeDashboard(), // Platform Dashboard
        ProfilePage(),
      ];
    } else {
      // Default: Admin (Tenant Admin)
      return const [HomeDashboard(), TenantManagementPage(), ProfilePage()];
    }
  }

  /// Get navigation items based on user role
  List<_NavItem> _getNavItems(String? role) {
    if (Roles.isCustomer(role)) {
      return [
        _NavItem(
          icon: Icons.search_outlined,
          activeIcon: Icons.search,
          label: 'Browse',
        ),
        _NavItem(
          icon: Icons.calendar_today_outlined,
          activeIcon: Icons.calendar_today,
          label: 'Bookings',
        ),
        _NavItem(
          icon: Icons.person_outline,
          activeIcon: Icons.person,
          label: 'Profile',
        ),
      ];
    } else if (Roles.isStaff(role)) {
      return [
        _NavItem(
          icon: Icons.schedule_outlined,
          activeIcon: Icons.schedule,
          label: 'Schedule',
        ),
        _NavItem(
          icon: Icons.queue_outlined,
          activeIcon: Icons.queue,
          label: 'Queue',
        ),
        _NavItem(
          icon: Icons.person_outline,
          activeIcon: Icons.person,
          label: 'Profile',
        ),
      ];
    } else if (Roles.isSuperAdmin(role)) {
      return [
        _NavItem(
          icon: Icons.business_outlined,
          activeIcon: Icons.business,
          label: 'Tenants',
        ),
        _NavItem(
          icon: Icons.dashboard_outlined,
          activeIcon: Icons.dashboard,
          label: 'Platform',
        ),
        _NavItem(
          icon: Icons.settings_outlined,
          activeIcon: Icons.settings,
          label: 'Settings',
        ),
      ];
    } else {
      // Default: Admin (Tenant Admin)
      return [
        _NavItem(
          icon: Icons.home_outlined,
          activeIcon: Icons.home,
          label: 'Dashboard',
        ),
        _NavItem(
          icon: Icons.business_outlined,
          activeIcon: Icons.business,
          label: 'Tenant',
        ),
        _NavItem(
          icon: Icons.more_horiz_outlined,
          activeIcon: Icons.more_horiz,
          label: 'More',
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();
    final userRole = authVm.user?.role;

    // Set context for API calls
    authVm.setContext(context);

    // Update navigation callback
    authVm.onNavigate = (route) {
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed(route);
      }
    };

    // Show success message after login
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authVm.showLoginSuccess && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Welcome back, ${authVm.user?.firstName ?? 'User'}!',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.primary,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
        authVm.clearLoginSuccess();
      }
    });

    final pages = _getPages(userRole);
    final navItems = _getNavItems(userRole);

    // Ensure current index is valid
    if (_currentIndex >= pages.length) {
      _currentIndex = 0;
    }

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                navItems.length,
                (index) => _buildNavItem(
                  index: index,
                  icon: navItems[index].icon,
                  activeIcon: navItems[index].activeIcon,
                  label: navItems[index].label,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isActive = _currentIndex == index;

    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? AppColors.primary : AppColors.textHint,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppColors.primary : AppColors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Navigation item data class
class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  _NavItem({required this.icon, required this.activeIcon, required this.label});
}
