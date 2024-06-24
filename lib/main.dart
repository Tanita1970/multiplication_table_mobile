import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multiplication_table_mobile/providers/settings_provider.dart';
import 'package:multiplication_table_mobile/screens/settings_screen/settings_screen.dart';
import 'package:multiplication_table_mobile/screens/training_screen.dart';
import 'package:provider/provider.dart';

void main() {
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
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Learning Multiplication Table',
        color: Colors.white,
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
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
