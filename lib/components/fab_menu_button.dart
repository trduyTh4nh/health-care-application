import 'package:app_well_mate/components/fab_vertical_delegate.dart';
import 'package:app_well_mate/screen/drug/add_drug.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FabMenuButton extends StatefulWidget {
  const FabMenuButton({super.key});

  @override
  State<FabMenuButton> createState() => _FabMenuButtonState();
}

class _FabMenuButtonState extends State<FabMenuButton>
    with SingleTickerProviderStateMixin {
  final actionButtonColor = Colors.white;
  late AnimationController animationController;
  final menuIsOpen = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  toggleMenu() {
    menuIsOpen.value
        ? animationController.reverse()
        : animationController.forward();
    menuIsOpen.value = !menuIsOpen.value;
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FabVerticalDelegate(animation: animationController),
      clipBehavior: Clip.none,
      children: [
        FloatingActionButton(
          heroTag: "1",
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: animationController,
          ),
          onPressed: () => toggleMenu(),
        ),
        FloatingActionButton(
          heroTag: "2",
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder:(context) => const AddDrugPage(),));
          },
          backgroundColor: actionButtonColor,
          child: const Icon(Icons.add),
        ),
        FloatingActionButton(
          heroTag: "3",
          onPressed: () {},
          backgroundColor: actionButtonColor,
          child: const Icon(Icons.shopping_cart_outlined),
        ),
      ],
    );
  }
}
