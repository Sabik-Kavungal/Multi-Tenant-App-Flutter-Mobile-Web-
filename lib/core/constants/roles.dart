/// User roles constants matching API responses
/// API Role Definitions:
/// - SUPER_ADMIN: Business owner - the product provider who owns the SaaS subscription
/// - ADMIN: Department admin (e.g., sales admin, inventory admin)
/// - STAFF: Regular staff member
/// - CUSTOMER: End customer
class Roles {
  Roles._();

  // Role constants (matching API - uppercase format)
  static const String customer = 'CUSTOMER';
  static const String staff = 'STAFF';
  static const String admin = 'ADMIN';
  static const String superAdmin = 'SUPER_ADMIN';

  /// All available roles
  static List<String> get all => [superAdmin, admin, staff, customer];

  /// Normalize role string for comparison (case-insensitive)
  static String? _normalize(String? role) => role?.toUpperCase().trim();

  /// Check if role is Customer (End customer)
  static bool isCustomer(String? role) => _normalize(role) == customer;

  /// Check if role is Staff (Regular staff member)
  static bool isStaff(String? role) => _normalize(role) == staff;

  /// Check if role is Admin (Department admin)
  static bool isAdmin(String? role) => _normalize(role) == admin;

  /// Check if role is Super Admin (Business owner)
  static bool isSuperAdmin(String? role) {
    final normalized = _normalize(role);
    return normalized == superAdmin || normalized == 'SUPERADMIN';
  }

  /// Check if role has admin privileges (Admin or Super Admin)
  static bool hasAdminPrivileges(String? role) =>
      isAdmin(role) || isSuperAdmin(role);

  /// Check if role can manage tenant (Admin or Super Admin)
  static bool canManageTenant(String? role) =>
      isAdmin(role) || isSuperAdmin(role);

  /// Check if role can view queue (Staff, Admin, or Super Admin)
  static bool canViewQueue(String? role) =>
      isStaff(role) || isAdmin(role) || isSuperAdmin(role);

  /// Check if role can make bookings (Customer)
  static bool canMakeBookings(String? role) => isCustomer(role);

  /// Get role display name
  static String getDisplayName(String? role) {
    if (isSuperAdmin(role)) return 'Business Owner';
    if (isAdmin(role)) return 'Administrator';
    if (isStaff(role)) return 'Staff Member';
    if (isCustomer(role)) return 'Customer';
    return role ?? 'User';
  }

  /// Get role description
  static String getDescription(String? role) {
    if (isSuperAdmin(role)) return 'Full access to manage organization';
    if (isAdmin(role)) return 'Department administration access';
    if (isStaff(role)) return 'Staff member access';
    if (isCustomer(role)) return 'Customer booking access';
    return 'Unknown role';
  }
}
