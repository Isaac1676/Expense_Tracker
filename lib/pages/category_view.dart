import 'package:expense_tracker/components/bottom_bar.dart';
import 'package:expense_tracker/pages/expense_view.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("data"),),
      bottomNavigationBar: const BottomBar(
        isHome: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const ExpensePage())));
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
    );
  }
}