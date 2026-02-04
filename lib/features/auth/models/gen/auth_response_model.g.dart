// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthResponseImpl _$$AuthResponseImplFromJson(Map<String, dynamic> json) =>
    _$AuthResponseImpl(
      success: json['success'] as bool,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] == null
          ? null
          : Token.fromJson(json['token'] as Map<String, dynamic>),
      message: json['message'] as String?,
      error: json['error'] as String?,
      errorCode: json['errorCode'] as String?,
    );

Map<String, dynamic> _$$AuthResponseImplToJson(_$AuthResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      if (instance.user?.toJson() case final value?) 'user': value,
      if (instance.token?.toJson() case final value?) 'token': value,
      if (instance.message case final value?) 'message': value,
      if (instance.error case final value?) 'error': value,
      if (instance.errorCode case final value?) 'errorCode': value,
    };
