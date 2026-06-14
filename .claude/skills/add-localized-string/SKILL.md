---
name: add-localized-string
description: Add or use a translated/localized string in the mh_salun Flutter app. Use whenever UI text is added, a new translation key is needed, you see a hardcoded user-facing string, or a new language must be supported. Covers easy_localization (.tr(), plural, args) and assets/translations/{ar,en}.json.
---

# Add a localized string

Package: `easy_localization`. Supported locales: `ar` (Arabic — default &
fallback) and `en` (English). **No user-facing string is hardcoded** — every
string in the UI goes through a translation key.

## Translation files
- `assets/translations/ar.json` — Arabic strings
- `assets/translations/en.json` — English strings

Keys must exist in **both** files. `ar` is the default/start locale and the
fallback (see `lib/main.dart`).

## Add a new string
1. Add the same key to **both** `ar.json` and `en.json`:
   ```json
   // ar.json
   { "login_button": "تسجيل الدخول" }
   // en.json
   { "login_button": "Log in" }
   ```
2. Use it in the widget:
   ```dart
   import 'package:easy_localization/easy_localization.dart';

   Text('login_button'.tr())
   ```

## Variants
```dart
Text('greeting'.tr(args: ['Ahmed']))   // "Hello {}" -> with arguments
Text('items_count'.plural(count))      // plural forms
```

## Add a new language
1. Create `assets/translations/<locale>.json` with **all** existing keys.
2. Add `Locale('<locale>')` to `supportedLocales` in `lib/main.dart`.

## Checklist
- [ ] Key added to both `ar.json` and `en.json` (never one only)
- [ ] No raw user-facing string left in the widget
- [ ] `import 'package:easy_localization/easy_localization.dart';` present
