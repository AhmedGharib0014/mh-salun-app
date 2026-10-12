import 'package:json_annotation/json_annotation.dart';

part 'app_fee.g.dart';

/// The organization's app fee: a [fixed] amount and a [percentage] rate.
@JsonSerializable()
class AppFee {
  const AppFee({
    required this.fixed,
    required this.percentage,
  });

  factory AppFee.fromJson(Map<String, dynamic> json) => _$AppFeeFromJson(json);

  final num fixed;
  final num percentage;

  Map<String, dynamic> toJson() => _$AppFeeToJson(this);
}
