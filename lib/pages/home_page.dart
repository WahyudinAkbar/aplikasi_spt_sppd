import 'package:aplikasi_kepegawaian/pages/login/login_page.dart';
import 'package:aplikasi_kepegawaian/pages/spt/spt_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: SafeArea(
          child: Column(
        children: [
          Center(
            child: Text('HomePage'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  (MaterialPageRoute(
                    builder: (context) => SptPage(),
                  )));
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: const Color(0xff106bff),
                disabledForegroundColor: Colors.white,
                disabledBackgroundColor: Colors.blue.shade200),
            child: const Text("Login"),
          ),
        ],
      )),
    );
  }
}
