import 'package:expense_tracker/components/list_tile.dart';
import 'package:expense_tracker/components/text_field.dart';
import 'package:expense_tracker/database/database.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/pages/expense_view.dart';
import 'package:expense_tracker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseView extends StatefulWidget {
  const ExpenseView({super.key});

  @override
  State<ExpenseView> createState() => _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpenseView> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpenseDatabase>().fetchExpenses();
    });
  }

  void openDeleteBox(Expense child) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Supprimer cette dépense "),
        actions: [
          _cancelButton(),
          _deleteButton(child.id),
        ],
      ),
    );
  }

  void performSearch(String searchTerm) {
  if (searchTerm.isEmpty) {
    context.read<ExpenseDatabase>().fetchExpenses();
  } else {
    context.read<ExpenseDatabase>().searchExpense(searchTerm);
  }
}


  @override
  Widget build(BuildContext context) {
    final expDatabase = context.watch<ExpenseDatabase>();
    final currentExpense = expDatabase.expenses;

    //getting heigth and width
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.02,
          ),

          // CHAMP DE RECHERCHE
          Textfield(controller: searchController, onChanged: performSearch),


          // SEE MY EXPENSE
          Expanded(
              child: ListView.builder(
                  itemCount: currentExpense.length,
                  itemBuilder: (context, index) {
                    final expense = currentExpense[index];
                    final subtitle =
                        "${formatDate(expense.date)} | ${expense.category}";
                    final amount = intToString(expense.amount);
                    return MyListile(
                        title: expense.name,
                        subtitle: subtitle,
                        amount: amount,
                        onEditPressed: (p0) {},
                        onDelPressed: (p0) => openDeleteBox(expense));
                  }))
        ],
      ),
    );
  }

  Widget _deleteButton(int id) {
    return MaterialButton(
      onPressed: ()  {
        Navigator.pop(context);
        context.read<ExpenseDatabase>().deleteExpense(id);
        print("object");
      },
      child: const Text("Supprimer"),
    );
  }

  Widget _cancelButton() {
    return MaterialButton(
      onPressed: () => Navigator.pop(context),
      child: const Text("Retour"),
    );
  }
}
