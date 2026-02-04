import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/constants/constants.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';
import 'package:saasf/features/customer/services/customer_api_service.dart';
import 'package:saasf/features/tenant/models/tenant_model.dart';
import 'package:saasf/features/tenant/models/working_hours_model.dart';

/// Browse Businesses Page - Customer Home Screen
/// Displays list of available businesses/tenants to book appointments
class BrowseBusinessesPage extends StatefulWidget {
  const BrowseBusinessesPage({super.key});

  @override
  State<BrowseBusinessesPage> createState() => _BrowseBusinessesPageState();
}

class _BrowseBusinessesPageState extends State<BrowseBusinessesPage> {
  final TextEditingController _searchController = TextEditingController();
  final CustomerApiService _customerApiService = CustomerApiService();

  String _searchQuery = '';
  bool _isLoading = false;
  String? _error;
  List<Tenant> _tenants = [];
  Map<String, List<WorkingHours>> _workingHoursMap = {};
  Map<String, bool> _isOpenMap = {};

  @override
  void initState() {
    super.initState();
    _loadTenants();
  }

  Future<void> _loadTenants() async {
    final authVm = Provider.of<AuthViewModel>(context, listen: false);
    final token = authVm.token?.accessToken;

    if (token == null) {
      setState(() {
        _error = 'Not authenticated. Please login.';
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await _customerApiService.browseTenants(
        accessToken: token,
        context: context,
        page: 1,
        pageSize: 100, // Load more tenants
        status: 'ACTIVE', // CUSTOMER sees ACTIVE businesses by default
      );

      if (response.success && response.data != null) {
        setState(() {
          _tenants = response.data!.tenants;
          _isLoading = false;
        });

        // Load working hours for each tenant to determine if open
        _loadWorkingHoursForTenants();
      } else {
        setState(() {
          _error = response.error ?? 'Failed to load businesses';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error loading businesses: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadWorkingHoursForTenants() async {
    final authVm = Provider.of<AuthViewModel>(context, listen: false);
    final token = authVm.token?.accessToken;

    if (token == null) return;

    for (final tenant in _tenants) {
      if (tenant.id == null) continue;

      try {
        final hoursResponse = await _customerApiService.getTenantHours(
          tenantId: tenant.id!,
          accessToken: token,
          context: context,
        );

        if (hoursResponse.success && hoursResponse.data != null) {
          setState(() {
            _workingHoursMap[tenant.id!] = hoursResponse.data!;
            _isOpenMap[tenant.id!] = _calculateIsOpen(hoursResponse.data!);
          });
        }
      } catch (e) {
        print('Error loading working hours for tenant ${tenant.id}: $e');
      }
    }
  }

  bool _calculateIsOpen(List<WorkingHours> hours) {
    if (hours.isEmpty) return false;
    final now = DateTime.now();
    final currentDay = now.weekday == 7 ? 0 : now.weekday; // API: 0=Sun..6=Sat; Dart: 1=Mon..7=Sun
    final currentTime =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    final todayHours = hours.firstWhere(
      (h) => h.dayOfWeek == currentDay,
      orElse: () => const WorkingHours(isClosed: true),
    );

    if (todayHours.isClosed == true) return false;
    final open = extractTimeFromString(todayHours.openTime);
    final close = extractTimeFromString(todayHours.closeTime);
    if (open == null || close == null) return false;

    return currentTime.compareTo(open) >= 0 && currentTime.compareTo(close) <= 0;
  }

  String _getBusinessHours(String tenantId) {
    final hours = _workingHoursMap[tenantId];
    if (hours == null || hours.isEmpty) return 'Hours not available';

    final today = DateTime.now();
    final currentDay = today.weekday == 7 ? 0 : today.weekday; // API: 0=Sun..6=Sat
    final todayHours = hours.firstWhere(
      (h) => h.dayOfWeek == currentDay,
      orElse: () => const WorkingHours(isClosed: true),
    );

    if (todayHours.isClosed == true) return 'Closed today';
    final open = extractTimeFromString(todayHours.openTime);
    final close = extractTimeFromString(todayHours.closeTime);
    if (open == null || close == null) return 'Hours not set';

    return '$open – $close';
  }

  List<Tenant> get _filteredTenants {
    if (_searchQuery.isEmpty) return _tenants;
    return _tenants.where((tenant) {
      final name = (tenant.name ?? '').toLowerCase();
      final type = (tenant.type ?? '').toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || type.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Find a Business'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.primary,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Search businesses...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.textHint,
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: AppColors.textHint,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
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
          ),

          // Business List
          Expanded(
            child: _isLoading
                ? _buildLoadingState()
                : _error != null
                ? _buildErrorState()
                : _filteredTenants.isEmpty
                ? _buildEmptyState()
                : RefreshIndicator(
                    onRefresh: _loadTenants,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _filteredTenants.length,
                      itemBuilder: (context, index) {
                        return _buildBusinessCard(_filteredTenants[index]);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Loading businesses...',
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: AppColors.error),
            const SizedBox(height: 16),
            Text(
              'Error loading businesses',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _error ?? 'Unknown error',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: AppColors.textHint),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadTenants,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: AppColors.textHint),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isEmpty
                ? 'No businesses available'
                : 'No businesses found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isEmpty
                ? 'Check back later'
                : 'Try a different search term',
            style: const TextStyle(fontSize: 14, color: AppColors.textHint),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessCard(Tenant tenant) {
    final tenantId = tenant.id ?? '';
    final isOpen = _isOpenMap[tenantId] ?? false;
    final businessHours = _getBusinessHours(tenantId);
    final typeDisplay = TenantTypes.getDisplayName(tenant.type ?? 'OTHER');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          onTap: () {
            Navigator.pushNamed(context, '/business-detail', arguments: tenant);
          },
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
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.storefront,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Business Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tenant.name ?? 'Unnamed Business',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.business_outlined,
                                size: 14,
                                color: AppColors.textHint,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  typeDisplay,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textSecondary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Arrow
                    const Icon(Icons.chevron_right, color: AppColors.textHint),
                  ],
                ),
                const SizedBox(height: 16),
                // Divider
                const Divider(height: 1),
                const SizedBox(height: 12),
                // Footer Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Open/Closed Status
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isOpen
                            ? AppColors.success.withOpacity(0.1)
                            : AppColors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isOpen ? Icons.check_circle : Icons.cancel,
                            size: 14,
                            color: isOpen ? AppColors.success : AppColors.error,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isOpen ? 'Open' : 'Closed',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isOpen
                                  ? AppColors.success
                                  : AppColors.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Hours
                    Flexible(
                      child: Text(
                        businessHours,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textHint,
                        ),
                        overflow: TextOverflow.ellipsis,
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
