import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/staff_model.freezed.dart';
part 'gen/staff_model.g.dart';

/// Staff member model
/// Maps to Tenant Service Staff API response
@freezed
class Staff with _$Staff {
  const factory Staff({
    String? id,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'user_id') String? userId,
    String? designation,
    @JsonKey(name: 'is_active') bool? isActive,
    @JsonKey(name: 'joined_at') String? joinedAt,
  }) = _Staff;

  factory Staff.fromJson(Map<String, dynamic> json) => _$StaffFromJson(json);
}

/// Request model for creating staff
@freezed
class CreateStaffRequest with _$CreateStaffRequest {
  const factory CreateStaffRequest({
    @JsonKey(name: 'user_id') required String userId,
    required String designation,
  }) = _CreateStaffRequest;

  factory CreateStaffRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateStaffRequestFromJson(json);
}

/// Request model for updating staff
@freezed
class UpdateStaffRequest with _$UpdateStaffRequest {
  const factory UpdateStaffRequest({
    String? designation,
    @JsonKey(name: 'is_active') bool? isActive,
  }) = _UpdateStaffRequest;

  factory UpdateStaffRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateStaffRequestFromJson(json);
}

/// Staff designation types
class StaffDesignation {
  StaffDesignation._();

  static const String admin = 'ADMIN';
  static const String staff = 'STAFF';

  static const List<String> all = [admin, staff];

  static String getDisplayName(String designation) {
    switch (designation) {
      case admin:
        return 'Admin';
      case staff:
        return 'Staff';
      default:
        return designation;
    }
  }
}
