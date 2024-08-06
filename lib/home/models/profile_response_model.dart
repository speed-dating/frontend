import 'package:json_annotation/json_annotation.dart';

part 'profile_response_model.g.dart';

@JsonSerializable()
class ProfileResponseModel {
  final int id;
  final String gender; // Assuming gender is a string, adjust if it's an enum
  final String phoneNumber;
  final String nickname;
  final String introduce;
  final String profileImageUrl;
  final String birthDate;
  final List<TagResponseModel> tags;
  final List<GalleryResponseModel> galleries;

  ProfileResponseModel(
    this.profileImageUrl, {
    required this.id,
    required this.gender,
    required this.phoneNumber,
    required this.nickname,
    required this.introduce,
    required this.birthDate,
    required this.tags,
    required this.galleries,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileResponseModelToJson(this);
}

@JsonSerializable()
class TagResponseModel {
  final int id;
  final String content;

  TagResponseModel({
    required this.id,
    required this.content,
  });

  factory TagResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TagResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$TagResponseModelToJson(this);
}

@JsonSerializable()
class GalleryResponseModel {
  final int id;
  final String imageUrl;

  GalleryResponseModel({
    required this.id,
    required this.imageUrl,
  });

  factory GalleryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GalleryResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$GalleryResponseModelToJson(this);
}
