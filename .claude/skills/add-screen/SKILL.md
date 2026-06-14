---
name: add-screen
description: Create a presentation page or widget for the mh_salun Flutter app. Use when building a screen/page/UI, adding a widget, or laying out an interface. Covers feature-first file placement (features/<name>/presentation/), fixed design tokens (AppSpacing/AppFontSize/AppTextStyles), and the no-screen-scaling responsive rules.
---

# Add a screen / widget

## Where it goes
`lib/features/<feature>/presentation/<feature>_page.dart` (feature-first). Shared,
reusable widgets used by multiple features go in `lib/shared/` (create it if needed).

## Sizing rules (mobile-only v1) — do not violate
- **Never hardcode** raw numbers for padding/margin/fontSize/radius/icon size.
  Use the fixed tokens:
  - `AppSpacing` (`lib/core/theme/spacing.dart`): `xs/sm/md/lg/xl/xxl`,
    `iconSm/iconMd/iconLg`, `radiusSm/radiusMd/radiusLg/radiusXl/radiusFull`
  - `AppFontSize` (`lib/core/theme/font_sizes.dart`): `label/caption/body/title/heading/display`
  - `AppTextStyles` (`lib/core/theme/text_styles.dart`): ready-made styles
    (`headingGold`, `titleMedium`, `bodyRegular`, `buttonPrimary`, …)
- **No** `flutter_screenutil`, no `.w/.h/.sp`, no width-ratio math.
- Width differences are absorbed by `Expanded` / `Flexible` / `FractionallySizedBox`,
  not by computing pixels.
- `MediaQuery` only for safe-area, keyboard insets, rare small-screen conditionals.
- All user-facing text uses `.tr()` — invoke the **add-localized-string** skill.

## State: setState vs BLoC
Default to a plain widget with `setState` for local, screen-only state. Add a BLoC
**only** when state survives navigation, is shared across widgets, or has complex
transitions — invoke the **add-bloc** skill in that case. (See the BLoC decision
rule in the **add-bloc** skill.)

## Example (login screen scaffold)
```dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('login_title'.tr(), style: AppTextStyles.headingGold),
              const SizedBox(height: AppSpacing.lg),
              const TextField(),
              const SizedBox(height: AppSpacing.md),
              FilledButton(
                onPressed: () {},
                child: Text('login_button'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## After creating the screen
- Wire it into navigation — invoke the **add-route** skill.
- Reference the home page (`lib/features/home/presentation/home_page.dart`) for the
  existing widget style.
