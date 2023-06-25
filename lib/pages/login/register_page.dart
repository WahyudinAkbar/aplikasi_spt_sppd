import 'package:aplikasi_kepegawaian/pages/login/login_page.dart';
import 'package:aplikasi_kepegawaian/pages/login/profile_page.dart';
import 'package:aplikasi_kepegawaian/pages/login/widget/already_have_account_check.dart';
import 'package:aplikasi_kepegawaian/pages/login/widget/button.dart';
import 'package:aplikasi_kepegawaian/pages/login/widget/header.dart';
import 'package:aplikasi_kepegawaian/pages/login/widget/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isActiveButton = false;
  int? activeId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(size.width / 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(
              text: "Register",
            ),
            const SizedBox(
              height: 20,
            ),
            InputField(
              controller: emailController,
              text: "Email",
              onChanged: (value) {
                checkActiveButton();
              },
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
              onChanged: (value) {
                checkActiveButton();
              },
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
            InputField(
              controller: confirmPasswordController,
              text: "Confirm Passsword",
              onChanged: (value) {
                checkActiveButton();
              },
              onTap: () {
                setState(() {
                  activeId = 3;
                });
              },
              id: 3,
              activeId: activeId,
              isSecureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Button(
              text: "Register",
              onTap: () {
                if (passwordController.text != confirmPasswordController.text) {
                  Fluttertoast.showToast(
                      msg: "Konfirmasi Password Tidak Sesuai",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty &&
                    confirmPasswordController.text.isNotEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      ));
                }
              },
              isActiveButton: isActiveButton,
            ),
            const SizedBox(
              height: 20,
            ),
            AlreadyHaveAccountCheck(
                login: false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                }),
          ],
        ),
      )),
    );
  }

  void checkPassword() async {
    if (passwordController.text != confirmPasswordController.text) {}
  }

  void checkActiveButton() {
    setState(() {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty) {
        isActiveButton = true;
      } else {
        isActiveButton = false;
      }
    });
  }
}
