import 'package:flutter/material.dart';
import 'package:mh_salun/core/model/service.dart';
import 'package:mh_salun/core/presentation/widgets/service_card.dart';
import 'package:mh_salun/core/theme/font_sizes.dart';
import 'package:mh_salun/core/theme/spacing.dart';

/// Scrollable grid of every service, padded so the last row clears the
/// curved bottom nav bar.
///
/// Tiles get a fixed height instead of an aspect ratio: with an aspect
/// ratio a wide screen (or a landscape phone) stretches the tile width,
/// which in turn blows up the height. The height only has to fit the
/// card's content, which is capped at two title lines plus two
/// description lines, so we compute it once and keep it stable at any
/// width.
class AllServicesGrid extends StatelessWidget {
  const AllServicesGrid({super.key, required this.services});

  /// Widest a tile may get before the grid adds another column.
  static const _maxTileWidth = 220.0;

  /// Everything in the card that does not scale with the text size:
  /// vertical padding, the icon badge and the gaps around the texts.
  static const _fixedCardHeight =
      AppSpacing.md * 2 + // card padding
      AppSpacing.xxl + // icon badge
      AppSpacing.md + // gap under the badge
      AppSpacing.xs + // gap between title and description
      AppSpacing.sm + // gap above the price row
      AppSpacing.sm; // breathing room

  final List<Service> services;

  double _tileHeight(BuildContext context) {
    final textScaler = MediaQuery.textScalerOf(context);
    final titleLine = textScaler.scale(AppFontSize.title) * ServiceCard.lineHeight;
    final captionLine = textScaler.scale(AppFontSize.caption) * ServiceCard.lineHeight;
    // 2 title lines + 2 description lines + 1 price row.
    return _fixedCardHeight + titleLine * 3 + captionLine * 2;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.bottomNavClearance + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: services.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: _maxTileWidth,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        mainAxisExtent: _tileHeight(context),
      ),
      itemBuilder: (context, index) => ServiceCard(service: services[index]),
    );
  }
}
