import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'font_sizes.dart';

abstract final class AppTextStyles {
  // Display / Hero
  static const TextStyle display = TextStyle(
    fontSize: AppFontSize.display,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  // Headings
  static const TextStyle headingLarge = TextStyle(
    fontSize: AppFontSize.heading,
    fontWeight: FontWeight.w700,
    color: AppColors.onBackground,
  );

  static const TextStyle headingGold = TextStyle(
    fontSize: AppFontSize.heading,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  // Title
  static const TextStyle titleLarge = TextStyle(
    fontSize: AppFontSize.titleLarge,
    fontWeight: FontWeight.w700,
    color: AppColors.onBackground,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: AppFontSize.title,
    fontWeight: FontWeight.w600,
    color: AppColors.onBackground,
  );

  static const TextStyle titleGold = TextStyle(
    fontSize: AppFontSize.title,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  // Body
  static const TextStyle bodyRegular = TextStyle(
    fontSize: AppFontSize.body,
    fontWeight: FontWeight.w400,
    color: AppColors.onBackground,
    height: 1.5,
  );

  static const TextStyle bodySecondary = TextStyle(
    fontSize: AppFontSize.body,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
    height: 1.5,
  );

  static const TextStyle bodyGold = TextStyle(
    fontSize: AppFontSize.body,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  // Caption / Label
  static const TextStyle caption = TextStyle(
    fontSize: AppFontSize.caption,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );

  static const TextStyle label = TextStyle(
    fontSize: AppFontSize.label,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurface,
  );

  // Buttons
  static const TextStyle buttonPrimary = TextStyle(
    fontSize: AppFontSize.body,
    fontWeight: FontWeight.w700,
    color: AppColors.onPrimary,
  );

  static const TextStyle buttonSecondary = TextStyle(
    fontSize: AppFontSize.body,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );
}
