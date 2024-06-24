import 'package:flutter/material.dart';

class KeyboardWidget extends StatelessWidget {
  final Function(String) onKeyboardTap;
  final VoidCallback onSubmit;
  final VoidCallback onBackspace;
  final VoidCallback onClear;

  const KeyboardWidget({
    Key? key,
    required this.onKeyboardTap,
    required this.onSubmit,
    required this.onBackspace,
    required this.onClear,
  }) : super(key: key);

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
                onKeyboardTap('${index + 1}');
              },
            );
          }),
          KeyboardButtonWidget(
            icon: Icons.backspace_outlined,
            onPressed: onBackspace,
          ),
          KeyboardButtonWidget(
            text: '0',
            onPressed: () {
              onKeyboardTap('0');
            },
          ),
          KeyboardButtonWidget(
            icon: Icons.check_outlined,
            onPressed: onSubmit,
          ),
          KeyboardButtonWidget(
            text: 'C',
            onPressed: onClear,
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
