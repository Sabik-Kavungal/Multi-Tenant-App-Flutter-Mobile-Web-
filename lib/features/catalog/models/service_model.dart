import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/service_model.freezed.dart';
part 'gen/service_model.g.dart';

// ============================================
// BOOKING TYPE
// ============================================

class BookingType {
  BookingType._();
  static const String time = 'TIME';
  static const String token = 'TOKEN';
  static const String seat = 'SEAT';
  static const List<String> all = [time, token, seat];

  static String getDisplayName(String type) {
    switch (type) {
      case time:
        return 'Time (Appointment)';
      case token:
        return 'Token (Queue)';
      case seat:
        return 'Seat (Reservation)';
      default:
        return type;
    }
  }
}

// ============================================
// SERVICE
// ============================================

/// Service – Catalog Service API
/// GET/POST/PUT /services response shape
@freezed
class Service with _$Service {
  const factory Service({
    String? id,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'category_id') String? categoryId,
    String? name,
    String? description,
    @JsonKey(name: 'booking_type') String? bookingType,
    @JsonKey(name: 'duration_minutes') int? durationMinutes,
    int? capacity,
    double? price,
    @JsonKey(name: 'is_active') bool? isActive,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _Service;

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
}

/// Create: category_id, name, booking_type, price required.
/// duration_minutes when TIME; capacity when TOKEN or SEAT.
@freezed
class CreateServiceRequest with _$CreateServiceRequest {
  const factory CreateServiceRequest({
    @JsonKey(name: 'category_id') required String categoryId,
    required String name,
    String? description,
    @JsonKey(name: 'booking_type') required String bookingType,
    @JsonKey(name: 'duration_minutes') int? durationMinutes,
    int? capacity,
    required double price,
    @JsonKey(name: 'is_active') bool? isActive,
  }) = _CreateServiceRequest;

  factory CreateServiceRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateServiceRequestFromJson(json);
}

/// Update: same fields, all optional; same validation.
@freezed
class UpdateServiceRequest with _$UpdateServiceRequest {
  const factory UpdateServiceRequest({
    @JsonKey(name: 'category_id') String? categoryId,
    String? name,
    String? description,
    @JsonKey(name: 'booking_type') String? bookingType,
    @JsonKey(name: 'duration_minutes') int? durationMinutes,
    int? capacity,
    double? price,
    @JsonKey(name: 'is_active') bool? isActive,
  }) = _UpdateServiceRequest;

  factory UpdateServiceRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateServiceRequestFromJson(json);
}
