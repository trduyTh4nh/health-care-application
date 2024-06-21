import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/providers/add_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class AddDrugHabitPage extends StatefulWidget {
  const AddDrugHabitPage({super.key});

  @override
  State<AddDrugHabitPage> createState() => _AddDrugHabitPageState();
}

class _AddDrugHabitPageState extends State<AddDrugHabitPage> {
  List<int> habits = [1, 2, 4, 6, 0];
  int currentHabit = 0;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Column(
          children: [
            Center(
                child: SvgPicture.asset(
              'assets/images/undraw_time_management.svg',
              height: 125,
            )),
            const SizedBox(height: 20),
            Center(
              child: Text("Bạn uống thuốc này bao nhiêu lần 1 ngày?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
      SliverList.separated(
        separatorBuilder: (context, index) => const Divider(
          indent: 20,
          endIndent: 20,
        ),
        itemCount: habits.length,
        itemBuilder: (context, index) =>
            Consumer<AddPageProvider>(builder: (context, value, child) {
          currentHabit = habits.indexOf(value.habit);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: index == currentHabit ? colorScheme.primary : null,
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                onTap: () {
                  value.habit = habits[index];
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    children: [
                      Icon(
                        Symbols.alarm,
                        color: index == currentHabit
                            ? colorScheme.surface
                            : colorScheme.onSurface,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        habits[index] == 0
                            ? "Tự định nghĩa"
                            : "${habits[index]} lần 1 ngày",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: index == currentHabit
                                ? colorScheme.surface
                                : colorScheme.onSurface),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      )
    ]);
  }
}
