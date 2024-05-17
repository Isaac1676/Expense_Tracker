import 'package:expense_tracker/components/list_tile.dart';
import 'package:expense_tracker/database/database.dart';
import 'package:expense_tracker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ElementPage extends StatefulWidget {
  final String category;
  const ElementPage({super.key, required this.category});

  @override
  State<ElementPage> createState() => _ElementPageState();
}

class _ElementPageState extends State<ElementPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpenseDatabase>().fetchedExpenses(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    final expDatabase = context.watch<ExpenseDatabase>();
    final currentCategories = expDatabase.filterExpenses;

    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            widget.category,
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: screenWidth * 0.05,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded)
          )
        ),
      body: Column(
        children: [
          SizedBox(
            height: screenWidth * 0.02,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: currentCategories.length,
                  itemBuilder: (context, index) {
                    final expense = currentCategories[index];
                    final subtitle = "${formatDate(expense.date)} | ${expense.category}";
                    final amount = intToString(expense.amount);
                    return MyListile(
                        title: expense.name,
                        subtitle: subtitle,
                        amount: amount,
                        onEditPressed: (p0) {},
                        onDelPressed: (p0) {});
                  }))
        ],
      ),
    );
  }
}
