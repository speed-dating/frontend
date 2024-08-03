// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ApiResponse<T>(
      resultCode: json['resultCode'] as String,
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$ApiResponseToJson<T>(
  ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'resultCode': instance.resultCode,
      'data': instance.data.map(toJsonT).toList(),
      'message': instance.message,
    };
