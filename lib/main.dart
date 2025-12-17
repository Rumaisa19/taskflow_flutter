import 'package:flutter/material.dart';
import 'package:to_do_app/core/theme/theme_data.dart';
import 'package:to_do_app/screens/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/todo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Todo adapter
  Hive.registerAdapter(TodoAdapter());

  // Open a box (database)
  await Hive.openBox<Todo>('todosBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modern To-Do',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Use the centralized ThemeData
      home: const SplashScreen(),
    );
  }
}
