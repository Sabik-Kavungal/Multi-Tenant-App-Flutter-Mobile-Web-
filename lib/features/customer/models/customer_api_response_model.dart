import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/customer_api_response_model.freezed.dart';
part 'gen/customer_api_response_model.g.dart';

/// Generic API response wrapper for customer API calls
@Freezed(genericArgumentFactories: true)
class CustomerApiResponse<T> with _$CustomerApiResponse<T> {
  const factory CustomerApiResponse({
    required bool success,
    T? data,
    String? message,
    String? error,
  }) = _CustomerApiResponse<T>;

  factory CustomerApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$CustomerApiResponseFromJson(json, fromJsonT);
}
