/// API Endpoints for the application
/// Maps to SaaS Platform API v1
class ApiEndpoints {
  // Base URL - matches SaaS Platform API
  // Use Kong Gateway (8000) or direct (8081)
  static const String baseUrl = 'http://192.168.1.5:8000/api/v1';

  // Health Check
  static const String health = '/health';

  // ============================================
  // AUTH SERVICE ENDPOINTS
  // ============================================
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String me = '/auth/me';
  static const String changePassword = '/auth/change-password';

  // Super Admin - User Management (Protected Endpoints)
  static const String createUser = '/auth/users';
  static const String listUsers =
      '/auth/users'; // GET with query params: ?role=ADMIN&without_tenant=true
  static const String assignTenantToUser =
      '/auth/users/tenant'; // PUT - Assign tenant to user

  // ============================================
  // TENANT SERVICE ENDPOINTS
  // ============================================

  // Tenant CRUD (Super Admin can access all tenants via GET /tenants)
  static const String tenants = '/tenants';
  static String tenant(String id) => '/tenants/$id';

  // Tenant Settings
  static String tenantSettings(String tenantId) =>
      '/tenants/$tenantId/settings';

  // Working Hours
  static String workingHours(String tenantId) => '/tenants/$tenantId/hours';

  // Holidays
  static String holidays(String tenantId) => '/tenants/$tenantId/holidays';
  static String holiday(String tenantId, String holidayId) =>
      '/tenants/$tenantId/holidays/$holidayId';

  // Staff Management
  static String staff(String tenantId) => '/tenants/$tenantId/staff';
  static String staffMember(String tenantId, String staffId) =>
      '/tenants/$tenantId/staff/$staffId';

  // ============================================
  // BOOKING SERVICE ENDPOINTS
  // ============================================
  // Response: { success, data, error }. JWT required; Kong forwards X-Tenant-ID, X-User-ID.

  // Bookings
  static const String bookings = '/bookings';
  static String booking(String id) => '/bookings/$id';
  static String bookingCancel(String id) => '/bookings/$id/cancel';
  static String bookingComplete(String id) => '/bookings/$id/complete';

  // ============================================
  // CATALOG SERVICE ENDPOINTS
  // ============================================
  // Base: /api/v1 (or gateway); Catalog may run on :8083.
  // All catalog endpoints require X-Tenant-ID header (UUID from JWT).
  // Response: { success, data, error }

  // Categories: POST/GET /categories, PUT/DELETE /categories/:id
  static const String categories = '/categories';
  static String category(String id) => '/categories/$id';

  // Services: POST/GET /services, GET /services/:id, PUT/DELETE /services/:id
  static const String services = '/services';
  static String service(String id) => '/services/$id';
}
