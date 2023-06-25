import 'package:aplikasi_kepegawaian/pages/login/login_page.dart';
import 'package:aplikasi_kepegawaian/pages/nota_dinas/nota_dinas_page%20copy.dart';
import 'package:aplikasi_kepegawaian/pages/nota_dinas/nota_dinas_page.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/edit_pegawai_page.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/pegawai_page.dart';
import 'package:aplikasi_kepegawaian/pages/sppd/laporan_rekap_sppd.dart';
import 'package:aplikasi_kepegawaian/pages/sppd/sppd_page.dart';
import 'package:aplikasi_kepegawaian/pages/spt/spt_page.dart';
import 'package:aplikasi_kepegawaian/widget/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({super.key});

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? nama;

  getUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        nama = value.get('nama');
      });
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.bars),
                  iconSize: 30,
                  onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Dashboard User',
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selamat Datang",
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    Text(
                      nama.toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Menu Utama",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SptPage(),
                        )),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      height: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
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
                      ),
                      child: Column(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.solidEnvelope,
                            size: 40,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Surat Perintah \nTugas",
                            style: GoogleFonts.poppins(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SppdPage(),
                        )),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      height: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
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
                      ),
                      child: Column(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.solidEnvelope,
                            size: 40,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Surat Perintah \nPerjalanan Dinas",
                            style: GoogleFonts.poppins(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotaDinasPage(),
                        )),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      height: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
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
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const FaIcon(
                            FontAwesomeIcons.solidNoteSticky,
                            size: 40,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Nota Dinas",
                            style: GoogleFonts.poppins(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      String? uid = FirebaseAuth.instance.currentUser?.uid;
                      try {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .get()
                            .then(
                          (value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditPegawaiPage(
                                    title: "Edit Profile",
                                    username: value.get('username'),
                                    nama: value.get('nama'),
                                    nip: value.get('nip'),
                                    pangkat: value.get('golongan'),
                                    jabatan: value.get('jabatan'),
                                    bidang: value.get('bidang'),
                                  ),
                                ));
                          },
                        );
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      height: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
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
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const FaIcon(
                            FontAwesomeIcons.solidUser,
                            size: 40,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Profile",
                            style: GoogleFonts.poppins(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        drawer: const MyDrawer(
          id: '1',
        ));
  }
}
