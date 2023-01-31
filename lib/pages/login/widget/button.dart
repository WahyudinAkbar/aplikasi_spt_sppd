import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onTap;
  final bool isActiveButton;
  final String text;

  const Button({
    required this.onTap,
    required this.isActiveButton,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: isActiveButton ? onTap : null,
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            backgroundColor: const Color(0xff106bff),
            disabledForegroundColor: Colors.white,
            disabledBackgroundColor: Colors.blue.shade200),
        child: Text(text),
      ),
    );
  }
}
