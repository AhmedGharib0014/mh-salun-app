---
name: add-screen
description: Create a presentation page or widget for the mh_salun Flutter app. Use when building a screen/page/UI, adding a widget, or laying out an interface. Covers feature-first file placement (features/<name>/presentation/), fixed design tokens (AppSpacing/AppFontSize/AppTextStyles), and the no-screen-scaling responsive rules.
---

# Add a screen / widget

## Where it goes
Three placements — pick by reuse scope:

- **Page:** `lib/features/<feature>/presentation/<feature>_page.dart`
- **Feature-local widgets** (used only by this feature's screens):
  `lib/features/<feature>/presentation/widgets/<screen>/` — e.g. the login screen's
  fields and buttons live in `presentation/widgets/login/`.
- **Cross-feature widgets** (used by 2+ features): `lib/shared/` (create it if needed).

`lib/shared/` is for cross-feature reuse **only**. A widget used by a single feature
stays under that feature's `widgets/<screen>/` — never promote it to `shared/` just
because it was extracted.

## Layout and sizing rules
Invoke the **presentation-rules** skill — it owns all sizing, token, flex-layout,
and MediaQuery constraints that apply here.

- All user-facing text uses `.tr()`.

## Component extraction
Keep the page a thin composition tree. Extract a widget into its own file under
`widgets/<screen>/` when it:

- carries an `InputDecoration` or a styling block (custom button, decorated field),
- owns local state (e.g. a password visibility toggle), or
- is a styled/tappable control (custom button, tappable text).

Keep it **inline in the page** when it is trivial layout/text — `Text`, `SizedBox`,
plain `Padding` / `Align` / `Column`.

One widget = one file. Each extracted widget is **self-contained**: it owns its
decoration, its own local state, and any field-specific logic (an email field owns its
email `validator`). The page passes in only a `controller` and intent callbacks
(`onTap`, `onPressed`).

## Logic placement
- Validators and event handlers are **named private methods**, never inline closures
  in the build tree — `_validateEmail`, `_onForgotPassword`, `_submit`.
- A validator tied to one field lives **inside that field's widget**. A cross-field
  form action (`_submit`) stays in the page's state.

## State: setState only
Always use `setState` for local screen state. This skill never adds a BLoC. If a
BLoC is needed, another skill (e.g. **integrate-feature** → **add-bloc**) handles
it first — this skill then wires the screen to the already-registered BLoC.

## Example (login screen)

The page is a thin composition: it holds the `Form` key + controllers, names its
handlers, and composes extracted widgets. Only `Text`/`SizedBox` stay inline.

```dart
// lib/features/auth/presentation/login_page.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/auth/presentation/widgets/login/email_text_field.dart';
import 'package:mh_salun/features/auth/presentation/widgets/login/login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onForgotPassword() {/* navigate */}

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {/* ... */}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xxl),
                Text('login_title'.tr(), style: AppTextStyles.headingGold),
                const SizedBox(height: AppSpacing.xl),
                EmailTextField(controller: _emailController),
                const SizedBox(height: AppSpacing.xl),
                LoginButton(onPressed: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

Each extracted widget is self-contained — it owns its decoration and its own
field-specific logic:

```dart
// lib/features/auth/presentation/widgets/login/email_text_field.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key, required this.controller});

  final TextEditingController controller;

  String? _validate(String? value) {
    if (value == null || value.isEmpty) return 'login_required_field'.tr();
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value)) return 'login_invalid_email'.tr();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'login_email_label'.tr(),
        hintText: 'login_email_hint'.tr(),
      ),
      validator: _validate,
    );
  }
}
```

## After creating the screen
Re-check the page against **Component extraction** and **Logic placement**: no inline
closures in the build tree, decorated/stateful/tappable widgets pulled into
`widgets/<screen>/`, only trivial `Text`/`SizedBox` left inline.
