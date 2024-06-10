import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Container Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Container Example'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ExampleContainer(),
          ),
        ),
      ),
    );
  }
}

class ExampleContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10), // Для размещения заголовка
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10), // Пространство для заголовка
              Text(
                'Первая цифра',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
              // Здесь будет ваш слайдер
              SizedBox(height: 20),
              Text(
                'Вторая цифра',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
              // Здесь будет ваш слайдер
            ],
          ),
        ),
        Positioned(
          left: 16,
          top: 0,
          child: Container(
            color: Colors.white, // Цвет фона, чтобы скрыть границу контейнера
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Настройка примера',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
