import 'package:hive/hive.dart';
import '../models/todo.dart';

class TodoRepository {
  static const String boxName = 'todosBox';
  late Box<Todo> _box;

  TodoRepository() {
    // Ensure the box is opened before using
    _box = Hive.box<Todo>(boxName);
  }

  // Get all todos as a list
  List<Todo> get todos => _box.values.toList();

  // Add new todo
  Future<void> addTodo(Todo todo) async {
    await _box.add(todo);
  }

  // Update a todo at a given index
  Future<void> updateTodo(int index, Todo updatedTodo) async {
    await _box.putAt(index, updatedTodo);
  }

  // Delete a todo at a given index
  Future<void> deleteTodo(int index) async {
    await _box.deleteAt(index);
  }

  // Toggle completion status
  Future<void> toggleCompletion(int index) async {
    final todo = _box.getAt(index);
    if (todo != null) {
      final updatedTodo = Todo(
        title: todo.title,
        description: todo.description,
        isCompleted: !todo.isCompleted,
        createdAt: todo.createdAt,
      );
      await _box.putAt(index, updatedTodo);
    }
  }
}
