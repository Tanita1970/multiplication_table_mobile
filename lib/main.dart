import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multiplication_table_mobile/models/multiplication_result.dart';
import 'package:multiplication_table_mobile/models/task.dart';
import 'package:multiplication_table_mobile/providers/settings_provider.dart';
import 'package:multiplication_table_mobile/screens/settings_screen/settings_screen.dart';
import 'package:multiplication_table_mobile/screens/training_screen/training_screen.dart';
import 'package:provider/provider.dart';
import 'repositories/tasks_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Настройка Hive
  await Hive.initFlutter();
  Hive.registerAdapter(MultiplicationResultAdapter()); // Регистрация адаптера
  Hive.registerAdapter(TaskAdapter()); // Регистрация адаптера Task
  await Hive.openBox<MultiplicationResult>(
      'resultsBox'); // Открытие коробки для хранения результатов
  await Hive.openBox<Task>('tasksBox'); // Открытие коробки для хранения задач
  await Hive.openBox('settingsBox'); // Открытие коробки для хранения настроек

  runApp(const MultiplicationTableApp());
}

class MultiplicationTableApp extends StatelessWidget {
  const MultiplicationTableApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TasksManager(
              Hive.box<Task>('tasksBox'), 10), // Пример задания 10 задач
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Learning Multiplication Table',
        color: Colors.white,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const TrainingScreen(),
      routes: [
        GoRoute(
          name: 'settings',
          path: 'settings',
          builder: (context, state) => SettingsScreen(),
        ),
      ],
    ),
  ],
);
