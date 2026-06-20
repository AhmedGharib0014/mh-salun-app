// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      userId: json['userId'] as String,
      email: json['email'] as String,
      emailVerified: json['emailVerified'] as bool,
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
    };
