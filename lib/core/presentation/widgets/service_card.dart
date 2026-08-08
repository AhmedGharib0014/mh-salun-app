import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/core/model/service.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key, required this.service});

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AppSpacing.xxl,
            height: AppSpacing.xxl,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.35),
              ),
            ),
            alignment: Alignment.center,
            child: _ServiceIcon(service: service),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            service.name,
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            service.description,
            style: AppTextStyles.caption,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(service.duration, style: AppTextStyles.caption),
              Text(
                service.price,
                style: AppTextStyles.titleGold.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ServiceIcon extends StatelessWidget {
  const _ServiceIcon({required this.service});

  final Service service;

  @override
  Widget build(BuildContext context) {
    final iconUrl = service.iconUrl;
    if (iconUrl == null) {
      return Icon(
        service.icon,
        size: AppSpacing.iconMd,
        color: AppColors.primary,
      );
    }
    return SvgPicture.network(
      iconUrl,
      width: AppSpacing.iconMd,
      height: AppSpacing.iconMd,
      placeholderBuilder: (context) => Icon(
        service.icon,
        size: AppSpacing.iconMd,
        color: AppColors.primary,
      ),
      errorBuilder: (context, error, stackTrace) => Icon(
        service.icon,
        size: AppSpacing.iconMd,
        color: AppColors.primary,
      ),
    );
  }
}
