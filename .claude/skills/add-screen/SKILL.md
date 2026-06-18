---
name: add-screen
description: Create a presentation page or widget for the mh_salun Flutter app. Use when building a screen/page/UI, adding a widget, or laying out an interface. Covers feature-first file placement (features/<name>/presentation/), fixed design tokens (AppSpacing/AppFontSize/AppTextStyles), and the no-screen-scaling responsive rules.
---

# Add a screen / widget

## Where it goes
`lib/features/<feature>/presentation/<feature>_page.dart` (feature-first). Shared,
reusable widgets used by multiple features go in `lib/shared/` (create it if needed).

## Layout and sizing rules
Invoke the **presentation-rules** skill — it owns all sizing, token, flex-layout,
and MediaQuery constraints that apply here.

- All user-facing text uses `.tr()`.

## State: setState only
Always use `setState` for local screen state. This skill never adds a BLoC. If a
BLoC is needed, another skill (e.g. **integrate-feature** → **add-bloc**) handles
it first — this skill then wires the screen to the already-registered BLoC.

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
Reference the home page (`lib/features/home/presentation/home_page.dart`) for the existing widget style.
