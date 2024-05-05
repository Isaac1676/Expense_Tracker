import 'package:expense_tracker/components/text_field.dart';
import 'package:expense_tracker/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseView extends StatefulWidget {
  const ExpenseView({super.key});

  @override
  State<ExpenseView> createState() => _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpenseView> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    //getting heigth and width
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => themeProvider.toogleTheme(),
              icon: themeProvider.icon())),
      body: Column(
        children: [
          Textfield(controller: TextEditingController(), onChanged: (value) {})
        ],
      ),
    );
  }
}
