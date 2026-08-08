import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/model/barber.dart';
import 'package:mh_salun/core/model/service.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';

/// Step 4 (final) of the new-reservation flow: a read-only recap of every
/// choice the guest made — barber, services, and date & time — followed by the
/// order total. Each section carries an "Edit" affordance that jumps back to
/// the step that owns it; the actual "Book" action lives in the footer.
class ReviewStep extends StatelessWidget {
  const ReviewStep({
    super.key,
    required this.barber,
    required this.services,
    required this.dateTimeLabel,
    required this.totalLabel,
    required this.onEditStep,
  });

  final Barber barber;
  final List<Service> services;
  final String dateTimeLabel;
  final String totalLabel;

  /// Called with the step index to return to when a section's "Edit" is tapped
  /// (0 = barber, 1 = services, 2 = date & time).
  final ValueChanged<int> onEditStep;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      children: [
        const _ReviewHeader(),
        const SizedBox(height: AppSpacing.lg),
        _ReviewSection(
          icon: Icons.person_rounded,
          title: 'new_reservation_review_barber_label'.tr(),
          onEdit: () => onEditStep(0),
          child: _BarberRow(barber: barber),
        ),
        const SizedBox(height: AppSpacing.md),
        _ReviewSection(
          icon: Icons.content_cut_rounded,
          title: 'new_reservation_review_services_label'.tr(),
          onEdit: () => onEditStep(1),
          child: Column(
            children: [
              for (var i = 0; i < services.length; i++) ...[
                if (i > 0) const _RowDivider(),
                _ServiceRow(service: services[i]),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _ReviewSection(
          icon: Icons.event_rounded,
          title: 'new_reservation_review_datetime_label'.tr(),
          onEdit: () => onEditStep(2),
          child: _DateTimeRow(dateTimeLabel: dateTimeLabel),
        ),
        const SizedBox(height: AppSpacing.lg),
        _TotalCard(totalLabel: totalLabel),
      ],
    );
  }
}

/// Hero title block: a glowing gold badge beside the step title & subtitle.
class _ReviewHeader extends StatelessWidget {
  const _ReviewHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: AppSpacing.xxl,
          height: AppSpacing.xxl,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryLight, AppColors.primary],
            ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.4),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.receipt_long_rounded,
            size: AppSpacing.iconMd,
            color: AppColors.onPrimary,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'new_reservation_review_title'.tr(),
                style: AppTextStyles.titleLarge,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'new_reservation_review_subtitle'.tr(),
                style: AppTextStyles.bodySecondary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A titled, elevated panel holding one group of the recap. Its header pairs a
/// gradient icon badge with the section label and a gold "Edit" button.
class _ReviewSection extends StatelessWidget {
  const _ReviewSection({
    required this.icon,
    required this.title,
    required this.onEdit,
    required this.child,
  });

  final IconData icon;
  final String title;
  final VoidCallback onEdit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.sm,
              0,
            ),
            child: Row(
              children: [
                _SectionIcon(icon: icon),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    title.toUpperCase(),
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.primary,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _EditButton(onTap: onEdit),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.md,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

/// Small gold-tinted square holding a section's leading icon.
class _SectionIcon extends StatelessWidget {
  const _SectionIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSpacing.lg + AppSpacing.xs,
      height: AppSpacing.lg + AppSpacing.xs,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: AppSpacing.iconSm - 2, color: AppColors.primary),
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm + 1,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.30)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.edit_outlined,
                size: AppSpacing.iconSm - 5,
                color: AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'new_reservation_review_edit'.tr(),
                style: AppTextStyles.buttonSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Divider between stacked service rows inside the services section.
class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Divider(height: 1, thickness: 1, color: AppColors.divider),
    );
  }
}

class _BarberRow extends StatelessWidget {
  const _BarberRow({required this.barber});

  final Barber barber;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar with a gradient gold ring around a dark inner disc.
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryLight, AppColors.primary],
            ),
          ),
          child: Container(
            width: AppSpacing.xxl,
            height: AppSpacing.xxl,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceHigh,
            ),
            alignment: Alignment.center,
            child: Text(barber.initial, style: AppTextStyles.titleLarge),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                barber.name,
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'new_reservation_review_barber_role'.tr(),
                style: AppTextStyles.caption,
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        // Rating pill.
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star_rounded,
                size: AppSpacing.iconSm - 3,
                color: AppColors.primary,
              ),
              const SizedBox(width: 2),
              Text(
                barber.rating,
                style: AppTextStyles.bodyGold.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ServiceRow extends StatelessWidget {
  const _ServiceRow({required this.service});

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppSpacing.xl,
          height: AppSpacing.xl,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          alignment: Alignment.center,
          child: Icon(service.icon, size: AppSpacing.iconSm, color: AppColors.primary),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service.name,
                style: AppTextStyles.bodyRegular.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  const Icon(
                    Icons.schedule_rounded,
                    size: AppSpacing.iconSm - 4,
                    color: AppColors.onSurface,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(service.duration, style: AppTextStyles.caption),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          service.price,
          style: AppTextStyles.bodyGold.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _DateTimeRow extends StatelessWidget {
  const _DateTimeRow({required this.dateTimeLabel});

  final String dateTimeLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppSpacing.xl,
          height: AppSpacing.xl,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.event_available_rounded,
            size: AppSpacing.iconSm,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            dateTimeLabel,
            style: AppTextStyles.titleMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// Elevated panel closing the recap: a gradient accent bar, the "Total" label,
/// and the amount rendered with a gold gradient shader.
class _TotalCard extends StatelessWidget {
  const _TotalCard({required this.totalLabel});

  final String totalLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Leading gold gradient accent bar.
            Container(
              width: AppSpacing.xs,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.primaryLight, AppColors.primary],
                ),
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(AppSpacing.radiusXl),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'new_reservation_review_total_label'.tr(),
                            style: AppTextStyles.titleMedium,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'new_reservation_review_total_hint'.tr(),
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.primaryLight, AppColors.primary],
                      ).createShader(bounds),
                      child: Text(
                        totalLabel,
                        style: AppTextStyles.display.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
