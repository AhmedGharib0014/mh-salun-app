import 'package:flutter/material.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/step_connector.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/step_node.dart';

/// Stepper under the app bar: numbered gold nodes joined by connector lines.
/// Completed steps collapse to a check, the active step gets a glowing ring,
/// and connectors fill in as the guest advances.
class StepProgress extends StatelessWidget {
  const StepProgress({super.key, required this.step, required this.stepCount});

  final int step;
  final int stepCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          for (var index = 0; index < stepCount; index++) ...[
            StepNode(index: index, done: index < step, active: index == step),
            if (index < stepCount - 1)
              Expanded(child: StepConnector(filled: index < step)),
          ],
        ],
      ),
    );
  }
}
