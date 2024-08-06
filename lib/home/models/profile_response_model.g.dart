// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponseModel _$ProfileResponseModelFromJson(
        Map<String, dynamic> json) =>
    ProfileResponseModel(
      json['profileImageUrl'] as String,
      id: (json['id'] as num).toInt(),
      gender: json['gender'] as String,
      phoneNumber: json['phoneNumber'] as String,
      nickname: json['nickname'] as String,
      introduce: json['introduce'] as String,
      birthDate: json['birthDate'] as String,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => TagResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      galleries: (json['galleries'] as List<dynamic>)
          .map((e) => GalleryResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileResponseModelToJson(
        ProfileResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gender': instance.gender,
      'phoneNumber': instance.phoneNumber,
      'nickname': instance.nickname,
      'introduce': instance.introduce,
      'profileImageUrl': instance.profileImageUrl,
      'birthDate': instance.birthDate,
      'tags': instance.tags,
      'galleries': instance.galleries,
    };

TagResponseModel _$TagResponseModelFromJson(Map<String, dynamic> json) =>
    TagResponseModel(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
    );

Map<String, dynamic> _$TagResponseModelToJson(TagResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
    };

GalleryResponseModel _$GalleryResponseModelFromJson(
        Map<String, dynamic> json) =>
    GalleryResponseModel(
      id: (json['id'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$GalleryResponseModelToJson(
        GalleryResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
    };
