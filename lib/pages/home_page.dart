import 'package:aplikasi_kepegawaian/pages/login/login_page.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/pegawai_page.dart';
import 'package:aplikasi_kepegawaian/pages/sppd/sppd_page.dart';
import 'package:aplikasi_kepegawaian/pages/spt/spt_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: FaIcon(FontAwesomeIcons.bars),
              iconSize: 30,
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            ),
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
                    "M Wahyudin Akbar",
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.bold),
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
                Container(
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
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PegawaiPage(),
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
                          FontAwesomeIcons.solidUser,
                          size: 40,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Data Pegawai",
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
      drawer: Drawer(
        child: ListView(children: [
          ListTile(
            leading: FaIcon(FontAwesomeIcons.house),
            title: Text(
              'Beranda',
              style: GoogleFonts.poppins(),
            ),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.solidUser),
            title: Text(
              'Profile',
              style: GoogleFonts.poppins(),
            ),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.arrowRightFromBracket),
            title: Text(
              'Log Out',
              style: GoogleFonts.poppins(),
            ),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.info),
            title: Text(
              'Tentang',
              style: GoogleFonts.poppins(),
            ),
          ),
        ]),
      ),
    );
  }
}
