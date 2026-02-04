import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/holiday_model.freezed.dart';
part 'gen/holiday_model.g.dart';

/// Holiday model
/// Maps to Tenant Service Holidays API response
@freezed
class Holiday with _$Holiday {
  const factory Holiday({
    String? id,
    @JsonKey(name: 'tenant_id') String? tenantId,
    @JsonKey(name: 'holiday_date') String? holidayDate,
    String? reason,
  }) = _Holiday;

  factory Holiday.fromJson(Map<String, dynamic> json) =>
      _$HolidayFromJson(json);
}

/// Request model for creating a holiday
@freezed
class CreateHolidayRequest with _$CreateHolidayRequest {
  const factory CreateHolidayRequest({
    @JsonKey(name: 'holiday_date') required String holidayDate,
    required String reason,
  }) = _CreateHolidayRequest;

  factory CreateHolidayRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateHolidayRequestFromJson(json);
}
