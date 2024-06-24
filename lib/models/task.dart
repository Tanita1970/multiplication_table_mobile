import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  final int numOne;

  @HiveField(1)
  final int numTwo;

  @HiveField(2)
  final int result;

  Task({
    required this.numOne,
    required this.numTwo,
    required this.result,
  });
}
