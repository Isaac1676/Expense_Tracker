import 'package:expense_tracker/components/bottom_bar.dart';
import 'package:expense_tracker/components/list_tile.dart';
import 'package:expense_tracker/components/text_field.dart';
import 'package:expense_tracker/database/database.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/pages/expense_view.dart';
import 'package:expense_tracker/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseView extends StatefulWidget {
  const ExpenseView({super.key});

  @override
  State<ExpenseView> createState() => _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpenseView> {
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpenseDatabase>().fetchExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final expDatabase = context.watch<ExpenseDatabase>();
    final currentExpense = [
      Expense(
          title: "title",
          amount: 200,
          date: DateTime.now(),
          category: "category")
    ];

    //getting heigth and width
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "D E P E N S E S",
            style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: screenWidth * 0.05,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
              onPressed: () => themeProvider.toogleTheme(),
              icon: themeProvider.icon())),
      bottomNavigationBar: const BottomBar(
        isHome: true,
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
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.02,
          ),

          // CHAMP DE RECHERCHE
          Textfield(controller: TextEditingController(), onChanged: (value) {}),

          // SEE MY EXPENSE
          Expanded(
              child: ListView.builder(
                  itemCount: currentExpense.length,
                  itemBuilder: (context, index) {
                    final expense = currentExpense[index];
                    return MyListile(
                        title: "title",
                        subtitle: "subtitle",
                        amount: "amount",
                        onDelPressed: (p0) => openDeleteBox(expense));
                  }))
        ],
      ),
    );
  }

  Widget _deleteButton(int id) {
    return MaterialButton(
      onPressed: () async {
        Navigator.pop(context);
        try {
          await context.read<ExpenseDatabase>().deleteExpense(id);
        } catch (error) {
          print(error);
          // Handle the error appropriately (e.g., show a snackbar)
        }
      },
      child: const Text("Delete"),
    );
  }

  Widget _cancelButton() {
    return MaterialButton(
      onPressed: () => Navigator.pop(context),
      child: const Text("Retour"),
    );
  }
}
