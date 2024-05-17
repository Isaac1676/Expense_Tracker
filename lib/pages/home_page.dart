import 'package:expense_tracker/components/tab_bar.dart';
import 'package:expense_tracker/pages/category_view.dart';
import 'package:expense_tracker/pages/home_view.dart';
import 'package:expense_tracker/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    //getting heigth and width
    final double screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "X - P E N S E S",
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: screenWidth * 0.05,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
            onPressed: () => themeProvider.toogleTheme(),
            icon: themeProvider.icon()
          )
        ),
        body: const Column(
          children: [
            MyTabBar(),
            Expanded(child: TabBarView(children: [ExpenseView(), CategoryPage()]))
          ],
        ),
      )
    );
  }
}