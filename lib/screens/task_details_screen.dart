//lib/screens/task_details_screen.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/widgets/todo_bottom_sheet.dart';
import '../models/todo.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/constants.dart';

class TaskDetailsScreen extends StatefulWidget {
  final int todoIndex;

  const TaskDetailsScreen({super.key, required this.todoIndex});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late Box<Todo> todoBox;
  late Todo _todo;

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<Todo>('todosBox');
    _todo = todoBox.getAt(widget.todoIndex)!;
  }

  void _toggleCompletion() {
    final updatedTodo = Todo(
      title: _todo.title,
      description: _todo.description,
      isCompleted: !_todo.isCompleted,
      createdAt: _todo.createdAt,
    );

    todoBox.putAt(widget.todoIndex, updatedTodo);

    setState(() {
      _todo = updatedTodo;
    });
  }

  void _deleteTodo() {
    todoBox.deleteAt(widget.todoIndex);
    Navigator.pop(context); // return to home screen
  }

  void _editTodo() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TodoBottomSheet(
        todo: _todo,
        onSave: (title, description) {
          final updatedTodo = Todo(
            title: title,
            description: description,
            isCompleted: _todo.isCompleted,
            createdAt: _todo.createdAt,
          );

          todoBox.putAt(widget.todoIndex, updatedTodo);

          setState(() {
            _todo = updatedTodo;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        '${_todo.createdAt.day}-${_todo.createdAt.month}-${_todo.createdAt.year}';

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 197, 229, 244),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryDark,
        title: Row(
          children: [
            Icon(Icons.task_alt_rounded, size: 28, color: Colors.white),
            SizedBox(width: 10),
            const Text(
              'Task Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // centerTitle: true,
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(14),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              _todo.title[0].toUpperCase() + _todo.title.substring(1),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // Date
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryDark.withAlpha(150),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Description
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _todo.description.isNotEmpty
                      ? _todo.description
                      : 'No description provided.',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Completion Checkbox
            Row(
              children: [
                Checkbox(
                  value: _todo.isCompleted,
                  onChanged: (_) => _toggleCompletion(),
                  activeColor: AppColors.primaryDark,
                  checkColor: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  _todo.isCompleted ? 'Completed!!🎉' : 'Mark as Completed',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _editTodo,
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDark,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.borderRadius,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _deleteTodo,
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.borderRadius,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
