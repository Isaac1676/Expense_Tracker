import 'package:isar/isar.dart';

part 'expense.g.dart';

@Collection()
class Expense {
  final Id id = Isar.autoIncrement;

  final String title;

  final double amount;

  final DateTime date;

  final String category;

  Expense({required this.title, required this.amount, required this.date, required this.category});
}
