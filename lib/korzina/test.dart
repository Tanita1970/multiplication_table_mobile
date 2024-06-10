



// import 'package:flutter/material.dart';
// import 'package:multiplication_table_mobile/widgets/digit_keyboard.dart';

// void main() {
//   runApp(MultiplicationTableApp());
// }

// class MultiplicationTableApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'The multiplication table',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: CalculatorHomePage(),
//     );
//   }
// }

// class CalculatorHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Учим таблицу умножения'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: DigitKeyboard(),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Learning Multiplication Table',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Learning Multiplication Table'),
//         ),
//         body: GridPaperWidget(),
//       ),
//     );
//   }
// }

// class GridPaperWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 150,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             for (int row = 0; row < 3; row++)
//               Expanded(
//                 child: Row(
//                   children: [
//                     for (int col = 0; col < 10; col++)
//                       Expanded(
//                         child: Container(
//                           margin: EdgeInsets.all(1.0),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey),
//                           ),
//                           child: Center(
//                             child: Text(''),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Learning Multiplication Table',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Learning Multiplication Table'),
//         ),
//         body: GridPaperWidget(
//           digitsOrSymbols: [
//             DigitOrSymbol(position: Offset(2, 1), value: '2'),
//             DigitOrSymbol(position: Offset(3, 1), value: '*'),
//             DigitOrSymbol(position: Offset(4, 1), value: '5'),
//             DigitOrSymbol(position: Offset(5, 1), value: '='),
//             DigitOrSymbol(position: Offset(6, 1), value: '?'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DigitOrSymbol {
//   final Offset position;
//   final String value;

//   DigitOrSymbol({required this.position, required this.value});
// }

// class GridPaperWidget extends StatelessWidget {
//   final List<DigitOrSymbol> digitsOrSymbols;

//   GridPaperWidget({required this.digitsOrSymbols});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 150,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             for (int row = 0; row < 3; row++)
//               Expanded(
//                 child: Row(
//                   children: [
//                     for (int col = 0; col < 10; col++)
//                       Expanded(
//                         child: Container(
//                           margin: EdgeInsets.all(1.0),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                                 color:
//                                     const Color.fromARGB(255, 212, 211, 211)),
//                           ),
//                           child: Center(
//                             child: _buildCellContent(row, col),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCellContent(int row, int col) {
//     final digitOrSymbol = digitsOrSymbols.firstWhere(
//       (digitOrSymbol) =>
//           digitOrSymbol.position == Offset(col.toDouble(), row.toDouble()),
//       orElse: () => DigitOrSymbol(position: Offset.zero, value: ''),
//     );
//     return Text(
//       digitOrSymbol.value,
//       style: TextStyle(fontSize: 30),
//     );
//   }
// }