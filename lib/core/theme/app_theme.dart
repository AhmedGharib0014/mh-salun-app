import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'font_sizes.dart';
import 'spacing.dart';

abstract final class AppTheme {
  static ThemeData get dark => _buildDarkTheme();

  static ThemeData _buildDarkTheme() {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,

      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryDark,
      onPrimaryContainer: AppColors.primaryLight,

      secondary: AppColors.primaryDark,
      onSecondary: AppColors.onPrimary,
      secondaryContainer: Color(0xFF2A2208),
      onSecondaryContainer: AppColors.primaryLight,

      tertiary: AppColors.onSurface,
      onTertiary: AppColors.background,
      tertiaryContainer: AppColors.surface,
      onTertiaryContainer: AppColors.onBackground,

      error: AppColors.error,
      onError: AppColors.onError,
      errorContainer: Color(0xFF5C1A24),
      onErrorContainer: Color(0xFFFFB3BA),

      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      onSurfaceVariant: AppColors.onBackground,
      surfaceContainerHighest: AppColors.surfaceHigh,

      outline: AppColors.outline,
      outlineVariant: AppColors.divider,
      shadow: Colors.black,
      scrim: Colors.black,

      inverseSurface: AppColors.onBackground,
      onInverseSurface: AppColors.background,
      inversePrimary: AppColors.primaryDark,

      surfaceTint: Colors.transparent,
    );

    const textTheme = TextTheme(
      displayLarge: TextStyle(fontSize: AppFontSize.display, fontWeight: FontWeight.w700, color: AppColors.primary, letterSpacing: 2.0),
      displayMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700, color: AppColors.primary, letterSpacing: 1.5),
      displaySmall: TextStyle(fontSize: AppFontSize.display, fontWeight: FontWeight.w600, color: AppColors.onBackground, letterSpacing: 1.0),

      headlineLarge: TextStyle(fontSize: AppFontSize.heading, fontWeight: FontWeight.w700, color: AppColors.onBackground, letterSpacing: 1.2),
      headlineMedium: TextStyle(fontSize: AppFontSize.heading, fontWeight: FontWeight.w600, color: AppColors.onBackground),
      headlineSmall: TextStyle(fontSize: AppFontSize.title, fontWeight: FontWeight.w600, color: AppColors.onBackground),

      titleLarge: TextStyle(fontSize: AppFontSize.title, fontWeight: FontWeight.w600, color: AppColors.onBackground),
      titleMedium: TextStyle(fontSize: AppFontSize.body, fontWeight: FontWeight.w600, color: AppColors.onBackground),
      titleSmall: TextStyle(fontSize: AppFontSize.body, fontWeight: FontWeight.w500, color: AppColors.onSurface),

      bodyLarge: TextStyle(fontSize: AppFontSize.body, fontWeight: FontWeight.w400, color: AppColors.onBackground, height: 1.5),
      bodyMedium: TextStyle(fontSize: AppFontSize.body, fontWeight: FontWeight.w400, color: AppColors.onSurface, height: 1.5),
      bodySmall: TextStyle(fontSize: AppFontSize.caption, fontWeight: FontWeight.w400, color: AppColors.onSurface, height: 1.4),

      labelLarge: TextStyle(fontSize: AppFontSize.body, fontWeight: FontWeight.w700, color: AppColors.onPrimary, letterSpacing: 1.5),
      labelMedium: TextStyle(fontSize: AppFontSize.caption, fontWeight: FontWeight.w500, color: AppColors.onSurface, letterSpacing: 0.5),
      labelSmall: TextStyle(fontSize: AppFontSize.label, fontWeight: FontWeight.w500, color: AppColors.onSurface, letterSpacing: 1.0),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: textTheme,

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.appBar,
        foregroundColor: AppColors.onAppBar,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: AppFontSize.title,
          fontWeight: FontWeight.w700,
          color: AppColors.onAppBar,
          letterSpacing: 1.5,
        ),
        iconTheme: IconThemeData(color: AppColors.onAppBar, size: AppSpacing.iconMd),
        actionsIconTheme: IconThemeData(color: AppColors.onAppBar, size: AppSpacing.iconMd),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          side: const BorderSide(color: AppColors.divider, width: 1),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.primaryDark,
          disabledForegroundColor: AppColors.onPrimary,
          elevation: 0,
          minimumSize: const Size(double.infinity, 52),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          textStyle: const TextStyle(
            fontSize: AppFontSize.body,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          minimumSize: const Size(double.infinity, 52),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          textStyle: const TextStyle(
            fontSize: AppFontSize.body,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(
            fontSize: AppFontSize.body,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 4,
        shape: CircleBorder(),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: Color(0x26E5A526), // primary with 15% opacity
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primary, size: AppSpacing.iconMd);
          }
          return const IconThemeData(color: AppColors.onSurface, size: AppSpacing.iconMd);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: AppFontSize.label,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            );
          }
          return const TextStyle(
            fontSize: AppFontSize.label,
            fontWeight: FontWeight.w400,
            color: AppColors.onSurface,
          );
        }),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        hintStyle: const TextStyle(
          fontSize: AppFontSize.body,
          color: AppColors.onSurface,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: const TextStyle(
          fontSize: AppFontSize.body,
          color: AppColors.onSurface,
        ),
        floatingLabelStyle: const TextStyle(
          fontSize: AppFontSize.caption,
          color: AppColors.primary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        modalBackgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSpacing.radiusXl),
          ),
        ),
        dragHandleColor: AppColors.divider,
        dragHandleSize: Size(40, 4),
      ),

      listTileTheme: const ListTileThemeData(
        tileColor: Colors.transparent,
        iconColor: AppColors.primary,
        textColor: AppColors.onBackground,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.primary,
        disabledColor: AppColors.divider,
        labelStyle: const TextStyle(
          fontSize: AppFontSize.caption,
          color: AppColors.onBackground,
        ),
        secondaryLabelStyle: const TextStyle(
          fontSize: AppFontSize.caption,
          color: AppColors.onPrimary,
        ),
        side: const BorderSide(color: AppColors.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
      ),

      iconTheme: const IconThemeData(
        color: AppColors.primary,
        size: AppSpacing.iconMd,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceHigh,
        contentTextStyle: const TextStyle(
          fontSize: AppFontSize.body,
          color: AppColors.onBackground,
        ),
        actionTextColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        titleTextStyle: const TextStyle(
          fontSize: AppFontSize.title,
          fontWeight: FontWeight.w700,
          color: AppColors.onBackground,
        ),
        contentTextStyle: const TextStyle(
          fontSize: AppFontSize.body,
          color: AppColors.onSurface,
          height: 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
      ),
    );
  }
}
