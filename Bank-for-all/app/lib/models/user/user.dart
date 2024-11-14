import 'package:json_annotation/json_annotation.dart';

import '../../enums/gender_enum.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String firstName,
      lastName,
      address,
      gmail,
      phone,
      accountNumber,
      ifscCode,
      id,
      balance;
  final GenderEnum gender;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.address,
    this.gmail,
    this.phone,
    this.gender,
    this.accountNumber,
    this.ifscCode,
    this.balance,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
