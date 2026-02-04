import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/category_model.freezed.dart';
part 'gen/category_model.g.dart';

/// Category model – Catalog Service API
/// GET/POST/PUT /categories response shape
///
/// **Fields:** id, tenant_id, name, is_active, created_at
@freezed
class Category with _$Category {
  const factory Category({
    String? id,
    @JsonKey(name: 'tenant_id') String? tenantId,
    String? name,
    @JsonKey(name: 'is_active') bool? isActive,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

/// Create category: name (required), is_active (optional, default true)
@freezed
class CreateCategoryRequest with _$CreateCategoryRequest {
  const factory CreateCategoryRequest({
    required String name,
    @JsonKey(name: 'is_active') bool? isActive,
  }) = _CreateCategoryRequest;

  factory CreateCategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCategoryRequestFromJson(json);
}

/// Update category: name (1–100), is_active (optional)
@freezed
class UpdateCategoryRequest with _$UpdateCategoryRequest {
  const factory UpdateCategoryRequest({
    String? name,
    @JsonKey(name: 'is_active') bool? isActive,
  }) = _UpdateCategoryRequest;

  factory UpdateCategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateCategoryRequestFromJson(json);
}
