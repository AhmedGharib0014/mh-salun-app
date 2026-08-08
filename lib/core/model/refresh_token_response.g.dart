// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenResponse _$RefreshTokenResponseFromJson(
  Map<String, dynamic> json,
) => RefreshTokenResponse(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  expiresIn: (json['expiresIn'] as num).toInt(),
  refreshExpiresIn: (json['refreshExpiresIn'] as num).toInt(),
  tokenType: json['tokenType'] as String,
);

Map<String, dynamic> _$RefreshTokenResponseToJson(
  RefreshTokenResponse instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'expiresIn': instance.expiresIn,
  'refreshExpiresIn': instance.refreshExpiresIn,
  'tokenType': instance.tokenType,
};
