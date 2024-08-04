// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num?)?.toInt(),
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      phoneNumber: json['phoneNumber'] as String?,
      nickname: json['nickname'] as String?,
      country: json['country'] as String?,
      birthDate: json['birthDate'] as String?,
      profileImage: json['profileImage'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'gender': _$GenderEnumMap[instance.gender],
      'phoneNumber': instance.phoneNumber,
      'nickname': instance.nickname,
      'country': instance.country,
      'birthDate': instance.birthDate,
      'profileImage': instance.profileImage,
    };

const _$GenderEnumMap = {
  Gender.MALE: 'MALE',
  Gender.FEMALE: 'FEMALE',
};
