import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'models/multiplication_result.dart';
import 'models/task.dart';
import 'providers/settings_provider.dart';
import 'repositories/tasks_manager.dart';
import 'screens/settings_screen/settings_screen.dart';
import 'screens/training_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MultiplicationResultAdapter());
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<MultiplicationResult>('resultsBox');
  await Hive.openBox<Task>('tasksBox');

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
              Hive.box<Task>('tasksBox'), 10), // Пример количества примеров
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
      builder: (context, state) => TrainingScreen(),
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
