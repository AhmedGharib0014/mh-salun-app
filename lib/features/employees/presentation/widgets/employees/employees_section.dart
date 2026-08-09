import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mh_salun/core/presentation/widgets/section_header.dart';
import 'package:mh_salun/core/presentation/widgets/section_loading.dart';
import 'package:mh_salun/core/theme/spacing.dart';
import 'package:mh_salun/features/employees/bloc/employees_bloc.dart';
import 'package:mh_salun/features/employees/presentation/widgets/employees/employee_avatar.dart';

/// Section that displays the organization's employees. Consumes the
/// app-wide `EmployeesBloc` provided above `MaterialApp`, shared with the
/// reservation flow, so it neither owns nor closes it nor triggers the
/// fetch itself — that's centralized in `HomeShellPage` off the
/// organization bloc.
class EmployeesSection extends StatelessWidget {
  const EmployeesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeesBloc, EmployeesState>(
      builder: (context, state) {
        if (state is! EmployeesLoaded) {
          return const SectionLoading(height: 140);
        }
        final employees = state.employees;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionHeader(titleKey: 'home_barbers_title'),
            SizedBox(
              height: 140,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                itemCount: employees.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: AppSpacing.md),
                itemBuilder: (context, index) =>
                    EmployeeAvatar(employee: employees[index]),
              ),
            ),
          ],
        );
      },
    );
  }
}
