// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../customer_api_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CustomerApiResponse<T> _$CustomerApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object?) fromJsonT,
) {
  return _CustomerApiResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$CustomerApiResponse<T> {
  bool get success => throw _privateConstructorUsedError;
  T? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this CustomerApiResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of CustomerApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerApiResponseCopyWith<T, CustomerApiResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerApiResponseCopyWith<T, $Res> {
  factory $CustomerApiResponseCopyWith(
    CustomerApiResponse<T> value,
    $Res Function(CustomerApiResponse<T>) then,
  ) = _$CustomerApiResponseCopyWithImpl<T, $Res, CustomerApiResponse<T>>;
  @useResult
  $Res call({bool success, T? data, String? message, String? error});
}

/// @nodoc
class _$CustomerApiResponseCopyWithImpl<
  T,
  $Res,
  $Val extends CustomerApiResponse<T>
>
    implements $CustomerApiResponseCopyWith<T, $Res> {
  _$CustomerApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = freezed,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as T?,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CustomerApiResponseImplCopyWith<T, $Res>
    implements $CustomerApiResponseCopyWith<T, $Res> {
  factory _$$CustomerApiResponseImplCopyWith(
    _$CustomerApiResponseImpl<T> value,
    $Res Function(_$CustomerApiResponseImpl<T>) then,
  ) = __$$CustomerApiResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({bool success, T? data, String? message, String? error});
}

/// @nodoc
class __$$CustomerApiResponseImplCopyWithImpl<T, $Res>
    extends
        _$CustomerApiResponseCopyWithImpl<T, $Res, _$CustomerApiResponseImpl<T>>
    implements _$$CustomerApiResponseImplCopyWith<T, $Res> {
  __$$CustomerApiResponseImplCopyWithImpl(
    _$CustomerApiResponseImpl<T> _value,
    $Res Function(_$CustomerApiResponseImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of CustomerApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = freezed,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _$CustomerApiResponseImpl<T>(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as T?,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$CustomerApiResponseImpl<T> implements _CustomerApiResponse<T> {
  const _$CustomerApiResponseImpl({
    required this.success,
    this.data,
    this.message,
    this.error,
  });

  factory _$CustomerApiResponseImpl.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$$CustomerApiResponseImplFromJson(json, fromJsonT);

  @override
  final bool success;
  @override
  final T? data;
  @override
  final String? message;
  @override
  final String? error;

  @override
  String toString() {
    return 'CustomerApiResponse<$T>(success: $success, data: $data, message: $message, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerApiResponseImpl<T> &&
            (identical(other.success, success) || other.success == success) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    const DeepCollectionEquality().hash(data),
    message,
    error,
  );

  /// Create a copy of CustomerApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerApiResponseImplCopyWith<T, _$CustomerApiResponseImpl<T>>
  get copyWith =>
      __$$CustomerApiResponseImplCopyWithImpl<T, _$CustomerApiResponseImpl<T>>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$CustomerApiResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _CustomerApiResponse<T> implements CustomerApiResponse<T> {
  const factory _CustomerApiResponse({
    required final bool success,
    final T? data,
    final String? message,
    final String? error,
  }) = _$CustomerApiResponseImpl<T>;

  factory _CustomerApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) = _$CustomerApiResponseImpl<T>.fromJson;

  @override
  bool get success;
  @override
  T? get data;
  @override
  String? get message;
  @override
  String? get error;

  /// Create a copy of CustomerApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerApiResponseImplCopyWith<T, _$CustomerApiResponseImpl<T>>
  get copyWith => throw _privateConstructorUsedError;
}
