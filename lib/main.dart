import 'package:expense_tracker/database/database.dart';
import 'package:expense_tracker/pages/home_view.dart';
import 'package:expense_tracker/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ExpenseDatabase.initialize();

  runApp(
    MultiProvider(
      providers: [
        //theme provider
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),

        //birthday provider
        ChangeNotifierProvider(
          create: (context) => ExpenseDatabase(),
        )
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ExpenseView(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}