import 'package:aplikasi_kepegawaian/pages/home_pagd.dart';
import 'package:aplikasi_kepegawaian/pages/login/widget/button_login.dart';
import 'package:aplikasi_kepegawaian/pages/login/widget/header.dart';
import 'package:aplikasi_kepegawaian/pages/login/widget/input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isEmailEmpty = true;
  bool isPasswordEmpty = true;
  bool isActiveButton = false;
  int? activeId;

  @override
  void initState() {
    super.initState();

    emailController.addListener(() {
      final isEmailEmpty = emailController.text.isEmpty;

      setState(() {
        this.isEmailEmpty = isEmailEmpty;

        if (isEmailEmpty == false && isPasswordEmpty == false) {
          isActiveButton = true;
        } else {
          isActiveButton = false;
        }
      });
    });

    passwordController.addListener(() {
      final isPasswordEmpty = passwordController.text.isEmpty;

      setState(() {
        this.isPasswordEmpty = isPasswordEmpty;

        if (isEmailEmpty == false && isPasswordEmpty == false) {
          isActiveButton = true;
        } else {
          isActiveButton = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Header(),
            const SizedBox(
              height: 20,
            ),
            InputField(
              controller: emailController,
              text: "Email / Username",
              onTap: () {
                setState(() {
                  activeId = 1;
                });
              },
              id: 1,
              activeId: activeId,
              isSecureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            InputField(
              controller: passwordController,
              text: "Passsword",
              onTap: () {
                setState(() {
                  activeId = 2;
                });
              },
              id: 2,
              activeId: activeId,
              isSecureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonLogin(
              onTap: () {
                signIn(
                  emailController.text,
                  passwordController.text,
                );
              },
              isActiveButton: isActiveButton,
            ),
          ],
        ),
      )),
    );
  }

  void route() {
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      {
        if (documentSnapshot.exists) {
          if (documentSnapshot.get("roles") == "admin") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }
        }
      }
    });
  }

  void signIn(String email, String password) async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('users')
          .where("username", isEqualTo: email)
          .get();

      if (snap.docs.isEmpty) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: snap.docs[0]['email'],
          password: password,
        );
      }
      route();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "Email Belum Terdaftar",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "Email / Password Salah",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        debugPrint(e.code);
        debugPrint(e.message);
      }
    }
  }
}
