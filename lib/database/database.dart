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
    isar =
        await Isar.open([ExpenseSchema, CategorySchema], directory: dir.path);
  }

  final List<Expense> expenses = [];
  final List<Expense> filterExpenses = [];
  final List<String> categoryName = [];
  final List<Category> categorys = [];

  /*  CREATE METHODS */
  Future<void> addValue(String name) async {
    categoryName.add(name);
    await categorieName();
  }

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
    List<Expense> fetchedExpense = await isar.expenses.where().findAll();
    expenses.clear();
    expenses.addAll(fetchedExpense);
    notifyListeners();
  }

  // READ - SEE MY EXPENSE
  Future<void> fetchedExpenses(String name) async {
    List<Expense> fetchedBirth = await isar.expenses.where().findAll();
    expenses.clear();
    expenses.addAll(fetchedBirth);
    filterExpenses.clear();
    for (var exp in expenses) {
      if (exp.category == name) {
        filterExpenses.add(exp);
        notifyListeners();
      }
    }
    notifyListeners();
  }

  Future<void> categorieName() async {
    List<Category> fetchedBirth = await isar.categorys.where().findAll();
    categorys.clear();
    categorys.addAll(fetchedBirth);
    for (var exp in categorys) {
      categoryName.add(exp.name);
      notifyListeners();
    }
    notifyListeners();
  }

  // READ - SEE MY CATEGORY
  Future<void> fetchCategorys() async {
    List<Category> fetchedCategory = await isar.categorys.where().findAll();
    categorys.clear();
    categorys.addAll(fetchedCategory);
    notifyListeners();
  }

  /*  UPDATE METHODS */
  Future<void> updateExpense(int id, Expense updatedExpense) async {
    updatedExpense.id = id;

    await isar.writeTxn(() => isar.expenses.put(updatedExpense));

    await fetchExpenses();
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
    await fetchCategorys();
  }

  /*  SEARCH METHODS */

  // SEARCH - SEARCH EXPENSE BY NAME
  Future<void> searchExpense(String searchTerm) async {
    final searchResults = await isar.expenses
        .where()
        .filter()
        .nameContains(searchTerm)
        .findAll();
    expenses.clear();
    expenses.addAll(searchResults);
    notifyListeners();
  }
}
