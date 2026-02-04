import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/constants/constants.dart';
import 'package:saasf/core/constants/roles.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';

/// Home Dashboard - Main landing page after login
/// Shows role-appropriate content:
/// - ADMIN: Tenant management features
/// - SUPER_ADMIN: Platform overview
/// Classic & Elegant Design with card grid
class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();
    final user = authVm.user;
    final isSuperAdmin = Roles.isSuperAdmin(user?.role);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(isSuperAdmin ? 'Platform Dashboard' : 'Dashboard'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications coming soon')),
              );
            },
          ),
        ],
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Card
                  _buildWelcomeCard(user),
                  const SizedBox(height: 24),

                  // Quick Stats
                  _buildSectionTitle(
                    isSuperAdmin ? 'Platform Overview' : 'Overview',
                  ),
                  const SizedBox(height: 12),
                  isSuperAdmin ? _buildSuperAdminStats() : _buildQuickStats(),
                  const SizedBox(height: 24),

                  // Features Grid
                  _buildSectionTitle(isSuperAdmin ? 'Management' : 'Features'),
                  const SizedBox(height: 12),
                  isSuperAdmin
                      ? _buildSuperAdminFeaturesGrid(context)
                      : _buildFeaturesGrid(context),
                ],
              ),
            ),
    );
  }

  Widget _buildWelcomeCard(dynamic user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '${user.firstName?.substring(0, 1) ?? ''}${user.lastName?.substring(0, 1) ?? ''}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${user.firstName ?? ''} ${user.lastName ?? ''}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    user.role ?? 'User',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.calendar_today_outlined,
            value: '12',
            label: 'Bookings',
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.people_outline,
            value: '45',
            label: 'Customers',
            color: AppColors.accent,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.trending_up,
            value: '89%',
            label: 'Growth',
            color: AppColors.success,
          ),
        ),
      ],
    );
  }

  Widget _buildSuperAdminStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.business,
            value: '24',
            label: 'Tenants',
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.people_outline,
            value: '156',
            label: 'Total Staff',
            color: AppColors.accent,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.attach_money,
            value: '\$12K',
            label: 'Revenue',
            color: AppColors.success,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesGrid(BuildContext context) {
    final features = [
      _FeatureItem(
        icon: Icons.business_outlined,
        title: 'Tenant',
        subtitle: 'Manage organization',
        color: AppColors.primary,
        onTap: () => _showComingSoon(context, 'Tenant Management'),
      ),
      _FeatureItem(
        icon: Icons.calendar_month_outlined,
        title: 'Bookings',
        subtitle: 'View appointments',
        color: const Color(0xFF7C3AED),
        onTap: () => Navigator.pushNamed(context, '/bookings'),
      ),
      _FeatureItem(
        icon: Icons.category_outlined,
        title: 'Categories',
        subtitle: 'Manage catalog',
        color: const Color(0xFF059669),
        onTap: () => Navigator.pushNamed(context, '/catalog/categories'),
      ),
      _FeatureItem(
        icon: Icons.miscellaneous_services,
        title: 'Services',
        subtitle: 'TIME, TOKEN, SEAT services',
        color: const Color(0xFF0D9488),
        onTap: () => Navigator.pushNamed(context, '/catalog/services'),
      ),
      _FeatureItem(
        icon: Icons.queue_outlined,
        title: 'Queue',
        subtitle: 'Real-time queue',
        color: const Color(0xFFD97706),
        onTap: () => Navigator.pushNamed(context, '/queue-management'),
      ),
      _FeatureItem(
        icon: Icons.payment_outlined,
        title: 'Payments',
        subtitle: 'Transactions',
        color: const Color(0xFFDC2626),
        onTap: () => _showComingSoon(context, 'Payments'),
      ),
      _FeatureItem(
        icon: Icons.psychology_outlined,
        title: 'AI Features',
        subtitle: 'Smart predictions',
        color: const Color(0xFF2563EB),
        onTap: () => Navigator.pushNamed(context, '/ai-features'),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.3,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) => _buildFeatureCard(features[index]),
    );
  }

  Widget _buildSuperAdminFeaturesGrid(BuildContext context) {
    final features = [
      _FeatureItem(
        icon: Icons.business_outlined,
        title: 'All Tenants',
        subtitle: 'Manage tenants',
        color: AppColors.primary,
        onTap: () => Navigator.pushNamed(context, '/all-tenants'),
      ),
      _FeatureItem(
        icon: Icons.category_outlined,
        title: 'Categories',
        subtitle: 'Manage catalog',
        color: const Color(0xFF059669),
        onTap: () => Navigator.pushNamed(context, '/catalog/categories'),
      ),
      _FeatureItem(
        icon: Icons.miscellaneous_services,
        title: 'Services',
        subtitle: 'TIME, TOKEN, SEAT services',
        color: const Color(0xFF0D9488),
        onTap: () => Navigator.pushNamed(context, '/catalog/services'),
      ),
      _FeatureItem(
        icon: Icons.analytics_outlined,
        title: 'Analytics',
        subtitle: 'Platform stats',
        color: const Color(0xFF7C3AED),
        onTap: () => _showComingSoon(context, 'Analytics'),
      ),
      _FeatureItem(
        icon: Icons.settings_outlined,
        title: 'Settings',
        subtitle: 'Platform config',
        color: const Color(0xFF059669),
        onTap: () => _showComingSoon(context, 'Platform Settings'),
      ),
      _FeatureItem(
        icon: Icons.payment_outlined,
        title: 'Billing',
        subtitle: 'Subscriptions',
        color: const Color(0xFFD97706),
        onTap: () => _showComingSoon(context, 'Billing'),
      ),
      _FeatureItem(
        icon: Icons.support_agent_outlined,
        title: 'Support',
        subtitle: 'Help desk',
        color: const Color(0xFFDC2626),
        onTap: () => _showComingSoon(context, 'Support'),
      ),
      _FeatureItem(
        icon: Icons.psychology_outlined,
        title: 'AI Features',
        subtitle: 'Smart predictions',
        color: const Color(0xFF2563EB),
        onTap: () => Navigator.pushNamed(context, '/ai-features'),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.3,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) => _buildFeatureCard(features[index]),
    );
  }

  Widget _buildFeatureCard(_FeatureItem feature) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: feature.onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: feature.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(feature.icon, color: feature.color, size: 24),
              ),
              const SizedBox(height: 12),
              Text(
                feature.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                feature.subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature coming soon'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}

class _FeatureItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  _FeatureItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });
}
