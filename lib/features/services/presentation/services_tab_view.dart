import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mh_salun/core/model/services_catalog.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/core/theme/text_styles.dart';
import 'package:mh_salun/features/services/presentation/widgets/services/all_services_grid.dart';

class ServicesTabView extends StatelessWidget {
  const ServicesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: AllServicesGrid(services: ServicesCatalog.all()),
    );
  }
}
