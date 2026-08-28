import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// Circular avatar showing [imageUrl] when available and falling back to the
/// person's [initial] on a surface disc otherwise.
class AvatarCircle extends StatelessWidget {
  const AvatarCircle({
    super.key,
    required this.initial,
    required this.size,
    this.imageUrl,
    this.textStyle,
    this.border,
  });

  final String initial;
  final double size;
  final String? imageUrl;
  final TextStyle? textStyle;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    final hasImage = url != null && url.isNotEmpty;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surfaceHigh,
        border: border,
        image: hasImage
            ? DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)
            : null,
      ),
      alignment: Alignment.center,
      child: hasImage
          ? null
          : Text(initial, style: textStyle ?? AppTextStyles.titleLarge),
    );
  }
}
