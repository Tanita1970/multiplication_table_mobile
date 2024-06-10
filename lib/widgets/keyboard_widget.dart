import 'package:flutter/material.dart';

class KeyboardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 250,
      child: GridView.count(
        crossAxisCount: 3, // Три кнопки в ряд
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 3.0,
        childAspectRatio: 100 / 60,
        padding: const EdgeInsets.all(3.0),
        children: <Widget>[
          ...List.generate(9, (index) {
            return KeyboardButtonWidget(
              text: '${index + 1}',
              onPressed: () {
                print('Button ${index + 1} pressed');
              },
            );
          }),
          KeyboardButtonWidget(
            icon: Icons.backspace_outlined,
            onPressed: () {
              print('Backspace key pressed');
            },
          ),
          KeyboardButtonWidget(
            text: '0',
            onPressed: () {
              print('Button 0 pressed');
            },
          ),
          KeyboardButtonWidget(
            icon: Icons.check_outlined,
            onPressed: () {
              print('Enter key pressed');
            },
          ),
        ],
      ),
    );
  }
}

class KeyboardButtonWidget extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final VoidCallback onPressed;

  KeyboardButtonWidget({
    this.icon,
    this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(3.0), // Отступы между кнопками
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.1),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(53, 0, 0, 0),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: icon != null
              ? Icon(
                  icon,
                  color: Colors.black,
                  size: 24.0,
                )
              : Text(
                  text ?? '',
                  style: const TextStyle(
                    fontSize:
                        24.0, // Уменьшили размер шрифта, чтобы текст помещался
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
        ),
      ),
    );
  }
}
