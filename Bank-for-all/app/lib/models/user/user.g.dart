// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    address: json['address'] as String,
    gmail: json['gmail'] as String,
    phone: json['phone'] as String,
    gender: _$enumDecodeNullable(_$GenderEnumEnumMap, json['gender']),
    accountNumber: json['accountNumber'] as String,
    ifscCode: json['ifscCode'] as String,
    balance: json['balance'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'address': instance.address,
      'gmail': instance.gmail,
      'phone': instance.phone,
      'accountNumber': instance.accountNumber,
      'ifscCode': instance.ifscCode,
      'id': instance.id,
      'balance': instance.balance,
      'gender': _$GenderEnumEnumMap[instance.gender],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$GenderEnumEnumMap = {
  GenderEnum.male: 'male',
  GenderEnum.female: 'female',
  GenderEnum.other: 'other',
};
