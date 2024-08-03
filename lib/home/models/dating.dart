import 'package:json_annotation/json_annotation.dart';
import 'package:speed_dating_front/authentication/model/user.dart';

part 'dating.g.dart';

@JsonSerializable()
class DatingModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final UserModel owner;
  final List<UserModel> participants;

  DatingModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.owner,
    required this.participants,
  });

  factory DatingModel.fromJson(Map<String, dynamic> json) =>
      _$DatingModelFromJson(json);
  Map<String, dynamic> toJson() => _$DatingModelToJson(this);
}
