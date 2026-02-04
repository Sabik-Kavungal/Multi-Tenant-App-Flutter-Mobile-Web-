import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/booking_model.freezed.dart';
part 'gen/booking_model.g.dart';

// ============================================
// BOOKING STATUS
// ============================================

class BookingStatus {
  BookingStatus._();

  static const String created = 'CREATED';
  static const String confirmed = 'CONFIRMED';
  static const String cancelled = 'CANCELLED';
  static const String completed = 'COMPLETED';

  static const List<String> all = [created, confirmed, cancelled, completed];

  static String getDisplayName(String status) {
    switch (status) {
      case created:
        return 'Created';
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

  /// Whether Cancel or Complete is allowed
  static bool canCancelOrComplete(String? status) {
    return status == created || status == confirmed;
  }
}

// ============================================
// BOOKING – API response shape
// ============================================

/// Booking – Booking Service API
/// GET /bookings, GET /bookings/:id, POST /bookings response data
@freezed
class Booking with _$Booking {
  const factory Booking({
    String? id,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'service_id') String? serviceId,
    @JsonKey(name: 'booking_type') String? bookingType,
    @JsonKey(name: 'booking_date') String? bookingDate,
    @JsonKey(name: 'start_time') String? startTime,
    @JsonKey(name: 'end_time') String? endTime,
    int? quantity,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
}

// ============================================
// CREATE REQUEST – POST /bookings body
// ============================================

/// Request for POST /bookings.
/// service_id, booking_type required. For TIME: booking_date, start_time required; end_time optional. quantity default 1.
class CreateBookingRequest {
  final String serviceId;
  final String bookingType;
  final String? bookingDate;
  final String? startTime;
  final String? endTime;
  final int quantity;

  const CreateBookingRequest({
    required this.serviceId,
    required this.bookingType,
    this.bookingDate,
    this.startTime,
    this.endTime,
    this.quantity = 1,
  });

  /// JSON for POST /bookings (omits null optionals).
  Map<String, dynamic> toApiJson() {
    final m = <String, dynamic>{
      'service_id': serviceId,
      'booking_type': bookingType,
      'quantity': quantity,
    };
    if (bookingDate != null && bookingDate!.isNotEmpty) {
      m['booking_date'] = bookingDate;
    }
    if (startTime != null && startTime!.isNotEmpty) {
      m['start_time'] = startTime;
    }
    if (endTime != null && endTime!.isNotEmpty) {
      m['end_time'] = endTime;
    }
    return m;
  }
}

// ============================================
// LIST RESULT – GET /bookings data shape
// ============================================

/// GET /bookings returns data: { items: [...], total }
class BookingListResult {
  final List<Booking> items;
  final int total;

  const BookingListResult({required this.items, required this.total});
}
