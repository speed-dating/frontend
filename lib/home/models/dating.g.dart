// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatingModel _$DatingModelFromJson(Map<String, dynamic> json) => DatingModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      owner: UserModel.fromJson(json['owner'] as Map<String, dynamic>),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DatingModelToJson(DatingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'owner': instance.owner,
      'participants': instance.participants,
    };
