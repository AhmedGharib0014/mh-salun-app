---
name: presentation-rules
description: Layout and sizing rules for any screen work in the mh_salun Flutter app. Invoke whenever building, updating, or adding a section to a screen — not just when creating from scratch. Covers fixed design tokens, flex-based layout adaptation, and MediaQuery constraints.
---

# Presentation rules (mobile-only, v1)

Apply these rules any time you touch a screen or widget — new build, update, or adding a section.

## Fixed design tokens — always use, never hardcode

Padding, margin, font size, icon size, border radius must come from these constants, not raw numbers:

| Token class | File | Keys |
|---|---|---|
| `AppSpacing` | `lib/core/theme/spacing.dart` | `xs / sm / md / lg / xl / xxl`, `iconSm / iconMd / iconLg`, `radiusSm / radiusMd / radiusLg / radiusXl / radiusFull` |
| `AppFontSize` | `lib/core/theme/font_sizes.dart` | `label / caption / body / title / heading / display` |
| `AppTextStyles` | `lib/core/theme/text_styles.dart` | `headingGold`, `titleMedium`, `bodyRegular`, `buttonPrimary`, … |

```dart
// correct
Padding(padding: const EdgeInsets.all(AppSpacing.md), ...)
Text('label', style: AppTextStyles.bodyRegular)

// wrong — never do this
Padding(padding: const EdgeInsets.all(16), ...)
Text('label', style: TextStyle(fontSize: 14))
```

## Layout adaptation — flex, not pixels

Width differences between devices are absorbed by layout widgets, not computed pixel values.

```dart
// proportional split — adapts to any screen width
Row(children: [
  Expanded(flex: 2, child: ProductImage()),
  Expanded(flex: 3, child: ProductDetails()),
])

// percentage of available width
FractionallySizedBox(widthFactor: 0.9, child: TextField(...))
```

Never use `flutter_screenutil`, `.w`, `.h`, `.sp`, or manual `MediaQuery.of(context).size.width * factor` math for sizing.

## MediaQuery — minimal use only

Only acceptable uses:
- `MediaQuery.of(context).padding` — safe area insets
- `MediaQuery.of(context).viewInsets.bottom` — keyboard height
- Rare small-screen conditional: `if (MediaQuery.of(context).size.height < 700) ...`

Do not build a sizing abstraction around MediaQuery.

## Rule of thumb

| Question | Answer |
|---|---|
| Should this look the same on every device? | Fixed token (`AppSpacing`, `AppFontSize`, radius, icon size) |
| Should this adapt to available space? | Flex/fractional widget |

## Out of scope (v1)

No breakpoints, no tablet/desktop layouts, no adaptive scaffolds.
