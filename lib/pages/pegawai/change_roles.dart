import 'package:aplikasi_kepegawaian/pages/login/widget/button.dart';
import 'package:aplikasi_kepegawaian/pages/login/widget/header.dart';
import 'package:aplikasi_kepegawaian/pages/login/widget/input_field.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/pegawai_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant.dart';

class ChangeRoles extends StatefulWidget {
  final String idPegawai;
  final String roles;

  const ChangeRoles({
    super.key,
    required this.idPegawai,
    required this.roles,
  });

  @override
  State<ChangeRoles> createState() => _ChangeRolesState();
}

class _ChangeRolesState extends State<ChangeRoles> {
  String? selectedValueRoles;

  bool isActiveButton = false;
  int? activeId;
  var currentUser = FirebaseAuth.instance.currentUser;
  List roles = ['user', 'bendahara', 'kabid'];

  @override
  void initState() {
    super.initState();
    selectedValueRoles = widget.roles;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 1,
        title: Text('Ubah Roles'),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField2(
              value: selectedValueRoles,
              buttonDecoration: BoxDecoration(
                color: const Color(0xffEBECF0),
                borderRadius: BorderRadius.circular(8),
              ),
              decoration: const InputDecoration(
                  border: InputBorder.none, isDense: true),
              hint: Text(
                'Pilih Bidang',
                style: GoogleFonts.poppins(fontSize: 15),
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
              buttonHeight: 50,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              items: roles
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                          ),
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Pilih Bidang';
                }
                return value.toString();
              },
              onChanged: (value) {
                selectedValueRoles = value.toString();
                checkActiveButton();
              },
              onSaved: (value) {
                selectedValueRoles = value.toString();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Button(
              text: "Ganti Roles",
              onTap: () {
                updateRoles();
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
      if (selectedValueRoles!.isNotEmpty &&
          selectedValueRoles != widget.roles) {
        isActiveButton = true;
      } else {
        isActiveButton = false;
      }
    });
  }

  Future updateRoles() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.idPegawai)
          .update({'roles': selectedValueRoles});

      Fluttertoast.showToast(
          msg: "Data Berhasil Diubah",
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
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
