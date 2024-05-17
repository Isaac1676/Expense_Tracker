import 'package:expense_tracker/components/button.dart';
import 'package:expense_tracker/components/category_tile.dart';
import 'package:expense_tracker/components/text_field.dart';
import 'package:expense_tracker/database/database.dart';
import 'package:expense_tracker/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController nameCategory = TextEditingController();

  //save_category method
  void saveCategory() async {
    if (nameCategory.text.isNotEmpty) {
      final name = context.read<ExpenseDatabase>().categoryName;

      if (!name.contains(nameCategory.text)) {
        try {
          Category newCategory = Category(name: nameCategory.text);

          await context.read<ExpenseDatabase>().addCategory(newCategory);
          await context.read<ExpenseDatabase>().addValue(nameCategory.text);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Catégorie ajouté",
                style: TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              duration:
                  Duration(seconds: 2), // Durée d'affichage de la SnackBar
            ),
          );
          nameCategory.clear();
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
              duration: const Duration(
                  seconds: 2), // Durée d'affichage de la SnackBar
            ),
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Erreur !"),
            content: const Text(
              "Cette catégorie existe déjà",
              style: TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            actions: [
              _cancelButton(),
            ],
          ),
        );
        nameCategory.clear();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Veuillez remplir le champ",
            style: TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2), // Durée d'affichage de la SnackBar
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpenseDatabase>().fetchCategorys();
      context.read<ExpenseDatabase>().categorieName();
    });
  }

  @override
  Widget build(BuildContext context) {
    final expDatabase = context.watch<ExpenseDatabase>();
    final currentCategories = expDatabase.categorys;

    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(9),
                          topRight: Radius.circular(9))),
                  height: screenHeight * 0.49,
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      MyTextField(
                          hintText: "Nom de catégorie",
                          isPhone: false,
                          controller: nameCategory),
                      SizedBox(
                        height: screenHeight * 0.07,
                      ),
                      MyButton(text: "Enregister", onTap: saveCategory)
                    ],
                  ),
                );
              });
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
          Expanded(
              child: ListView.builder(
                  itemCount: currentCategories.length,
                  itemBuilder: (context, index) {
                    final categorie = currentCategories[index];
                    return CategorieTile(title: categorie.name);
                  }))
        ],
      ),
    );
  }

  Widget _cancelButton() {
    return MaterialButton(
      onPressed: () => Navigator.pop(context),
      child: const Text("Retour"),
    );
  }
}
