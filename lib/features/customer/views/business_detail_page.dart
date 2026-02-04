import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/constants/constants.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';
import 'package:saasf/features/catalog/models/service_model.dart';
import 'package:saasf/features/catalog/services/service_api_service.dart';
import 'package:saasf/features/customer/services/customer_api_service.dart';
import 'package:saasf/features/tenant/models/tenant_model.dart';
import 'package:saasf/features/tenant/models/working_hours_model.dart';
import 'package:saasf/features/tenant/models/holiday_model.dart';

/// Business Detail Page - Customer views business info, hours, holidays and catalog.
/// Uses GET /tenants/:id, /hours, /holidays; GET /services with X-Tenant-ID.
/// "Book" on a service → /bookings/create with tenantId + serviceId.
class BusinessDetailPage extends StatefulWidget {
  const BusinessDetailPage({super.key});

  @override
  State<BusinessDetailPage> createState() => _BusinessDetailPageState();
}

class _BusinessDetailPageState extends State<BusinessDetailPage> {
  final CustomerApiService _customerApi = CustomerApiService();
  final ServiceApiService _serviceApi = ServiceApiService();

  List<WorkingHours> _hours = [];
  List<Holiday> _holidays = [];
  List<Service> _services = [];
  bool _loadingHours = true;
  bool _loadingServices = true;
  String? _errorHours;
  String? _errorServices;

  @override
  void initState() {
    super.initState();
    // Defer _loadData to after first frame: _tenant uses ModalRoute.of(context),
    // which must not be called before initState completes.
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    final tenant = _tenant;
    if (tenant?.id == null) return;

    final authVm = context.read<AuthViewModel>();
    final token = authVm.token?.accessToken;
    if (token == null) return;

    setState(() {
      _loadingHours = true;
      _loadingServices = true;
      _errorHours = null;
      _errorServices = null;
    });

    final tid = tenant!.id!;

    // GET /tenants/:id/hours
    final hRes = await _customerApi.getTenantHours(
      tenantId: tid,
      accessToken: token,
      context: context,
    );
    if (mounted) {
      setState(() {
        _loadingHours = false;
        _hours = hRes.success && hRes.data != null ? hRes.data! : [];
        _errorHours = hRes.success ? null : (hRes.error ?? 'Failed to load hours');
      });
    }

    // GET /tenants/:id/holidays
    final holRes = await _customerApi.getTenantHolidays(
      tenantId: tid,
      accessToken: token,
      context: context,
    );
    if (mounted) {
      setState(() {
        _holidays = holRes.success && holRes.data != null ? holRes.data! : [];
      });
    }

    // GET /services with X-Tenant-ID (Catalog)
    final sRes = await _serviceApi.listServices(
      tenantId: tid,
      isActive: true,
      accessToken: token,
      context: context,
    );
    if (mounted) {
      setState(() {
        _loadingServices = false;
        _services = sRes.success && sRes.data != null ? sRes.data! : [];
        _errorServices = sRes.success ? null : (sRes.error ?? 'Failed to load services');
      });
    }
  }

  Tenant? get _tenant {
    final args = ModalRoute.of(context)?.settings.arguments;
    return args is Tenant ? args : null;
  }

  bool _isOpen(List<WorkingHours> hours) {
    if (hours.isEmpty) return false;
    final now = DateTime.now();
    final day = now.weekday == 7 ? 0 : now.weekday; // API: 0=Sun..6=Sat; Dart: 1=Mon..7=Sun
    final time = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    final h = hours.firstWhere(
      (e) => e.dayOfWeek == day,
      orElse: () => const WorkingHours(isClosed: true),
    );
    if (h.isClosed == true) return false;
    final open = extractTimeFromString(h.openTime);
    final close = extractTimeFromString(h.closeTime);
    if (open == null || close == null) return false;
    return time.compareTo(open) >= 0 && time.compareTo(close) <= 0;
  }

  String _todayHours(List<WorkingHours> hours) {
    if (hours.isEmpty) return 'Hours not available';
    final now = DateTime.now();
    final day = now.weekday == 7 ? 0 : now.weekday;
    final h = hours.firstWhere(
      (e) => e.dayOfWeek == day,
      orElse: () => const WorkingHours(isClosed: true),
    );
    if (h.isClosed == true) return 'Closed today';
    final open = extractTimeFromString(h.openTime);
    final close = extractTimeFromString(h.closeTime);
    if (open == null || close == null) return '—';
    return '$open–$close';
  }

  @override
  Widget build(BuildContext context) {
    final tenant = _tenant;

    if (tenant == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Business'), backgroundColor: AppColors.primary, foregroundColor: Colors.white),
        body: const Center(child: Text('Business not found')),
      );
    }

    final isOpen = _isOpen(_hours);
    final todayStr = _todayHours(_hours);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                tenant.name ?? 'Business',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                ),
                child: const Center(child: Icon(Icons.storefront, size: 64, color: Colors.white24)),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoCard(tenant, isOpen, todayStr),
                  const SizedBox(height: 24),
                  _hoursSection(),
                  const SizedBox(height: 24),
                  if (_holidays.isNotEmpty) ...[
                    _holidaysSection(),
                    const SizedBox(height: 24),
                  ],
                  _servicesSection(tenant.id!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(Tenant tenant, bool isOpen, String todayStr) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.business_outlined, size: 20, color: AppColors.textSecondary),
              const SizedBox(width: 12),
              Text(
                TenantTypes.getDisplayName(tenant.type ?? 'OTHER'),
                style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.access_time, size: 20, color: AppColors.textSecondary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _loadingHours ? 'Loading…' : todayStr,
                  style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isOpen ? AppColors.success.withOpacity(0.1) : AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  isOpen ? 'Open' : 'Closed',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isOpen ? AppColors.success : AppColors.error),
                ),
              ),
            ],
          ),
          if (tenant.timezone != null && tenant.timezone!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.schedule, size: 20, color: AppColors.textSecondary),
                const SizedBox(width: 12),
                Text(tenant.timezone!, style: const TextStyle(fontSize: 14, color: AppColors.textPrimary)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _hoursSection() {
    if (_loadingHours && _hours.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Working hours', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        if (_errorHours != null) ...[
          const SizedBox(height: 8),
          Text(_errorHours!, style: const TextStyle(fontSize: 14, color: AppColors.error)),
        ],
        const SizedBox(height: 12),
        ...DayOfWeek.names.asMap().entries.map((e) {
          final h = _hours.firstWhere(
            (x) => x.dayOfWeek == e.key,
            orElse: () => const WorkingHours(isClosed: true),
          );
          final label = h.isClosed == true ? 'Closed' : '${h.openTime ?? '—'} – ${h.closeTime ?? '—'}';
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(e.value, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                Text(label, style: const TextStyle(fontSize: 14, color: AppColors.textPrimary)),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _holidaysSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Holidays', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 12),
        ..._holidays.take(5).map((h) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(Icons.event_busy, size: 18, color: AppColors.textHint),
                  const SizedBox(width: 8),
                  Text(h.holidayDate ?? '—', style: const TextStyle(fontSize: 14, color: AppColors.textPrimary)),
                  if (h.reason != null && h.reason!.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Text('· ${h.reason}', style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                  ],
                ],
              ),
            )),
      ],
    );
  }

  Widget _servicesSection(String tenantId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Services', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 12),
        if (_loadingServices)
          const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator(color: AppColors.primary)))
        else if (_errorServices != null)
          Text(_errorServices!, style: const TextStyle(fontSize: 14, color: AppColors.error))
        else if (_services.isEmpty)
          const Text('No services available', style: TextStyle(fontSize: 14, color: AppColors.textSecondary))
        else
          ..._services.map((s) => _serviceCard(s, tenantId)),
      ],
    );
  }

  Widget _serviceCard(Service s, String tenantId) {
    final duration = s.durationMinutes != null ? '${s.durationMinutes} min' : '';
    final price = s.price != null ? '\$${s.price!.toStringAsFixed(2)}' : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _goToCreate(tenantId, s.id),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.name ?? '—', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      if (duration.isNotEmpty) Text(duration, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                      if (s.bookingType != null) Text(BookingType.getDisplayName(s.bookingType!), style: const TextStyle(fontSize: 12, color: AppColors.textHint)),
                    ],
                  ),
                ),
                Text(price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: () => _goToCreate(tenantId, s.id),
                  style: FilledButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
                  child: const Text('Book'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goToCreate(String tenantId, String? serviceId) {
    Navigator.pushNamed(context, '/bookings/create', arguments: <String, String?>{'tenantId': tenantId, 'serviceId': serviceId});
  }
}
