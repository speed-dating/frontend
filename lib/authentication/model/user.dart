import 'package:json_annotation/json_annotation.dart';
import 'package:speed_dating_front/authentication/screens/gender_input_screen.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  final int? id;
  final Gender? gender;
  final String? phoneNumber;
  final String? nickname;
  final String? country;
  final String? birthDate;
  final String? profileImage; // 추가된 필드

  UserModel({
    this.id,
    required this.gender,
    required this.phoneNumber,
    required this.nickname,
    required this.country,
    required this.birthDate,
    required this.profileImage, // 생성자에 추가
  });

  // JSON 데이터를 UserModel 객체로 변환
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  // UserModel 객체를 JSON 데이터로 변환
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
