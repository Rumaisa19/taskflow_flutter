import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)

class Todo extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final bool isCompleted;

  @HiveField(3)
  final DateTime createdAt;

  Todo({
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.createdAt,
  });
}
