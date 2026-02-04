import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/tenant_model.freezed.dart';
part 'gen/tenant_model.g.dart';

/// Tenant model representing a business/organization
/// Maps to Tenant Service API response
@freezed
class Tenant with _$Tenant {
  const factory Tenant({
    String? id,
    String? name,
    String? type,
    @JsonKey(name: 'owner_user_id') String? ownerUserId,
    String? status,
    String? timezone,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _Tenant;

  factory Tenant.fromJson(Map<String, dynamic> json) => _$TenantFromJson(json);
}

/// Request model for creating a tenant
@freezed
class CreateTenantRequest with _$CreateTenantRequest {
  const factory CreateTenantRequest({
    required String name,
    required String type,
    @JsonKey(name: 'owner_user_id') required String ownerUserId,
    required String timezone,
  }) = _CreateTenantRequest;

  factory CreateTenantRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateTenantRequestFromJson(json);
}

/// Request model for updating a tenant
@freezed
class UpdateTenantRequest with _$UpdateTenantRequest {
  const factory UpdateTenantRequest({
    String? name,
    String? type,
    String? status,
    String? timezone,
  }) = _UpdateTenantRequest;

  factory UpdateTenantRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateTenantRequestFromJson(json);
}

/// Tenant types enum
class TenantTypes {
  TenantTypes._();

  static const String clinic = 'CLINIC';
  static const String restaurant = 'RESTAURANT';
  static const String salon = 'SALON';
  static const String other = 'OTHER';

  static const List<String> all = [clinic, restaurant, salon, other];

  static String getDisplayName(String type) {
    switch (type) {
      case clinic:
        return 'Clinic';
      case restaurant:
        return 'Restaurant';
      case salon:
        return 'Salon';
      case other:
        return 'Other';
      default:
        return type;
    }
  }
}

/// Tenant status enum
class TenantStatus {
  TenantStatus._();

  static const String active = 'ACTIVE';
  static const String suspended = 'SUSPENDED';
  static const String deleted = 'DELETED';

  static const List<String> all = [active, suspended];

  static String getDisplayName(String status) {
    switch (status) {
      case active:
        return 'Active';
      case suspended:
        return 'Suspended';
      case deleted:
        return 'Deleted';
      default:
        return status;
    }
  }
}
