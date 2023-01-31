import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback onTap;

  const AlreadyHaveAccountCheck({
    super.key,
    required this.login,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
            text: login
                ? "Don't have an account ? "
                : "Already have an Account ? ",
            style: const TextStyle(color: Colors.black),
            children: [
              TextSpan(
                  text: login ? "Sign Up" : "Sign In",
                  style: const TextStyle(color: Color(0xff5F9DF7)),
                  recognizer: TapGestureRecognizer()..onTap = onTap)
            ]),
      ),
    );
  }
}
