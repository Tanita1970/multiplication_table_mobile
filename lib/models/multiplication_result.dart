import 'package:hive/hive.dart';

part 'multiplication_result.g.dart';

@HiveType(typeId: 0)
class MultiplicationResult {
  @HiveField(0)
  final int firstNumber;

  @HiveField(1)
  final int secondNumber;

  @HiveField(2)
  final bool isCorrect;

  MultiplicationResult({
    required this.firstNumber,
    required this.secondNumber,
    required this.isCorrect,
  });
}
