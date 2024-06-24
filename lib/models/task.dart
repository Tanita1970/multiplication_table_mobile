class Task {
  final int numOne;
  final int numTwo;
  final int result;

  const Task({
    required this.numOne,
    required this.numTwo,
    required this.result,
  });

  // Это переопределение функции toString() я создала на всякий случай -
  // для возможного контроля в процессе разработки приложения.
  @override
  String toString() {
    return '$numOne * $numTwo = $result';
  }
}
