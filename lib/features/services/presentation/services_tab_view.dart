import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/theme/app_colors.dart';
import 'package:mh_salun/features/services/bloc/services_bloc.dart';
import 'package:mh_salun/features/services/model/catalog_item_x.dart';
import 'package:mh_salun/features/services/presentation/widgets/services/all_services_grid.dart';

/// Fetch of the underlying `ServicesBloc` data is centralized in
/// `HomeShellPage`, off the organization bloc, so this view just renders
/// whatever state the shared bloc is currently in.
class ServicesTabView extends StatelessWidget {
  const ServicesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocBuilder<ServicesBloc, ServicesState>(
        builder: (context, state) {
          if (state is ServicesLoaded) {
            return AllServicesGrid(
              services: state.items.map((item) => item.toService()).toList(),
            );
          }
          if (state is ServicesFailure) {
            return const Center(
              child: Icon(Icons.error_outline, color: AppColors.primary),
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        },
      ),
    );
  }
}
