import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final VoidCallback onTap;
  final Function(String)? onChanged;
  final int id;
  final int? activeId;
  final bool isSecureText;

  const InputField({
    required this.controller,
    required this.text,
    required this.onTap,
    required this.id,
    required this.activeId,
    required this.isSecureText,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: id == activeId
                ? Border.all(width: 0.7, color: const Color(0xff5F9DF7))
                : null,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                offset: const Offset(1, 1),
                blurRadius: 7,
                spreadRadius: 1,
              ),
              const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-1, -1),
                  blurRadius: 7,
                  spreadRadius: 1)
            ],
            borderRadius: BorderRadius.circular(8)),
        child: TextFormField(
          onTap: onTap,
          onChanged: onChanged,
          controller: controller,
          cursorColor: Colors.black,
          obscureText: isSecureText,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
              hintText: text,
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey.shade700)),
        ),
      ),
    );
  }
}
