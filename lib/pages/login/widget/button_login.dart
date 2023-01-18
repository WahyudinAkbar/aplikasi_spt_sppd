import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  final VoidCallback onTap;
  final bool isActiveButton;

  const ButtonLogin({
    required this.onTap,
    required this.isActiveButton,
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
        child: const Text("Login"),
      ),
    );
  }
}
