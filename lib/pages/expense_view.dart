import 'package:expense_tracker/components/button.dart';
import 'package:expense_tracker/components/calendar.dart';
import 'package:expense_tracker/components/dropdown.dart';
import 'package:expense_tracker/components/text_field.dart';
import 'package:expense_tracker/database/database.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpensePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  DateTime today = DateTime.now();
  String value = "None";

  void onDaySelected(DateTime day, DateTime focus) {
    setState(() {
      today = day;
    });
  }

  void onChanged(newValue) {
    setState(() {
      value = newValue!;
    });
  }

  void saveExpense() async {
    if (nameController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        value.isNotEmpty) {
      try {
        final amount = parseStringToDouble(amountController.text);

        Expense newExpense = Expense(
            name: nameController.text,
            amount: amount,
            date: today,
            category: value);

        await context.read<ExpenseDatabase>().addExpense(newExpense);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Dépense ajouté",
              style: TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            duration: Duration(seconds: 2), // Durée d'affichage de la SnackBar
          ),
        );
        nameController.clear();
        amountController.clear();
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Erreur : $e",
              style: const TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            backgroundColor: Colors.red,
            duration:
                const Duration(seconds: 2), // Durée d'affichage de la SnackBar
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Nouvelle dépense",
            style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: screenWidth * 0.05,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.03,
            ),

            /*FORM*/
            // NOM
            MyTextField(
              hintText: "Nom",
              controller: nameController,
              isPhone: false,
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),

            // AMOUNT
            MyTextField(
              hintText: "Montant",
              controller: amountController,
              isPhone: true,
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),

            // CATEGORY
            DropCategory(
              valueChoose: value,
              onChanged: onChanged,
            ),

            Calendar(
              today: today,
              onDaySelected: onDaySelected,
            ),

            // CONFIRM BUTTON
            MyButton(text: 'Enregistrer', onTap: saveExpense)
          ],
        ),
      ),
    );
  }
}
