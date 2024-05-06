import 'package:expense_tracker/components/text_field.dart';
import 'package:flutter/material.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpensePage> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: const Icon(Icons.arrow_back_ios_new_rounded)
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.06,
          ),
          //TEXT
          Text(
            "Nouvelle dépense",
            style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: screenWidth * 0.05,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w800),
          ),

          SizedBox(
            height: screenHeight * 0.05,
          ),

          /* FORM */
          // NOM
          MyTextField(hintText: "hintText", controller: TextEditingController()),
          SizedBox(
              height: screenHeight * 0.04,
            ),

          // AMOUNT 
          MyTextField(hintText: "hintText", controller: TextEditingController()),
          SizedBox(
              height: screenHeight * 0.04,
            ),
          
          // CATEGORY
          MyTextField(hintText: "hintText", controller: TextEditingController())
        ],
      ),
    );
  }
}