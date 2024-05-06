import 'package:expense_tracker/pages/category_view.dart';
import 'package:expense_tracker/pages/home_view.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final bool isHome;
  const BottomBar({super.key, required this.isHome});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => const ExpenseView()))),
                  icon: Icon(
                    Icons.home_rounded,
                    size: 30,
                    color: isHome ? Colors.blue : Theme.of(context).colorScheme.primary,
                  )),
              IconButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => const CategoryPage()))),
                  icon: Icon(
                    Icons.dashboard,
                    size: 30,
                    color: !isHome ? Colors.blue : Theme.of(context).colorScheme.primary,
                  ))
            ],
          ),
        ));
  }
}
