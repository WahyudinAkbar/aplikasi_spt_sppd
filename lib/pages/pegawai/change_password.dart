import 'package:aplikasi_kepegawaian/pages/login/widget/button.dart';
import 'package:aplikasi_kepegawaian/pages/login/widget/header.dart';
import 'package:aplikasi_kepegawaian/pages/login/widget/input_field.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/pegawai_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constant.dart';

class ChangePassword extends StatefulWidget {
  final String email;
  final String password;
  final String idPegawai;

  const ChangePassword({
    super.key,
    required this.email,
    required this.password,
    required this.idPegawai,
  });

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController emailController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  bool isActiveButton = false;
  int? activeId;
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Password'),
        titleSpacing: 1,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
              onChanged: (value) {
                checkActiveButton();
              },
              controller: newPasswordController,
              text: "Passsword Baru",
              onTap: () {
                setState(() {
                  activeId = 1;
                });
              },
              id: 1,
              activeId: activeId,
              isSecureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Button(
              text: "Ganti Password",
              onTap: () {
                changePassword(newPasswordController.text);
              },
              isActiveButton: isActiveButton,
            ),
          ],
        ),
      )),
    );
  }

  void checkActiveButton() {
    setState(() {
      if (newPasswordController.text.isNotEmpty) {
        isActiveButton = true;
      } else {
        isActiveButton = false;
      }
    });
  }

  void changePassword(String newPassword) async {
    try {
      final key = encrypt.Key.fromUtf8(secret);
      final iv = encrypt.IV.fromLength(16);

      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      final encrypted = encrypter.encrypt(newPassword, iv: iv);

      final cred = EmailAuthProvider.credential(
          email: widget.email, password: widget.password);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: widget.email, password: widget.password);
      await currentUser!.reauthenticateWithCredential(cred).then((value) async {
        await currentUser!.updatePassword(encrypted.base64);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.idPegawai)
            .update({
          'password': encrypted.base64,
        });

        final encryptedAdmin = encrypter.encrypt('wahyu123', iv: iv);

        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: 'admin@gmail.com', password: encryptedAdmin.base64);

        Fluttertoast.showToast(
            msg: "Password Berhasil Diubah",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);

        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PegawaiPage(),
            ));
      }).catchError((err) {
        print(err);
      });
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
    }
  }
}
