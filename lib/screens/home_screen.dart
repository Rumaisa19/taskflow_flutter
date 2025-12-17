// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/widgets/todo_bottom_sheet.dart';
import '../models/todo.dart';
import '../widgets/todo_tile.dart';
import '../core/theme/app_colors.dart';
import 'task_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<Todo> todoBox;

  // @override
  void initState() {
    super.initState();
    todoBox = Hive.box<Todo>('todosBox');
  }

  void _addTodo({Todo? todo, int? index}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TodoBottomSheet(
        todo: index != null ? todoBox.getAt(index) : null, // null = Add
        onSave: (title, description) {
          final newTodo = Todo(
            title: title,
            description: description,
            isCompleted: index != null
                ? todoBox.getAt(index)!.isCompleted
                : false,
            createdAt: index != null
                ? todoBox.getAt(index)!.createdAt
                : DateTime.now(),
          );

          if (index != null) {
            todoBox.putAt(index, newTodo);
          } else {
            todoBox.add(newTodo);
          }

          setState(() {});
        },
      ),
    );
  }

  void _deleteTodo(int index) {
    todoBox.deleteAt(index);
    setState(() {});
  }

  void _toggleCompletion(int index) {
    final todo = todoBox.getAt(index);
    if (todo != null) {
      todoBox.putAt(
        index,
        Todo(
          title: todo.title,
          description: todo.description,
          isCompleted: !todo.isCompleted,
          createdAt: todo.createdAt,
        ),
      );
      setState(() {});
    }
  }

  void _openTaskDetails(Todo todo, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => TaskDetailsScreen(todoIndex: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todos = todoBox.values.toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 197, 229, 244),
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.task_alt_rounded, size: 28, color: Colors.white),
            SizedBox(width: 10),
            const Text(
              'TaskFlow',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(14),
        ),
      ),
      body: todos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 197, 229, 244),
                      // R,G,B:0-255, opacity: 0.0-1.0
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.inbox_outlined,
                      size: 96,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    'No tasks yet',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimaryLight,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the + button to add your first task',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return TodoTile(
                  todo: todo,
                  onToggle: () => _toggleCompletion(index),
                  onEdit: () => _addTodo(todo: todo, index: index),
                  onDelete: () => _deleteTodo(index),
                  onTap: () => _openTaskDetails(todo, index),
                );
              },
            ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addTodo(),
        backgroundColor: AppColors.primaryDark,
        elevation: 10,
        icon: const Icon(Icons.add_rounded, color: Colors.white, size: 24),
        label: const Text(
          'Add Task',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.4),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
