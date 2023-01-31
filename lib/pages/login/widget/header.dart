import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String text;

  const Header({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            "assets/logo_kominfo.png",
            width: 150,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Center(
          child: Text(
            "Dinas Komunikasi dan Informatika \nKab Hulu Sungai Selatan",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xff1008ce)),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }
}
