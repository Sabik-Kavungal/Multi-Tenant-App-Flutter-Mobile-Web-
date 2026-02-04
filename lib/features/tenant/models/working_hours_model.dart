import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/working_hours_model.freezed.dart';
part 'gen/working_hours_model.g.dart';

/// Working hours model for a single day
///
/// **API Response Model:** Maps to GET /api/v1/tenants/{tenant_id}/hours response
///
/// **Fields:**
/// - `id`: Working hours record ID (UUID)
/// - `tenant_id`: Tenant identifier (UUID)
/// - `day_of_week`: Day of week (0=Sunday, 1=Monday, ..., 6=Saturday)
/// - `open_time`: Opening time in HH:MM format (24-hour), null if closed
/// - `close_time`: Closing time in HH:MM format (24-hour), null if closed
/// - `is_closed`: Whether the business is closed on this day
///
/// **Example JSON:**
/// ```json
/// {
///   "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
///   "tenant_id": "d290f1ee-6c54-4b01-90e6-d701748f0851",
///   "day_of_week": 1,
///   "open_time": "09:00",
///   "close_time": "17:00",
///   "is_closed": false
/// }
/// ```
@freezed
class WorkingHours with _$WorkingHours {
  const factory WorkingHours({
    String? id,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'day_of_week') int? dayOfWeek,
    @JsonKey(name: 'open_time') String? openTime,
    @JsonKey(name: 'close_time') String? closeTime,
    @JsonKey(name: 'is_closed') bool? isClosed,
  }) = _WorkingHours;

  factory WorkingHours.fromJson(Map<String, dynamic> json) =>
      _$WorkingHoursFromJson(json);
}

/// Input model for updating working hours for a single day
///
/// **API Request Model:** Used in PUT /api/v1/tenants/{tenant_id}/hours request body
///
/// **Fields:**
/// - `day_of_week`: Day of week (0-6, required, must be unique in array)
/// - `open_time`: Opening time in HH:MM format (required if not closed)
/// - `close_time`: Closing time in HH:MM format (required if not closed)
/// - `is_closed`: Whether business is closed (required)
///
/// **Validation Rules:**
/// - If `is_closed = false`: both `open_time` and `close_time` are required
/// - If `is_closed = true`: `open_time` and `close_time` should be `null`
/// - Time format: `HH:MM` (24-hour format, e.g., "09:00", "17:30")
///
/// **Example:**
/// ```dart
/// WorkingHoursInput(
///   dayOfWeek: 1, // Monday
///   openTime: '09:00',
///   closeTime: '17:00',
///   isClosed: false,
/// )
/// ```
@freezed
class WorkingHoursInput with _$WorkingHoursInput {
  const factory WorkingHoursInput({
    @JsonKey(name: 'day_of_week') required int dayOfWeek,
    @JsonKey(name: 'open_time') String? openTime,
    @JsonKey(name: 'close_time') String? closeTime,
    @JsonKey(name: 'is_closed') required bool isClosed,
  }) = _WorkingHoursInput;

  factory WorkingHoursInput.fromJson(Map<String, dynamic> json) =>
      _$WorkingHoursInputFromJson(json);
}

/// Request model for updating working hours
///
/// **API Request Model:** Wraps the hours array for PUT /api/v1/tenants/{tenant_id}/hours
///
/// **Request Body Structure:**
/// ```json
/// {
///   "hours": [
///     {
///       "day_of_week": 0,
///       "open_time": "09:00",
///       "close_time": "17:00",
///       "is_closed": false
///     },
///     ...
///   ]
/// }
/// ```
///
/// **Validation:**
/// - `hours` array must contain 1-7 items (one per day)
/// - Each `day_of_week` must be unique (no duplicates)
/// - All days (0-6) should typically be included
@freezed
class UpdateWorkingHoursRequest with _$UpdateWorkingHoursRequest {
  const factory UpdateWorkingHoursRequest({
    required List<WorkingHoursInput> hours,
  }) = _UpdateWorkingHoursRequest;

  factory UpdateWorkingHoursRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkingHoursRequestFromJson(json);
}

/// Helper function to extract time (HH:MM) from datetime string
///
/// **Handles multiple formats:**
/// - `"09:00"` → `"09:00"` (already time format)
/// - `"0000-01-01T09:00:00Z"` → `"09:00"` (datetime format)
/// - `"2024-01-01T09:00:00Z"` → `"09:00"` (datetime format)
/// - `"0000-01-01T05:50:00Z"` → `"05:50"` (datetime format)
/// - `null` → `null`
///
/// **Returns:** Time string in HH:MM format or null
String? extractTimeFromString(String? timeString) {
  if (timeString == null || timeString.isEmpty) {
    return null;
  }

  // If already in HH:MM format, return as is
  if (RegExp(r'^\d{1,2}:\d{2}$').hasMatch(timeString)) {
    return timeString;
  }

  // Try to parse as datetime and extract time
  try {
    // Handle ISO 8601 datetime format: "0000-01-01T09:00:00Z" or "2024-01-01T09:00:00Z"
    if (timeString.contains('T')) {
      final dateTime = DateTime.parse(timeString);
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    }
  } catch (e) {
    // If parsing fails, try to extract time pattern manually using regex
    // Look for HH:MM pattern anywhere in the string
    final timeMatch = RegExp(r'(\d{1,2}):(\d{2})').firstMatch(timeString);
    if (timeMatch != null) {
      final hour = int.parse(timeMatch.group(1)!);
      final minute = timeMatch.group(2)!;
      // Ensure hour is 0-23 and minute is 00-59
      if (hour >= 0 && hour <= 23 && minute.length == 2) {
        return '${hour.toString().padLeft(2, '0')}:$minute';
      }
    }
  }

  // If all else fails, return original string (fallback)
  return timeString;
}

/// Day of week helper class
///
/// **Day of Week Reference (per API spec):**
/// - 0 = Sunday
/// - 1 = Monday
/// - 2 = Tuesday
/// - 3 = Wednesday
/// - 4 = Thursday
/// - 5 = Friday
/// - 6 = Saturday
///
/// **Usage:**
/// ```dart
/// DayOfWeek.monday // Returns 1
/// DayOfWeek.getName(1) // Returns "Monday"
/// DayOfWeek.names[1] // Returns "Monday"
/// ```
class DayOfWeek {
  DayOfWeek._();

  // Day constants matching API specification
  static const int sunday = 0;
  static const int monday = 1;
  static const int tuesday = 2;
  static const int wednesday = 3;
  static const int thursday = 4;
  static const int friday = 5;
  static const int saturday = 6;

  /// Day names array (index matches day_of_week value)
  static const List<String> names = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  /// Get day name from day_of_week value
  ///
  /// **Parameters:**
  /// - `dayOfWeek`: Integer 0-6 representing the day
  ///
  /// **Returns:** Day name string (e.g., "Monday") or "Unknown" if invalid
  static String getName(int dayOfWeek) {
    if (dayOfWeek >= 0 && dayOfWeek < names.length) {
      return names[dayOfWeek];
    }
    return 'Unknown';
  }
}
