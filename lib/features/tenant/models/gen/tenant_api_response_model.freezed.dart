// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../tenant_api_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TenantApiResponse<T> _$TenantApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object?) fromJsonT,
) {
  return _TenantApiResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$TenantApiResponse<T> {
  bool get success => throw _privateConstructorUsedError;
  T? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this TenantApiResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of TenantApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TenantApiResponseCopyWith<T, TenantApiResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TenantApiResponseCopyWith<T, $Res> {
  factory $TenantApiResponseCopyWith(
    TenantApiResponse<T> value,
    $Res Function(TenantApiResponse<T>) then,
  ) = _$TenantApiResponseCopyWithImpl<T, $Res, TenantApiResponse<T>>;
  @useResult
  $Res call({bool success, T? data, String? message, String? error});
}

/// @nodoc
class _$TenantApiResponseCopyWithImpl<
  T,
  $Res,
  $Val extends TenantApiResponse<T>
>
    implements $TenantApiResponseCopyWith<T, $Res> {
  _$TenantApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TenantApiResponse
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
abstract class _$$TenantApiResponseImplCopyWith<T, $Res>
    implements $TenantApiResponseCopyWith<T, $Res> {
  factory _$$TenantApiResponseImplCopyWith(
    _$TenantApiResponseImpl<T> value,
    $Res Function(_$TenantApiResponseImpl<T>) then,
  ) = __$$TenantApiResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({bool success, T? data, String? message, String? error});
}

/// @nodoc
class __$$TenantApiResponseImplCopyWithImpl<T, $Res>
    extends _$TenantApiResponseCopyWithImpl<T, $Res, _$TenantApiResponseImpl<T>>
    implements _$$TenantApiResponseImplCopyWith<T, $Res> {
  __$$TenantApiResponseImplCopyWithImpl(
    _$TenantApiResponseImpl<T> _value,
    $Res Function(_$TenantApiResponseImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of TenantApiResponse
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
      _$TenantApiResponseImpl<T>(
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
class _$TenantApiResponseImpl<T> implements _TenantApiResponse<T> {
  const _$TenantApiResponseImpl({
    required this.success,
    this.data,
    this.message,
    this.error,
  });

  factory _$TenantApiResponseImpl.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$$TenantApiResponseImplFromJson(json, fromJsonT);

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
    return 'TenantApiResponse<$T>(success: $success, data: $data, message: $message, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TenantApiResponseImpl<T> &&
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

  /// Create a copy of TenantApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TenantApiResponseImplCopyWith<T, _$TenantApiResponseImpl<T>>
  get copyWith =>
      __$$TenantApiResponseImplCopyWithImpl<T, _$TenantApiResponseImpl<T>>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$TenantApiResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _TenantApiResponse<T> implements TenantApiResponse<T> {
  const factory _TenantApiResponse({
    required final bool success,
    final T? data,
    final String? message,
    final String? error,
  }) = _$TenantApiResponseImpl<T>;

  factory _TenantApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) = _$TenantApiResponseImpl<T>.fromJson;

  @override
  bool get success;
  @override
  T? get data;
  @override
  String? get message;
  @override
  String? get error;

  /// Create a copy of TenantApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TenantApiResponseImplCopyWith<T, _$TenantApiResponseImpl<T>>
  get copyWith => throw _privateConstructorUsedError;
}

TenantListResponse _$TenantListResponseFromJson(Map<String, dynamic> json) {
  return _TenantListResponse.fromJson(json);
}

/// @nodoc
mixin _$TenantListResponse {
  List<Tenant> get tenants => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_size')
  int get pageSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_pages')
  int get totalPages => throw _privateConstructorUsedError;

  /// Serializes this TenantListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TenantListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TenantListResponseCopyWith<TenantListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TenantListResponseCopyWith<$Res> {
  factory $TenantListResponseCopyWith(
    TenantListResponse value,
    $Res Function(TenantListResponse) then,
  ) = _$TenantListResponseCopyWithImpl<$Res, TenantListResponse>;
  @useResult
  $Res call({
    List<Tenant> tenants,
    int total,
    int page,
    @JsonKey(name: 'page_size') int pageSize,
    @JsonKey(name: 'total_pages') int totalPages,
  });
}

/// @nodoc
class _$TenantListResponseCopyWithImpl<$Res, $Val extends TenantListResponse>
    implements $TenantListResponseCopyWith<$Res> {
  _$TenantListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TenantListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tenants = null,
    Object? total = null,
    Object? page = null,
    Object? pageSize = null,
    Object? totalPages = null,
  }) {
    return _then(
      _value.copyWith(
            tenants: null == tenants
                ? _value.tenants
                : tenants // ignore: cast_nullable_to_non_nullable
                      as List<Tenant>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            pageSize: null == pageSize
                ? _value.pageSize
                : pageSize // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPages: null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TenantListResponseImplCopyWith<$Res>
    implements $TenantListResponseCopyWith<$Res> {
  factory _$$TenantListResponseImplCopyWith(
    _$TenantListResponseImpl value,
    $Res Function(_$TenantListResponseImpl) then,
  ) = __$$TenantListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Tenant> tenants,
    int total,
    int page,
    @JsonKey(name: 'page_size') int pageSize,
    @JsonKey(name: 'total_pages') int totalPages,
  });
}

/// @nodoc
class __$$TenantListResponseImplCopyWithImpl<$Res>
    extends _$TenantListResponseCopyWithImpl<$Res, _$TenantListResponseImpl>
    implements _$$TenantListResponseImplCopyWith<$Res> {
  __$$TenantListResponseImplCopyWithImpl(
    _$TenantListResponseImpl _value,
    $Res Function(_$TenantListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TenantListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tenants = null,
    Object? total = null,
    Object? page = null,
    Object? pageSize = null,
    Object? totalPages = null,
  }) {
    return _then(
      _$TenantListResponseImpl(
        tenants: null == tenants
            ? _value._tenants
            : tenants // ignore: cast_nullable_to_non_nullable
                  as List<Tenant>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        pageSize: null == pageSize
            ? _value.pageSize
            : pageSize // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPages: null == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TenantListResponseImpl implements _TenantListResponse {
  const _$TenantListResponseImpl({
    required final List<Tenant> tenants,
    required this.total,
    required this.page,
    @JsonKey(name: 'page_size') required this.pageSize,
    @JsonKey(name: 'total_pages') required this.totalPages,
  }) : _tenants = tenants;

  factory _$TenantListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TenantListResponseImplFromJson(json);

  final List<Tenant> _tenants;
  @override
  List<Tenant> get tenants {
    if (_tenants is EqualUnmodifiableListView) return _tenants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tenants);
  }

  @override
  final int total;
  @override
  final int page;
  @override
  @JsonKey(name: 'page_size')
  final int pageSize;
  @override
  @JsonKey(name: 'total_pages')
  final int totalPages;

  @override
  String toString() {
    return 'TenantListResponse(tenants: $tenants, total: $total, page: $page, pageSize: $pageSize, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TenantListResponseImpl &&
            const DeepCollectionEquality().equals(other._tenants, _tenants) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_tenants),
    total,
    page,
    pageSize,
    totalPages,
  );

  /// Create a copy of TenantListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TenantListResponseImplCopyWith<_$TenantListResponseImpl> get copyWith =>
      __$$TenantListResponseImplCopyWithImpl<_$TenantListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TenantListResponseImplToJson(this);
  }
}

abstract class _TenantListResponse implements TenantListResponse {
  const factory _TenantListResponse({
    required final List<Tenant> tenants,
    required final int total,
    required final int page,
    @JsonKey(name: 'page_size') required final int pageSize,
    @JsonKey(name: 'total_pages') required final int totalPages,
  }) = _$TenantListResponseImpl;

  factory _TenantListResponse.fromJson(Map<String, dynamic> json) =
      _$TenantListResponseImpl.fromJson;

  @override
  List<Tenant> get tenants;
  @override
  int get total;
  @override
  int get page;
  @override
  @JsonKey(name: 'page_size')
  int get pageSize;
  @override
  @JsonKey(name: 'total_pages')
  int get totalPages;

  /// Create a copy of TenantListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TenantListResponseImplCopyWith<_$TenantListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
