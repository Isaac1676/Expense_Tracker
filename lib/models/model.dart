import 'package:isar/isar.dart';

part 'model.g.dart';

@Collection()
class Expense {
  final Id id = Isar.autoIncrement;

  final String title;

  final double amount;

  final DateTime date;

  Expense({required this.title, required this.amount, required this.date});
}
