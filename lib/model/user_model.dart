import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? id;
  String? token;
  String? name = "";
  String? email;
  String? phone;
  UserModel({
    this.id,
    this.token,
    this.name,
    this.email,
    this.phone,
  });
  factory UserModel.fromJson(Map<String, dynamic> data) => _$UserModelFromJson(data);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
