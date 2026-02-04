import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/booking_model.freezed.dart';
part 'gen/booking_model.g.dart';

/// Booking model representing a customer booking
/// Maps to Booking Service API response
@freezed
class Booking with _$Booking {
  const factory Booking({
    String? id,
    @JsonKey(name: 'customer_id') String? customerId,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'tenant_name') String? tenantName,
    @JsonKey(name: 'service_id') String? serviceId,
    @JsonKey(name: 'service_name') String? serviceName,
    @JsonKey(name: 'booking_date') String? bookingDate,
    @JsonKey(name: 'booking_time') String? bookingTime,
    @JsonKey(name: 'duration_minutes') int? durationMinutes,
    String? status,
    String? notes,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
}

/// Request model for creating a booking
@freezed
class CreateBookingRequest with _$CreateBookingRequest {
  const factory CreateBookingRequest({
    @JsonKey(name: 'tenant_id') required String tenantId,
    @JsonKey(name: 'service_id') required String serviceId,
    @JsonKey(name: 'booking_date') required String bookingDate,
    @JsonKey(name: 'booking_time') required String bookingTime,
    @JsonKey(name: 'duration_minutes') required int durationMinutes,
    String? notes,
  }) = _CreateBookingRequest;

  factory CreateBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateBookingRequestFromJson(json);
}

/// Request model for updating a booking
@freezed
class UpdateBookingRequest with _$UpdateBookingRequest {
  const factory UpdateBookingRequest({
    @JsonKey(name: 'booking_date') String? bookingDate,
    @JsonKey(name: 'booking_time') String? bookingTime,
    String? notes,
  }) = _UpdateBookingRequest;

  factory UpdateBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateBookingRequestFromJson(json);
}

/// Paginated response for booking list
@freezed
class BookingListResponse with _$BookingListResponse {
  const factory BookingListResponse({
    required List<Booking> bookings,
    required int total,
    required int page,
    @JsonKey(name: 'page_size') required int pageSize,
    @JsonKey(name: 'total_pages') required int totalPages,
  }) = _BookingListResponse;

  factory BookingListResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingListResponseFromJson(json);
}

/// Booking status enum
class BookingStatus {
  BookingStatus._();

  static const String confirmed = 'CONFIRMED';
  static const String cancelled = 'CANCELLED';
  static const String completed = 'COMPLETED';

  static const List<String> all = [confirmed, cancelled, completed];

  static String getDisplayName(String status) {
    switch (status) {
      case confirmed:
        return 'Confirmed';
      case cancelled:
        return 'Cancelled';
      case completed:
        return 'Completed';
      default:
        return status;
    }
  }
}
