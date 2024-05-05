import 'package:isar/isar.dart';

part 'category.g.dart';

@Collection()
class Category {
  final Id id = Isar.autoIncrement;

  final String name;

  Category({required this.name});
}
