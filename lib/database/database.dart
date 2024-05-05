import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class ExpenseDatabase extends ChangeNotifier {
  static late Isar isar;

  // INITIALIZE A DATABASE
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([ExpenseSchema, CategorySchema], directory: dir.path);
  }

  final List<Expense> expenses = [];
  final List<Category> categorys = [];

  /*  CREATE METHODS */

  // CREATE - ADD A NEW EXPENSE
  Future<void> addExpense(Expense expense) async {
    await isar.writeTxn(() => isar.expenses.put(expense));

    await fetchExpenses();
  }

  // CREATE - ADD A NEW CATEGORY
  Future<void> addCategory(Category category) async {
    await isar.writeTxn(() => isar.categorys.put(category));

    await fetchCategorys();
  }

  /*  READ METHODS */

  // READ - SEE MY EXPENSE
  Future<void> fetchExpenses() async {
    List<Expense> fetchedBirth = await isar.expenses.where().findAll();
    expenses.clear();
    expenses.addAll(fetchedBirth);
    notifyListeners();
  }

  // READ - SEE MY CATEGORY
  Future<void> fetchCategorys() async {
    List<Category> fetchedCategory = await isar.categorys.where().findAll();
    categorys.clear();
    categorys.addAll(fetchedCategory);
    notifyListeners();
  }

  /*  DELETE METHODS */

  // DELETE - DELETE A EXPENSE
  Future<void> deleteExpense(int id) async {
    await isar.writeTxn(() => isar.expenses.delete(id));
    await fetchExpenses();
  }

  // DELETE - DELETE A CATEGORY
  Future<void> deleteCategory(int id) async {
    await isar.writeTxn(() => isar.categorys.delete(id));
    await fetchExpenses();
  }

  /*  SEARCH METHODS */

  // SEARCH - SEARCH CATEGORY BY NAME
  Future<void> searchExpense(String searchTerm) async {
    final searchResults = await isar.categorys
        .where()
        .filter()
        .nameContains(searchTerm)
        .findAll();
    categorys.clear();
    categorys.addAll(searchResults);
    notifyListeners();
  }
}
