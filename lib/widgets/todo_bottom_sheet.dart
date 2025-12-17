import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import 'app_text_field.dart';

import '../models/todo.dart';

class TodoBottomSheet extends StatefulWidget {
  final Todo? todo; // If null => Add, else Edit
  final Function(String title, String description) onSave;

  const TodoBottomSheet({super.key, this.todo, required this.onSave});

  @override
  State<TodoBottomSheet> createState() => _TodoBottomSheetState();
}

class _TodoBottomSheetState extends State<TodoBottomSheet> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo?.title ?? '');
    _descriptionController = TextEditingController(
      text: widget.todo?.description ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTask() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty) return;

    widget.onSave(title, description);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.todo != null;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 16,
        right: 16,
        top: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withAlpha(
              (0.08 * 255).toInt(),
            ), // 0.08 opacity → 20
            blurRadius: 16,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Drag Handle
          Center(
            child: Container(
              width: 44,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withAlpha((0.6 * 255).toInt()),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          /// Header
          Text(
            isEdit ? 'Edit Task' : 'Add Task',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            isEdit
                ? 'Update the details of your task'
                : 'Add a new task to stay organized',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),

          const SizedBox(height: 20),

          /// Title Field
          AppTextField(
            controller: _titleController,
            label: 'Title',
            hint: 'Enter task title',
            icon: Icons.title,
            maxLines: 1,
            minLines: 1,
          ),

          const SizedBox(height: 14),

          /// Description Field
          AppTextField(
            controller: _descriptionController,
            label: 'Description',
            hint: 'Add details',
            icon: Icons.notes_outlined,
            maxLines: 5,
            minLines: 3,
          ),
          const SizedBox(height: 28),

          /// Save/Update Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _saveTask,
              icon: Icon(isEdit ? Icons.edit : Icons.add_task),
              label: Text(
                isEdit ? 'Update Task' : 'Add Task',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                foregroundColor: Colors.white,
                elevation: 6,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}