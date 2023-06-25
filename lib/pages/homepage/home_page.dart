import 'package:aplikasi_kepegawaian/widget/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? jumlahNotaDinas;
  String? jumlahSppd;
  String? jumlahSpt;
  String? jumlahPegawai;

  String? nama;

  @override
  void initState() {
    super.initState();
    getUser();
    hitungData();
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
                      'Dashboard Admin',
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
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Jumlah Data',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  )),
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
                      color: Colors.blueAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(1, 1),
                          blurRadius: 7,
                          spreadRadius: 1,
                        ),
                        const BoxShadow(
                            color: Colors.blueAccent,
                            offset: Offset(-1, -1),
                            blurRadius: 7,
                            spreadRadius: 1)
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Surat Perintah Tugas",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        jumlahSpt != null
                            ? Text(
                                '$jumlahSpt',
                                style: GoogleFonts.poppins(color: Colors.white),
                                textAlign: TextAlign.center,
                              )
                            : const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    height: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blueAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(1, 1),
                          blurRadius: 7,
                          spreadRadius: 1,
                        ),
                        const BoxShadow(
                            color: Colors.blueAccent,
                            offset: Offset(-1, -1),
                            blurRadius: 7,
                            spreadRadius: 1)
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Surat Perjalanan Dinas",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        jumlahSppd != null
                            ? Text(
                                '$jumlahSppd',
                                style: GoogleFonts.poppins(color: Colors.white),
                                textAlign: TextAlign.center,
                              )
                            : const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                      ],
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
                      color: Colors.blueAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(1, 1),
                          blurRadius: 7,
                          spreadRadius: 1,
                        ),
                        const BoxShadow(
                            color: Colors.blueAccent,
                            offset: Offset(-1, -1),
                            blurRadius: 7,
                            spreadRadius: 1)
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Nota Dinas",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        jumlahNotaDinas != null
                            ? Text(
                                '$jumlahNotaDinas',
                                style: GoogleFonts.poppins(color: Colors.white),
                                textAlign: TextAlign.center,
                              )
                            : const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    height: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blueAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(1, 1),
                          blurRadius: 7,
                          spreadRadius: 1,
                        ),
                        const BoxShadow(
                            color: Colors.blueAccent,
                            offset: Offset(-1, -1),
                            blurRadius: 7,
                            spreadRadius: 1)
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pegawai",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        jumlahPegawai != null
                            ? Text(
                                '$jumlahPegawai',
                                style: GoogleFonts.poppins(color: Colors.white),
                                textAlign: TextAlign.center,
                              )
                            : const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                      ],
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

  hitungData() async {
    final notaDinas =
        await FirebaseFirestore.instance.collection('nota_dinas').count().get();
    final sppd =
        await FirebaseFirestore.instance.collection('sppd').count().get();
    final spt =
        await FirebaseFirestore.instance.collection('spt').count().get();
    final pegawai =
        await FirebaseFirestore.instance.collection('users').count().get();
    setState(() {
      jumlahNotaDinas = notaDinas.count.toString();
      jumlahSppd = sppd.count.toString();
      jumlahSpt = spt.count.toString();
      jumlahPegawai = pegawai.count.toString();
    });
  }
}
