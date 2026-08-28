import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/presentation/widgets/section_loading.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/employees/bloc/employees_bloc.dart';
import 'package:mh_salun/features/employees/model/employee.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/barber_select_card.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/booking_step_header.dart';
import 'package:mh_salun/features/reservations/presentation/widgets/new_reservation/step_message.dart';

/// Step 2 of the new-reservation flow: pick exactly one barber from a grid of
/// selectable cards. Reads the app-wide `EmployeesBloc` (already loaded for the
/// home screen), so it neither owns nor closes it nor triggers the fetch itself.
class SelectBarberStep extends StatelessWidget {
  const SelectBarberStep({
    super.key,
    required this.selectedBarber,
    required this.onBarberSelected,
  });

  final Employee? selectedBarber;
  final ValueChanged<Employee> onBarberSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeesBloc, EmployeesState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: BookingStepHeader(
                titleKey: 'new_reservation_barber_title',
                subtitleKey: 'new_reservation_barber_subtitle',
              ),
            ),
            Expanded(
              child: switch (state) {
                EmployeesFailure(:final messageKey) => StepMessage(
                  icon: Icons.error_outline_rounded,
                  messageKey: messageKey,
                ),
                EmployeesLoaded(:final employees) when employees.isEmpty =>
                  const StepMessage(
                    icon: Icons.person_off_outlined,
                    messageKey: 'new_reservation_barber_empty',
                  ),
                EmployeesLoaded(:final employees) => GridView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    0,
                    AppSpacing.lg,
                    AppSpacing.lg,
                  ),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: AppSpacing.md,
                        crossAxisSpacing: AppSpacing.md,
                        childAspectRatio: 0.92,
                      ),
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    final employee = employees[index];
                    return BarberSelectCard(
                      employee: employee,
                      selected: employee.id == selectedBarber?.id,
                      onTap: () => onBarberSelected(employee),
                    );
                  },
                ),
                EmployeesInitial() ||
                EmployeesLoading() => const SectionLoading(
                  height: double.infinity,
                ),
              },
            ),
          ],
        );
      },
    );
  }
}
